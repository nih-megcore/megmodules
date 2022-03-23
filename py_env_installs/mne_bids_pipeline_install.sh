conda activate base
mamba create -p /vf/users/MEGmodules/modules/mne_bids_pipeline0.1dev --clone /vf/users/MEGmodules/modules/mne0.24.1
/vf/users/MEGmodules/modules/mne_bids_pipeline0.1dev/bin/pip install -r https://raw.githubusercontent.com/mne-tools/mne-bids-pipeline/main/requirements.txt

mkdir /vf/users/MEGmodules/modules/mne_bids_pipeline0.1dev_extras
mkdir /vf/users/MEGmodules/modules/mne_bids_pipeline0.1dev_extras/scripts

module load git

git clone https://github.com/mne-tools/mne-bids-pipeline.git@a7d1cebcf0f60252529aa079e794c2f658af8ceb /vf/users/MEGmodules/modules/mne_bids_pipeline0.1dev_extras/mne-bids-pipeline --depth 1

chmod +x /vf/users/MEGmodules/modules/mne_bids_pipeline0.1dev_extras/mne-bids-pipeline/run.py

ln -s /vf/users/MEGmodules/modules/mne_bids_pipeline0.1dev_extras/mne-bids-pipeline/run.py /vf/users/MEGmodules/modules/mne_bids_pipeline0.1dev_extras/mne-bids-pipeline/scripts/mne-bids-pipeline-run.py


#Import the scripts folder upon module load
#Prepend the python env/bin folder

