local version = myModuleVersion()
local base = "/vf/users/ML_MEG/python_modules/bstags" .. version

family("bstags")
prepend_path("PATH", pathJoin(base,"bin"))

local omp_nt = os.getenv("OMP_NUM_THREADS") or "1"
pushenv("OMP_NUM_THREADS", omp_nt)

if (mode() == "load") then
    LmodMessage("[+] Loading bstags ",version," ...")
end
if (mode() == "unload") then
    LmodMessage("[-] Unloading bstags ",version," ...")
end
