local system = {}
system.omit = function() rl.SetTraceLogLevel(rl.LOG_NONE) end

function system.init()
    system.omit()
    log.trace('[System] initialized.')
end

function system.close()
    log.trace('[System] closed.')
end

return system
