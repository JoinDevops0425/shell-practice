#!/bin/bash

MOVIES=("court" "HIt" "Ihaveno idea")

echo "the first movies is ${MOVIES[0]}"

echo "all movies${MOVIES[@]}"
echo "all movies${MOVIES[%]}"
echo "all movies${MOVIES[*]}"
