#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jan 13 18:02:20 2022

@author: jstout
"""

import glob
import mne
import os, os.path as op
import copy 
import numpy as np
from mne.datasets import fetch_fsaverage

import numpy as np
from numpy.random import randn
from scipy import stats as stats

from mne.stats import spatio_temporal_cluster_1samp_test

# from mne.stats import spatio_temporal_cluster_test #, summarize_clusters_stc

global topdir

# =============================================================================
# FIX
# Make n_jobs extract from the biowulf thread environemntal variable
# =============================================================================

# def get_morph_to_fsaverage(subject_fs, src):
#     subjects_dir = f'{topdir}/data/SUBJECTS_DIR'
#     from mne.datasets import fetch_fsaverage
#     fetch_fsaverage(subjects_dir, verbose=False)  # ensure fsaverage src exists
#     fname_fs_src = subjects_dir + '/fsaverage/bem/fsaverage-vol-5-src.fif'
    
#     src_fs = mne.read_source_spaces(fname_fs_src)
#     morph = mne.compute_source_morph(
#         src, subject_from=subject_fs, src_to=src_fs, subjects_dir=subjects_dir,
#         verbose=True)
#     return morph

# def return_subj_dsets(subjid, search_dir=None):
#     stc_list=glob.glob(os.path.join(search_dir, subjid+'_*.stc'))
#     t1_dset = f'{subjid}_T1.nii'
#     return {'t1_dset':t1_dset,
#             'stc_list':stc_list}
    

# def process_morphs(subjid):
#     forward = mne.read_forward_solution(f'{topdir}/data/fwds/{subjid}-fwd.fif')    
#     src = forward['src']
#     morph = get_morph_to_fsaverage(subjid, src)
    
#     proc_list = return_subj_dsets(subjid, search_dir=f'{topdir}/output')
#     if not os.path.exists(f'{topdir}/fsave_warped_outputs'): os.mkdir(f'{topdir}/fsave_warped_outputs')
    
#     for fname in proc_list['stc_list']:
#         stc = mne.read_source_estimate(fname)
#         outname = os.path.basename(fname).split('-stc.fif')[0]+'_fsave-vl.stc'
#         morphed_stc = morph.apply(stc, verbose=False)
#         morphed_stc.save(f'{topdir}/fsave_warped_outputs/{outname}')#, src_fs) #f'{topdir}/results/stc_fs_ave_space_subtract/{subjid}_subtract_face_shape.nii', src_fs)
    
# def convert_to_brik(fname):
#     in_base = os.path.basename(fname)
#     out_fname = in_base.replace('.nii','+tlrc.') 
#     out_fname = os.path.join(os.path.dirname(fname), out_fname)
#     if not os.path.exists(out_fname):
#         cmd = f'3dcopy {fname} {out_fname}'
#         subprocess.run(cmd.split())


# mris = glob.glob(f'output/*_T1.nii')
# subjids = [os.path.basename(i).split('_')[0] for i in mris]
# subjids = [i.split('-')[-1] for i in subjids]

# for subjid in subjids:
#     process_morphs(subjid)
    
# for fname in glob.glob(f'fsave_warped_outputs/*.nii'):
#     convert_to_brik(fname)

# =============================================================================
# Get the output morphed STC files
# =============================================================================



# topdir='/fast/BIDS_HV_V1'
# subj_data = glob.glob(f'{outdir}/sub-ON*_7_13_lograt_pow_fsave-vl.stc')
# subj_data=glob.glob(f'{outdir}/sub-ON/fast/OPEN/TEST5/sub-ON*.stc')
# filename=subj_data[0]

# volsrc=mne.read_source_estimate(filename)

def return_subjs_mat(stcs_list):
    '''Provide a list of stc filenames - one per subject
    Returns a numpy array of:
        Subects X time X Space'''
    all_dat_mat = []
    for filename in stcs_list:
        srcest=mne.read_source_estimate(filename)
        all_dat_mat.append(srcest._data)
    
    X = np.stack(all_dat_mat).squeeze()
    #Convert from #N X Spatial X time to #N X Time X Spatial
    X = np.transpose(X, [0, 2, 1])
    return X

def calc_clusters(X, p_threshold=0.001):
    'Returns the cluster variables'
    # From MNE website
    print('Computing adjacency.')
    adjacency = mne.spatial_src_adjacency(src_fs)
    n_subjects = X.shape[0]

    #    Now let's actually do the clustering. This can take a long time...
    #    Here we set the threshold quite high to reduce computation.
    t_threshold = -stats.distributions.t.ppf(p_threshold / 2., n_subjects - 1)
    print('Clustering.')
    clu = spatio_temporal_cluster_1samp_test(X, adjacency=adjacency, n_jobs=10,
                                           threshold=t_threshold, 
                                           buffer_size=None,
                                           verbose=False)
    return clu

def make_cluster_stc(template_stc=None, good_cluster_inds=None):
    '''Copy the template stc
    Zero out the data matrix
    Iterate over clusters with unique color
    
    Returns:
        stc source estimate with spatiotemporal clusters'''
    default_stc = copy.copy(template_stc)
    tmp_ = np.zeros(default_stc._data.shape)
    default_stc._data = tmp_
    for i,clust_idx in enumerate(good_cluster_inds):
        default_stc._data[clusters[clust_idx][1], clusters[clust_idx][0]]=i+1
    return default_stc

def get_fs_src(subjects_dir):
    fetch_fsaverage(subjects_dir, verbose=False)  # ensure fsaverage src exists
    fname_fs_src = subjects_dir + '/fsaverage/bem/fsaverage-vol-5-src.fif'
    src_fs = mne.read_source_spaces(fname_fs_src)
    return src_fs


if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('-topdir', help='The directory w/ stc files')
    parser.add_argument('-search', help='''The search term to find the specific
                        stc files for clustering''', default='*fsave*.stc')
    parser.add_argument('-outfname', help='''Output filename for the cluster
                        nifti file''', default='ClusterOutput.nii')
    parser.add_argument('-subjects_dir', help='''Freesurfer subjects dir.  Will
                        download freesurfer average if not already present.  
                        Defaults to os.environ['SUBJECTS_DIR'] if not provided
                        ''')
    
    #Setup variables
    args = parser.parse_args()
    topdir = args.topdir
    search_term = args.search
    out_fname = args.outfname
    
    if args.subjects_dir:
        subjects_dir=args.subjects_dir
    elif 'SUBJECTS_DIR' in os.environ:
            subjects_dir = os.environ['SUBJECTS_DIR']
    else:
        raise BaseException('Set the bash SUBJECTS_DIR or the commanline input')
    src_fs = get_fs_src(subjects_dir)
        
    #Build source estimate list
    subjs_stcs = glob.glob(op.join(topdir,search_term))
    assert len(subjs_stcs) > 2
    print(f'Using {len(subjs_stcs)} subjects in the cluster analysis')    
    
    filename=subjs_stcs[0]
    default_stc = mne.read_source_estimate(filename)
    
    X = return_subjs_mat(subjs_stcs)
    
    clu = calc_clusters(X)
    T_obs, clusters, cluster_p_values, H0 = clu
    
    good_cluster_inds = np.where(cluster_p_values < 0.05)[0]
    cluster_stc = make_cluster_stc(template_stc=default_stc,
                                   good_cluster_inds=good_cluster_inds)
    cluster_stc.save_as_volume(out_fname, src_fs)
    print(f'Found {len(good_cluster_inds)} clusters of < 0.05 p-value')
    print(f'Saved output to {out_fname}')
    
    

    
                        
                        
                        






















    