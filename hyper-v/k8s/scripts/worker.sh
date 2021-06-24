#!/bin/sh

set -e

swapoff -a
/vagrant/join-worker.sh
