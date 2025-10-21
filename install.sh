#!/bin/bash

destination_dir="$1"
assets_dir="$2" 
repo_dir="$3" 


rtcCheck() {
  rtc=$1
  if [ $rtc -ne 0 ]; then
    echo "Error: Command failed with return code $rtc"
    exit $rtc
  fi
}

# write log file
LOGFILE="install_$(date "+%Y%M%d_%H%M%S").log"
exec > >(tee -a "$LOGFILE") 2>&1


if [ -z "$destination_dir" ] || [ -z "$assets_dir" ] || [ -z "$repo_dir" ]; then
  echo "Usage: $0 <destination_dir> <assets_dir> <repo_dir>"
  exit 1
fi

if [ ! -d "$destination_dir" ]; then
  echo "Error: Destination directory '$destination_dir' does not exist."
  exit 2
fi

if [ ! -d "$assets_dir" ]; then
  echo "Error: Assets directory '$assets_dir' does not exist."
  exit 3
fi

if [ ! -d "$repo_dir" ]; then
  echo "Error: Repository directory '$repo_dir' does not exist."
  exit 4
fi

if ls $assets_dir/*.png > /dev/null 2>&1; then
  echo "* New assets found. Convert it to smaller sizes and move it to destination directory"
  echo ""
  for img in $assets_dir/*.png; do
    filename=$(basename "$img")
    echo "FILE: $filename"
    echo "Convert..."
    convert -verbose -resize 5% "$img" "$assets_dir/small_$filename"
    echo ""

    echo "Move..."
    mv -v "$img" "$destination_dir/img/original/"
    rtcCheck $?
    mv -v "$assets_dir/small_$filename" "$destination_dir/img/small/$filename"
    rtcCheck $?
    echo ""
    echo ""
  done
fi

echo "* Building the project..."
cd $repo_dir 
npm install
rtcCheck $?
npm run build
rtcCheck $?

cd dist || {
  echo "Error: 'dist' directory does not exist after build."
  exit 5
}

echo ""
echo "* Deploying build to '$destination_dir'..."
cp -rv ./* "$destination_dir/"
rtcCheck $?

