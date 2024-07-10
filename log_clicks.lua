-- log_clicks.lua
-- FlyWithLua script for logging clicked cockpit objects' datarefs or commands

-- Path to the log file
local log_file_path = SCRIPT_DIRECTORY .. "click_log.txt"

-- Function to append log messages to the log file
local function log_to_file(message)
    local file = io.open(log_file_path, "a")
    if file then
        file:write(message .. "\n")
        file:close()
    else
        logMsg("FlyWithLua Error: Unable to open log file for writing.")
    end
end

-- Function to log clicked datarefs or commands
local function log_click(dataref, command)
    local time = os.date("%Y-%m-%d %H:%M:%S")
    if dataref then
        log_to_file(time .. " - Dataref clicked: " .. dataref)
    elseif command then
        log_to_file(time .. " - Command clicked: " .. command)
    end
end

-- Hook function for handling cockpit object clicks
function click_handler()
    local dataref_clicked = getClickedDataref() -- this is outdated for xp12
    local command_clicked = getClickedCommand() -- this is outdated for xp12

    if dataref_clicked then
        log_click(dataref_clicked, nil)
    elseif command_clicked then
        log_click(nil, command_clicked)
    end
end

-- Register the click handler function
do_every_frame("click_handler()")
