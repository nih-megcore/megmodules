always_load('freesurfer') 
always_load('Xvfb')
always_load('mesa')

local version = myModuleVersion()
local base = "/vf/users/MEGmodules/modules/enigma_meg" .. version
local scripts = base .. "_extras/scripts"
local enigma_bin = base .. "_extras/enigma_MEG/extras/bin"

family("enigma_meg")
prepend_path("PATH", pathJoin(base,"bin"))
prepend_path("PATH", scripts)
prepend_path("PATH", enigma_bin)

local omp_nt = os.getenv("OMP_NUM_THREADS") or "1"
pushenv("OMP_NUM_THREADS", omp_nt)

execute{cmd="source $FREESURFER_HOME/SetUpFreeSurfer.sh", modeA={"load"}}

if (mode() == "load") then
    LmodMessage("[+] Loading enigma_meg pipeline ",version," ...")
    LmodMessage("[+] Available Scripts")
    LmodMessage("[+]   process_meg.py")
    LmodMessage("[+]   enigma_prep_QA.py")
    LmodMessage("[+]   Run_enigma_QA_GUI.py")
    LmodMessage("[+]   parse_bids.py")
    LmodMessage("[+]   ")
    LmodMessage("[+]   xvfb_enigma_prep_QA.py")
    LmodMessage("[+]   ")
    LmodMessage("[+]   This version contains megnet integration")
end
if (mode() == "unload") then
    LmodMessage("[-] Unloading enigma_meg  pipeline ",version," ...")
end
setenv("MESA_GL_VERSION_OVERRIDE",3.3)
setenv("MNE_3D_OPTION_ANTIALIAS",'false')
setenv("MNE_3D_OPTION_MULTI_SAMPLES","1")
