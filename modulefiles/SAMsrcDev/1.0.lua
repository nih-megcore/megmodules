always_load('freesurfer')
always_load('afni')
always_load('GSL/2.7_gcc-9.2.0')
always_load('ctf')

local version = '1.0'
family('SAMsrcDEV')

prepend_path('PATH','/data/MEGmodules/modules/SAMsrcV5/bin')


local omp_nt = os.getenv("OMP_NUM_THREADS") or "1"
pushenv("OMP_NUM_THREADS", omp_nt)


if (mode() == "load") then
    LmodMessage("[+] Loading SAMsrcV5 w/ STE delay ",version," ...")
end
if (mode() == "unload") then
    LmodMessage("[-] Unloading SAMsrcV5 w/ STE delay ",version," ...")
end

