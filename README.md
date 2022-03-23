# megmodules
MEG specific modules developed for loading with lmod on a slurm system

`module load modulename`<br>
`module load modulename/module_version`

Additional information can be found at: https://megcore.nih.gov/index.php?title=MEG_analysis_on_Biowulf

## Python environments
  mne/0.24.1 - is  a straightforward install of MNE python using conda.  <br>
  <br>
  Install scripts are located in ./py_env_installs/

## MEG Processing Scripts
  mne_scripts/0.1_dev loads the mne environment and adds commandline callable scripts designed to assist in standard data analysis


## Future Development
-hv_proc for the RV protocol preprocessing and bidsification <br>
-mne_bids_pipeline for running mne_bids_pipeline analysis / w XVFB call <br>
-enigma pipeline <br>
