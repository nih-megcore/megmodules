always_load('freesurfer')
always_load('afni')
local version = myModuleVersion()
local base = "/vf/users/MEGmodules/modules/mne_spyder" 

family("mne_spyder")
prepend_path("PATH", pathJoin(base,"bin"))

local omp_nt = os.getenv("OMP_NUM_THREADS") or "1"
pushenv("OMP_NUM_THREADS", omp_nt)

if (mode() == "load") then
    LmodMessage("[+] Loading mne ",version," ...")
end
if (mode() == "unload") then
    LmodMessage("[-] Unloading mne ",version," ...")
end
