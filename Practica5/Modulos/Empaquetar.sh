#!/bin/bash
nameOfTarball="$2-$(date +%x | tr -d '\')-$(date +%X | tr -d ':')"
cd $1
tar -czf "$nameOfTarball.tgz" "./*"
