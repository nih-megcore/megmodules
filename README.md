# megmodules
MEG specific modules developed for loading with lmod on a slurm system

`module load modulename`<br>
`module load modulename/module_version`

Additional information can be found at: https://megcore.nih.gov/index.php?title=MEG_analysis_on_Biowulf

## Python environments
  mne/0.24.1 - is  a straightforward install of MNE python using conda.  <br>
  mne/1.0
  <br>
  mne_scripts - Uses the most recent version of mne on biowulf. 
  <br>
  mne_bids_pipeline - Process bids data
  <br><br>
  Install scripts are located in ./py_env_installs/

## MEG Processing Scripts
  mne_scripts/0.1_dev loads the mne environment and adds commandline callable scripts designed to assist in standard data analysis (bstags, make_mnetrans, make_meg_bids,cluster_stats)
  <br>
  mne_bids_pipeline - Load after creating the bids dataset using mne_scripts module.  Loads XVFB and sets specific variables in the LUA file for processing.


## Future Development
-hv_proc for the RV protocol preprocessing and bidsification <br>
-enigma pipeline <br>
