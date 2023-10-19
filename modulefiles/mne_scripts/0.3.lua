always_load('mne/1.3')
always_load('ctf')

local version = myModuleVersion()
local base = "/vf/users/MEGmodules/modules/mne_scripts" .. version


family("mne_scripts")
prepend_path("PATH", base) 


local omp_nt = os.getenv("SLURM_CPUS_PER_TASK") or "1"
pushenv("OMP_NUM_THREADS", omp_nt)

if (mode() == "load") then
    LmodMessage("[+] Loading mne_scripts ",version," ...")
    LmodMessage("Available:")
    LmodMessage(" spatiotemporal_clustering_stats.py")
    LmodMessage(" make_meg_bids.py")
    LmodMessage(" bstags.py")
    LmodMessage(" calc_mnetrans.py")
    LmodMessage(" make_meg_bids_fromcsv.py")
    LmodMessage(" make_bids_fs_swarm.sh")
    LmodMessage(" megcore_prep_mri_bids.py")
    LmodMessage(" ")
    LmodMessage(" ")

    LmodMessage("WARNING!! - if you run into issues/errors with mixing BIDS versions")
    LmodMessage("do:  module load mne_scripts/0.1_dev or 0.2")
end
if (mode() == "unload") then
    LmodMessage("[-] Unloading mne_scripts ",version," ...")
end
