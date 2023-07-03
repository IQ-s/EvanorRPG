function time()
    local time = getRealTime();
    return "["..(time.monthday).."-"..(time.month+1).."-"..(time.year+1900).."|"..time.hour..":"..time.minute.."]";
end

function saveCoreLog(file, desc)
    local f = fileOpen("logs/"..file..".txt");
    if not f then
        f = fileCreate("logs/"..file..".txt");
    end
    fileSetPos(f, fileGetSize(f));
    fileWrite(f, time().." "..desc:gsub("#%x%x%x%x%x%x", "").."\r");
    fileFlush(f);
    fileClose(f);
end