#!/usr/bin/env sh
nohup ./nomad agent -config nomad.hcl > nomad.out 2>&1 &
