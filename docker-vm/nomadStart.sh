#!/usr/bin/env bash
nohup ./nomad agent -config nomad.hcl > nomad.out 2>&1 &
