mamba create -p /data/MEGmodules/modules/mne_hcp0.1 conda-forge::mne ipython -y  
conda activate /data/MEGmodules/modules/mne_hcp0.1
/data/MEGmodules/modules/mne_hcp0.1/bin/pip install numpy matplotlib scipy scikit-learn mne joblib pandas

mkdir /data/MEGmodules/modules/mne_hcp0.1_extra
cd /data/MEGmodules/modules/mne_hcp0.1_extra
git clone http://github.com/mne-tools/mne-hcp
/data/MEGmodules/modules/mne_hcp0.1/bin/pip install mne-hcp

