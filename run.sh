#!/bin/bash

Xephyr :2 -ac -br -noreset -screen 1152x720 &
sleep .3;
DISPLAY=:2.0 awesome -c ./rc.lua
