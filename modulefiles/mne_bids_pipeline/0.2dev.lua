always_load('freesurfer')
always_load('Xvfb')
always_load('mesa')

local version = myModuleVersion()
local base = "/vf/users/MEGmodules/modules/mne_bids_pipeline" .. version
local scripts = base .. "_extras/scripts"

family("mne_bids_pipeline")
prepend_path("PATH", pathJoin(base,"bin"))
prepend_path("PATH", scripts)

local omp_nt = os.getenv("OMP_NUM_THREADS") or "1"
pushenv("OMP_NUM_THREADS", omp_nt)

if (mode() == "load") then
    LmodMessage("[+] Loading mne_bids_pipeline ",version," ...")
    LmodMessage("[+] Available Scripts")
    LmodMessage("[+]   mne-bids-pipeline-run.py")
end
if (mode() == "unload") then
    LmodMessage("[-] Unloading mne_bids_pipeline ",version," ...")
end
setenv("MESA_GL_VERSION_OVERRIDE",3.3)
setenv("MNE_3D_OPTION_ANTIALIAS",'false')
