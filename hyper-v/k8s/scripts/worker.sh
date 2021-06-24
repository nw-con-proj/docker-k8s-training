#!/bin/sh

set -e

swapoff -a
/vagrant/share/join-worker.sh
