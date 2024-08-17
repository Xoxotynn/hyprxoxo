#!/bin/bash

#--------------------------------#
# import variables and functions #
#--------------------------------#
source ./scripts/functions.sh
if [ $? -ne 0 ]; then
    echo "Error: failed to source functions.sh, please execute from $(dirname $(realpath $0))..."
    exit 1
fi

if ! pkg_installed imagemagick || ! pkg_installed parallel
then
    echo "ERROR : dependency failed, imagemagick and parallel must be installed..."
    exit 0
fi

# set variables
ctlFile="$HOME/.config/hypr/hyprpaper/wallpapers.ctl"
ctlLiSne=`grep '^1|' $ctlFile`
export CacheDir="$HOME/.config/hypr/hyprpaper/.wpCache"

# evaluate options
while getopts "fc" option ; do
    case $option in
    f ) # force remove cache
        rm -Rf ${CacheDir}
        echo "Cache dir ${CacheDir} cleared...";;

    * ) # invalid option
        echo "...valid options are..."
    	echo "./scripts/create_cache.sh -f                      # force create thumbnails (delete old cache)"
        exit 1 ;;
    esac
done

# magick function
imagick_t2 () {
    theme="$1"
    wpFullPath="$2"
    wpName=$(basename ${wpFullPath})

    if [ ! -f "${CacheDir}/${theme}/${wpName}" ]; then
        magick "${wpFullPath}" -thumbnail 500x500^ -gravity center -extent 500x500 "${CacheDir}/${theme}/${wpName}"
    fi

    if [ ! -f "${CacheDir}/${theme}/${wpName}.rofi" ]; then
        magick "${wpFullPath}" -strip -resize 2000 -gravity center -extent 2000 -quality 90 "${CacheDir}/${theme}/${wpName}.rofi"
    fi

    if [ ! -f "${CacheDir}/${theme}/${wpName}.blur" ]; then
        magick "${wpFullPath}" -strip -scale 10% -blur 0x3 -resize 100% "${CacheDir}/${theme}/${wpName}.blur"
    fi

    if [ ! -f "${CacheDir}/${theme}/${wpName}.dcol" ]; then
        magick "${wpFullPath}" -colors 4 -define histogram:unique-colors=true -format "%c" histogram:info: > "${CacheDir}/${theme}/${wpName}.dcol"
    fi
}

# create thumbnails for each theme > wallpapers
export -f imagick_t2
while read ctlLine
do
    theme=$(echo $ctlLine | cut -d '|' -f 2)
    fullPath=$(echo "$ctlLine" | cut -d '|' -f 3 | sed "s|~|$HOME|")
    wallPath=$(dirname "$fullPath")
    mkdir -p ${CacheDir}/${theme}
    mapfile -d '' wpArray < <(find "${wallPath}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -print0 | sort -z)
    echo "Creating thumbnails for ${theme} [${#wpArray[@]}]"
    parallel --bar imagick_t2 ::: "${theme}" ::: "${wpArray[@]}"
done < $ctlFile
