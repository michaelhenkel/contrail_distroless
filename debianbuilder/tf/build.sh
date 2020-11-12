#!/bin/sh
docker build -t michaelhenkel/debianbuilder:tf .
docker push michaelhenkel/debianbuilder:tf
