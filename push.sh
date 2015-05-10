#!/bin/bash

# Gzip
echo '- Gzip'

find build/ -iname '*.html' -exec gzip -n {} +
find build/ -iname '*.js' -exec gzip -n {} +
find build/ -iname '*.css' -exec gzip -n {} +
find build/ -iname '*.svg' -exec gzip -n {} +
find build/ -iname '*.txt' -exec gzip -n {} +
find build/ -iname '*.gz' -exec rename 's/\.gz$//i' {} +

# S3
echo '- S3'

# Text-like files
aws s3 sync build/ s3://alexandervn.nl --acl public-read --content-encoding 'gzip' --exclude '*.*' --include '*.html' --include '*.css' --include '*.js' --include '*.svg' --include '*.txt' --delete --region eu-central-1

# Media-like files
aws s3 sync build/ s3://alexandervn.nl --acl public-read --exclude '*.*' --include '*.pdf' --include '*.dot' --include '*.jpg' --include '*.png' --delete --region eu-central-1
