#!/bin/sh
UUID=$(id -u)
UUID=$(( UUID + 0 ))
I_OK="✔"
I_KO="✖️"


NC='\e[0m'
if [ $UUID != 0 ]; then
        echo "${I_KO}    Start the Script as 'root' for it to work properly    ${I_KO}";
        exit 1;
else
    apk add curl wget unzip
    mkdir -p /tmp/deno
    rm -v /tmp/deno/*
    cd /tmp/deno
    wget https://api.github.com/repos/sgerrand/alpine-pkg-glibc/releases/latest -O - | awk -F \" -v RS="," '/browser_download_url/ {print $(NF-1)}' | xargs wget
    se=$(ls *.apk | tr '\n' ' ')
    apk --allow-untrusted add $se
    wget --no-cache -O -  https://api.github.com/repos/denoland/deno/releases/latest | grep deno-x | grep linux | awk -F \" -v RS="," '/browser_download_url/ {print $(NF-1)}' | xargs wget --no-cache -O /tmp/deno/denoLatest.zip
    unzip /tmp/deno/denoLatest.zip 
    mv -v /tmp/deno/deno /usr/bin/deno
    chmod -v 777 /usr/bin/deno
    rm -v /tmp/deno/* 
    cd 
fi
