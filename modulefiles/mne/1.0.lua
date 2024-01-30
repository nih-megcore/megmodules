always_load('freesurfer')
always_load('afni')
always_load('mesa')
local version = myModuleVersion()
local base = "/vf/users/MEGmodules/modules/mne" .. version

family("mne")
prepend_path("PATH", pathJoin(base,"bin"))

local omp_nt = os.getenv("SLURM_CPUS_PER_TASK") or "1"
pushenv("OMP_NUM_THREADS", omp_nt)
setenv("MESA_GL_VERSION_OVERRIDE",3.3)
setenv("MNE_3D_OPTION_ANTIALIAS",'false')

if (mode() == "load") then
    LmodMessage("[+] Loading mne ",version," ...")
end
if (mode() == "unload") then
    LmodMessage("[-] Unloading mne ",version," ...")
end
