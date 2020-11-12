#!/bin/sh
docker build -t michaelhenkel/debianbuilder:binaries .
docker push michaelhenkel/debianbuilder:binaries
