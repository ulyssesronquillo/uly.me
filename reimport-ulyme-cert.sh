#!/bin/bash

cd /etc/letsencrypt/live/uly.me

aws acm import-certificate --certificate fileb://cert.pem \
--certificate-chain fileb://fullchain.pem \
--private-key fileb://privkey.pem \
--certificate-arn arn:aws:acm:us-east-1:203698412332:certificate/6947b6cb-b076-4b70-9a3d-a75be7178db5

