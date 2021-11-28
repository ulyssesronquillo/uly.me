#!/bin/bash

aws acm resend-validation-email --certificate-arn arn:aws:acm:us-east-1:203698412332:certificate/f0cec0cf-1816-4d8a-9305-24fcbb597391 \
--domain ulyssesronquillo.com \
--validation-domain ulyssesronquillo.com

aws acm resend-validation-email --certificate-arn arn:aws:acm:us-east-1:203698412332:certificate/f0cec0cf-1816-4d8a-9305-24fcbb597391 \
--domain www.ulyssesronquillo.com \
--validation-domain www.ulyssesronquillo.com

