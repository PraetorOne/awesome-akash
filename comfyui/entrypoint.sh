#!/usr/bin/env bash

echo "$MODELURLS"
echo "$VAEURLS"
echo "$UPSCALEURLS"
echo "$COMMANDLINE_ARGS"
echo "$ENABLE_MANAGER"

if [ -z "$ENABLE_MANAGER" ]; then
    echo "Env variable 'ENABLE_MANAGER' is not set. Will not install ComfyUI-Manager"
else    
    cd "/comfyui/custom_nodes"
    git clone "https://github.com/ltdrdata/ComfyUI-Manager.git"
    cd /
fi

# split string into array
IFS=',' read -r -a URLS <<< "$MODELURLS"

# loop through array
for modelurl in "${URLS[@]}"
do
    # wget the file
    wget -nv $modelurl -P /comfyui/models/checkpoints
done

# split string into array
IFS=',' read -r -a VAEURLS <<< "$VAEURLS"

# loop through array
for url in "${VAEURLS[@]}"
do
    # wget the file
    wget -nv $url -P /comfyui/models/vae
done

# split string into array
IFS=',' read -r -a UPSCALEURLS <<< "$UPSCALEURLS"

# loop through array
for url in "${UPSCALEURLS[@]}"
do
    # wget the file
    wget -nv $url -P /comfyui/models/upscale_model
done

echo "Starting ComfyUI ..."
python /comfyui/main.py $COMMANDLINE_ARGS

