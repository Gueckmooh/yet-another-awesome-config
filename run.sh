#!/bin/bash

Xephyr :1 -ac -br -noreset -screen 1152x720 &
sleep .3;
DISPLAY=:1.0 awesome -c ./rc.lua
