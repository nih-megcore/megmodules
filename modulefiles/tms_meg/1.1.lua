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
    LmodMessage("Info on scripts: https://github.com/jstout211/TMS_MEG")
    LmodMessage(" ")
    LmodMessage("Available processing commands: (COMMAND_NAME.py -h for info)")
    LmodMessage(" trigger_eval.py")
    LmodMessage(" plot_M100.py")
    LmodMessage(" plot_M100_src.py <BIDS_ID>")
    LmodMessage(" fix_dsname.py <MEG.ds>")
    LmodMessage(" ASSR_processing_bids.py")
    LmodMessage(" M100_processing_bids.py")
    LmodMessage(" MMF_processing_bids.py")
    LmodMessage(" ")
    LmodMessage("Bash Scripts:")
    LmodMessage(" bids_loop.sh <SOURCE_ID> (from BIDS/source_data)")


end
if (mode() == "unload") then
    LmodMessage("[-] Unloading tms_meg_scripts ",version," ...")
end
