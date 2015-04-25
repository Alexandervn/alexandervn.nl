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
s3cmd sync --acl-public --add-header 'Content-Encoding:gzip' --exclude '*.*' --include '*.html' --include '*.css' --include '*.js' --include '*.svg' --include '*.txt' build/ s3://blog.alexandervn.nl

# Media-like files
s3cmd sync --acl-public --exclude '*.*' --include '*.pdf' --include '*.dot' --include '*.jpg' --include '*.png' build/ s3://blog.alexandervn.nl

# Clean up
s3cmd sync --acl-public --delete-removed build/ s3://blog.alexandervn.nl
