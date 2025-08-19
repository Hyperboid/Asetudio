local tty = (io.popen("tty"):read("*a"))
local in_channel, out_channel= require('threadsetup')(function(options)
    COMMAND = "\"" .. table.concat(options.commandline, "\" \"") .. "\""
    print("Preparing to start process: "..COMMAND)
    if not options.osexec then
        print("Starting process: "..COMMAND)
        ---@type file?
        PROCESS_STDIO = io.popen( COMMAND .. " 2>" .. tty)
    end
    verbose = options.verbose or false
end)

if PROCESS_STDIO == nil then
    print("Starting process: "..COMMAND)
    return os.execute(COMMAND .. " 2>"..tty)
end
for line in PROCESS_STDIO:lines("L") do
    out_channel:push(line:sub(1,#line-1))
    if verbose then
        io.stdout:write(line)
    end
    io.stdout:flush()
    io.stderr:flush()
end
