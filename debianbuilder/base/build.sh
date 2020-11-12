#!/bin/sh
docker build -t michaelhenkel/debianbuilder:base .
docker push michaelhenkel/debianbuilder:base
