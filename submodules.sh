#!/bin/bash

git submodule init android-shm
git submodule init jackd2-opensles
git submodule init jack2

git submodule update android-shm
git submodule update jackd2-opensles
git submodule update jack2