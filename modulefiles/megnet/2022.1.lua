local version = myModuleVersion()
local base = "/vf/users/MEGmodules/modules/megnet" .. version

family("MEGnet")
prepend_path("PATH", pathJoin(base,"bin"))

local omp_nt = os.getenv("OMP_NUM_THREADS") or "1"
pushenv("OMP_NUM_THREADS", omp_nt)

if (mode() == "load") then
    LmodMessage("[+] Loading MEGnet ",version," ...")
    LmodMessage("[+] Available: ")
    LmodMessage("[+]   ICA.py")
end
if (mode() == "unload") then
    LmodMessage("[-] Unloading MEGnet ",version," ...")
end
