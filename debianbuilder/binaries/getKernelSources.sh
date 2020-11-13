#!/bin/bash
for kernel in $(jq '. | keys | .[]' kernellist.json); do
	package=$(jq -r ".[$kernel].package" kernellist.json)
	filetype=$(jq -r ".[$kernel].filetype" kernellist.json)
	kernelpath=$(jq -r ".[$kernel].kernelpath" kernellist.json)
	case $filetype in
		"RPM")  
			curl -s -OL ${package}
			rpm2cpio $(basename ${package}) |cpio -idmv
		;;
		"DEB")
			apt-get install -y ${package}
		;;
	esac
	echo ${kernelpath} >> /kernellist
done
