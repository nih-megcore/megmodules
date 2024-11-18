always_load('freesurfer')
always_load('afni')
always_load('mesa')
always_load('ctf')


local version = myModuleVersion()
local base = '/data/MEGmodules/modules/meg_workshop_2024'


family("meg_workshop")
prepend_path("PATH", pathJoin(base,"bin"))
prepend_path("PATH", '/data/MEGmodules/modules/meg_workshop_2024_extras/NIMH_MEG_workshop/bin')

local omp_nt = os.getenv("SLURM_CPUS_PER_TASK") or "1"
pushenv("OMP_NUM_THREADS", omp_nt)
setenv("MESA_GL_VERSION_OVERRIDE",3.3)
setenv("MNE_3D_OPTION_ANTIALIAS",'false')
setenv("MNE_3D_OPTION_MULTI_SAMPLES","1")
setenv("n_jobs", omp_nt)

if (mode() == "load") then
    LmodMessage("[+] Loading MEG workshop ",version," ...")
    LmodMessage("")
    LmodMessage("")
    LmodMessage("Run the below and open the Web Broser under Applications (top left)")
    LmodMessage("sinteractive --mem=16G --cpus-per-task=8 --gres=lscratch:100")
    LmodMessage("")
    LmodMessage("Instructions on https://github.com/nih-megcore/NIMH_MEG_workshop")
end
if (mode() == "unload") then
    LmodMessage("[-] Unloading MEG workshop ",version," ...")
end
