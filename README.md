# OSX VPN AutoConnect
A set of scripts to provide persistent (always connected) VPN behavior. It consists of an Apple script and a helper shell script:

* autovpn.applescript
* autovpn.sh

You may have multiple (native) VPN configurations on your Mac. This tools
help you to switching between multiple VPN configurations and making one of
them persistent by issuing a command from terminal. The latest switched
configuration and its status remembered by the scripts and stays persistent
even if the computer gets sleep (or restart when you put application into startup).

## Requirements
You should create an application version of the applescript. You can refer
to blog page of this project to create application version of the applescript:

http://clxdev.wordpress.com/2014/03/30/osx-vpn-autoconnect

## Running
The interactive part of the project:

	autovpn.sh [start|stop] [interface]

* start [interface]:
It starts persistent behavior. If interface name was not given then last switched configuration will be used.

* stop:
Stops persistent behavior. 

* interface:
Starts persistent behavior for specified configuration. This is actually same with:

	> autovpn.sh start interface

## Details
These scripts are linked to each other via the following temporary files:

	vpn.default : Holds last switched configuration name.
	vpn.status  : Holds last given action (start or stop).

You should edit scripts and make changes for temp-files and full-path of the application before use. Default values are as follows:

	app="/opt/devel/local/app/autovpn.app"
	def="/opt/devel/etc/vpn.default"
	sta="/opt/devel/etc/vpn.status"

