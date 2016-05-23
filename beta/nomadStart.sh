#!/usr/bin/env sh
nohup ./nomad agent -config beta.hcl > nomad.out 2>&1 &
