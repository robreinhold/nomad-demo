#!/usr/bin/env sh
nohup ./nomad agent -config alpha.hcl > nomad.out 2>&1 &
