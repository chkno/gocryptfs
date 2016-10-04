#!/bin/bash

set -eu

cd "$(dirname "$0")"

source build.bash

go test ./... $*

# Clean up after ourself, but don't descend into possibly still mounted
# example filesystems.
# The tests cannot to this themselves as they are run in parallel
rm -Rf --one-file-system /tmp/gocryptfs-test-parent

if go tool | grep vet > /dev/null ; then
	go tool vet -all -shadow .
else
	echo "\"go tool vet\" not available - skipping"
fi
