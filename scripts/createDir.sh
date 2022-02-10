#!/bin/bash

#Objs directory
if  [ ! -d ./objs ]                 \
    || [ ! -d ./objs/example ]      \
    || [ ! -d ./objs/log ]         \
    || [ ! -d ./libs ]              \
    || [ ! -d ./execute ]              
then
    echo "Creating directories..."
    mkdir -p objs objs/example objs/log libs execute
    echo "Directories created!"
fi