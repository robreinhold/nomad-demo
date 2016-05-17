#!/usr/bin/env bash
nohup consul agent -data-dir /tmp/consul -bootstrap -dc mac -log-level debug -server -ui > consul.out &
