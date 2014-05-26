#!/bin/bash
tiempo="$(date +%X | cut -d':' -f1)$(date +%X | cut -d':' -f2)"
nameOfTarball="$2-$(date +%x | tr -d '/')-$tiempo"
cd $1
tar -czf "$nameOfTarball.tgz" "."
