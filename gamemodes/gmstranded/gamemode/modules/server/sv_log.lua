SGS.logfile = nil

if !file.Exists( "SGStranded/Logs", "DATA" ) then
	file.CreateDir( "SGStranded/Logs" )
end

function SGS.CheckLogFile()
	SGS.logfile = os.date( "SGStranded/Logs/" .. "%m-%d-%y" .. ".txt" )
	if !file.Exists( SGS.logfile, "DATA" ) then
		file.Write( SGS.logfile, "" )
	end
end

function SGS.Log( str, console )
	SGS.CheckLogFile()
	local date = os.date( "*t" )
	local dlog = string.format( "[%02i:%02i:%02i] ", date.hour, date.min, date.sec )
	file.Append( SGS.logfile, dlog .. str .. "\n" )
	
	if console then
		ServerLog( "SGS: " .. str .. "\n" )
	end
end