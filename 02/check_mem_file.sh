#!/bin/bash

MIN_FREE_SPACE_GB=1
FREE_SPACE=$(df -BG / | awk 'NR==2 {print $4}' | tr -d 'G')
if  [ "$FREE_SPACE" -le "$MIN_FREE_SPACE_GB" ]; then
exit 1
fi

