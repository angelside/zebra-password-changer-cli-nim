# Switches
switch("define", "release")
switch("define", "useMalloc")
switch("gc", "arc")
switch("passL", "-s")
switch("app", "console")
switch("nimcache", "nimcache")
switch("opt", "size")
switch("out", "./bin/zebra-password-changer")
#hint("Processing", false) # Do not print the "Hint: .. [Processing]" messages when compiling

if getEnv("NIM_HINTS") == "true":
    switch("hints", "on")
else:
    switch("hints", "off")


task upx, "Optimize the binary size using 'upx' utility":
    try:
        exec "upx --best ./bin/zebra-password-changer"
    except OSError as e:
        echo ""
        echo "[ERROR]: ", e.msg

