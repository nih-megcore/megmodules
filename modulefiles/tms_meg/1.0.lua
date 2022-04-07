always_load('freesurfer')
local version = myModuleVersion()
local scripts_base = "/vf/users/MEGmodules/modules/tms_meg_code" .. version .. "_extras"
local env_base = "/vf/users/MEGmodules/modules/tms_meg_code" .. version

family("tms_meg_scripts")
prepend_path("PATH", scripts_base)
prepend_path("PATH", pathJoin(env_base, "bin")) 

local omp_nt = os.getenv("OMP_NUM_THREADS") or "1"
pushenv("OMP_NUM_THREADS", omp_nt)

if (mode() == "load") then
    LmodMessage("[+] Loading tms_meg_scripts ",version," ...")
    LmodMessage("Available:")
    LmodMessage(" trigger_eval.py")
end
if (mode() == "unload") then
    LmodMessage("[-] Unloading tms_meg_scripts ",version," ...")
end
