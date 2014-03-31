on idle
	try
		do shell script "ping -o www.apple.com"
		tell application "System Events"
			tell current location of network preferences
				set _fsta to (POSIX file ("/opt/devel/etc/vpn.status"))
				set _vsta to first item of (read _fsta using delimiter linefeed)
				if _vsta is equal to "start" then
					set _fdef to (POSIX file ("/opt/devel/etc/vpn.default"))
					set _vdef to first item of (read _fdef using delimiter linefeed)
					if _vdef is not equal to "" then
						set _vpn to the service _vdef
						if _vpn is not null then
							if current configuration of _vpn is not connected then
								connect _vpn
							end if
						end if
					end if
				end if
			end tell
			return 10
		end tell
	on error
		return 15
	end try
end idle