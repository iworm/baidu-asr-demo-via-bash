#!/bin/bash

# curl "https://openapi.baidu.com/oauth/2.0/token?grant_type=client_credentials&client_id=pfc0GjdMjMIPHSfOLWzqcRBw&client_secret=5baa883465b2a70cf119f6ef75c9b861"

wavFile=$1
if [ ! -n "$wavFile" ]; then
    echo "No wav file found."
    exit
fi

wavSize=$(du -b $wavFile | awk '{print $1}')
wavContent=$(base64 -w 0 $wavFile)

curl "http://vop.baidu.com/server_api" -H "Content-Type:application/json" -d "
{
    \"format\": \"pcm\",
    \"rate\": 16000,
    \"channel\": 1,
    \"cuid\": \"roger\",
    \"token\": \"24.ce6bfc1920fa9bf30c21baabf122c2ae.2592000.1443682559.282335-6748457\",
    \"speech\": \"$wavContent\",
    \"len\": $wavSize
}" | iconv -f utf-8 -t gb2312
