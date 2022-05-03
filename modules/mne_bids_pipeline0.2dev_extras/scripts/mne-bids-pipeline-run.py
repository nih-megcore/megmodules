export XDG_RUNTIME_DIR=/lscratch/$SLURM_JOB_ID
if [ ! -d $XDG_RUNTIME_DIR ]
then 
echo '!!No Scratch has been allocated to support report generation (needed for Xvfb)!!'
echo Allocate an sinteractive with --gres=lscratch:#Gigs
echo for example:  
echo '     sinteractive --mem=24G --cpus-per-task=12 --gres=lscratch:10'
exit 0
fi
#Xvfb :1 -screen 0 1280x1024x24 -auth localhost&
#export DISPLAY=:1
export DISPLAY=:$(get_freeservernum.sh)
echo $DISPLAY
Xvfb ${DISPLAY} -screen 0 1280x1024x24 -auth localhost&
export THE_PID=$!

#Process the script
/vf/users/MEGmodules/modules/mne_bids_pipeline0.2dev_extras/mne-bids-pipeline/run.py $@ 

#Kill the screen session
kill -15 $THE_PID
#Xvfb :1 -screen 0 1280x1024x24 -auth localhost&

