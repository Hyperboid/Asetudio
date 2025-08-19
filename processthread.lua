local in_channel, out_channel= require('threadsetup')(function(options)
    PROCESS = io.popen( "\"" .. table.concat(options.commandline, "\" \"") .. "\"")
end)

for line in PROCESS:lines() do
    out_channel:push(line)
end
