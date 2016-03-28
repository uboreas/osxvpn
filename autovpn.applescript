on idle
	try
		do shell script "ping -o www.apple.com"
		tell application "System Events"
			set _fsta to (POSIX file ("/opt/devel/etc/vpn.status"))
			set _vsta to first item of (read _fsta using delimiter linefeed)
			if _vsta is equal to "start" then
				set _fdef to (POSIX file ("/opt/devel/etc/vpn.default"))
				set _vdef to first item of (read _fdef using delimiter linefeed)
				if _vdef is not equal to "" then
					set _vpn to _vdef
					set rc to do shell script "scutil --nc status " & _vpn
					if rc starts with "Disconnected" then
						do shell script "scutil --nc start " & _vpn
					end if
				end if
			end if
			return 10
		end tell
	on error
		return 15
	end try
end idle