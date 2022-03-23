always_load('mne')
local version = myModuleVersion()
local base = "/vf/users/MEGmodules/modules/mne_scripts" .. version

family("mne_scripts")
prepend_path("PATH", base) 

local omp_nt = os.getenv("OMP_NUM_THREADS") or "1"
pushenv("OMP_NUM_THREADS", omp_nt)

if (mode() == "load") then
    LmodMessage("[+] Loading mne_scripts ",version," ...")
    LmodMessage("Available:")
    LmodMessage(" spatiotemporal_clustering_stats.py")
end
if (mode() == "unload") then
    LmodMessage("[-] Unloading mne_scripts ",version," ...")
end
