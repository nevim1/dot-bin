#!/usr/bin/env bash

dir=$(cd "$(dirname "$0")"; pwd)

mkdir -p ~/.local/bin

# go over all files in this repo
for i in $(ls -A "$dir"); do
	# skip markdowns, git files and this script
	mi=$( echo $i | sed -r -e s/.*\.md// -e s/^\.git\(i.*$\|$\)// -e s/setup\.sh// )
	if [[ ! -z $mi ]] then
		# check if it already exists in home folder
		if [ -f ~/.local/bin/$mi ]; then
			echo $mi was found in your local bins.
			if read -p "Replace it? (y/N) " conf && [[ "$conf" =~ ^[yY]([eE][sS]?)?$ ]]; then
				mv ~/.local/bin/$mi ~/.local/bin/."$mi".old
				ln -s "$dir)"/$mi ~/.local/bin/$mi
				echo the old version was moved to ~/.local/bin/."$mi".old
			fi
		else
			echo whot "$dir"/$mi
			ln -s "$dir"/$mi ~/.local/bin/$mi
		fi
	fi
done
