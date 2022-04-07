mamba create -p /data/MEGmodules/modules/tms_meg_code1.0 conda-forge::mne main::ipython main::jupyter main::pip -y 
pip_call=/data/MEGmodules/modules/tms_meg_code1.0/bin/pip
${pip_call} install git+https://github.com/nih-megcore/hv_proc
${pip call} install git+https://github.com/nih-megcore/nih_to_mne


git clone https://github.com/jstout211/TMS_MEG /data/MEGmodules/modules/tms_meg_code1.0_extras
