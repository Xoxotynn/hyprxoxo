#!/usr/bin/env sh

# define functions
Wall_Update()
{
    local x_wall="$1"
    local x_update="${x_wall/$HOME/"~"}"
    cacheImg=$(basename "$x_wall")
    $ScrDir/wallbash.sh "$x_wall"

    if [ ! -d "${cacheDir}/${curTheme}" ] ; then
        mkdir -p "${cacheDir}/${curTheme}"
    fi

    if [ ! -f "${cacheDir}/${curTheme}/${cacheImg}" ] ; then
        magick "${x_wall}" -strip -thumbnail 500x500^ -gravity center -extent 500x500 "${CacheDir}/${curTheme}/${cacheImg}"
    fi

    if [ ! -f "${cacheDir}/${curTheme}/${cacheImg}.rofi" ] ; then
        magick "${x_wall}" -strip -resize 2000 -gravity center -extent 2000 -quality 90 "${CacheDir}/${curTheme}/${cacheImg}.rofi"
    fi

    if [ ! -f "${cacheDir}/${curTheme}/${cacheImg}.blur" ] ; then
        magick "${x_wall}" -strip -scale 10% -blur 0x3 -resize 100% "${CacheDir}/${curTheme}/${cacheImg}.blur"
    fi

    sed -i "/^1|/c\1|${curTheme}|${x_update}" "$ctlFile"
    ln -fs "$x_wall" "$wallSet"
    ln -fs "${cacheDir}/${curTheme}/${cacheImg}.rofi" "$wallRfi"
    ln -fs "${cacheDir}/${curTheme}/${cacheImg}.blur" "$wallBlr"
}

Wall_Change()
{
    local x_switch=$1

    for (( i=0 ; i<${#Wallist[@]} ; i++ ))
    do
        if [ "${Wallist[i]}" == "${fullPath}" ] ; then

            if [ $x_switch == 'n' ] ; then
                nextIndex=$(( (i + 1) % ${#Wallist[@]} ))
            elif [ $x_switch == 'p' ] ; then
                nextIndex=$(( i - 1 ))
            fi

            Wall_Update "${Wallist[nextIndex]}"
            break
        fi
    done
}

Wall_Set()
{
    hyprctl hyprpaper wallpaper ",$(realpath $wallSet)"
    sed -i "s|^wallpaper.*$|wallpaper = ,$(realpath $wallSet)|" $HOME/.config/hypr/hyprpaper.conf
}


# set variables
ScrDir=`dirname $(realpath $0)`
source $ScrDir/globalcontrol.sh
ctlFile="$HOME/.config/hypr/hyprpaper/wallpapers.ctl"
wallSet="$HOME/.config/hypr/hyprpaper/wall.set"
wallBlr="$HOME/.config/hypr/hyprpaper/wall.blur"
wallRfi="$HOME/.config/hypr/hyprpaper/wall.rofi"
ctlLine=`grep '^1|' $ctlFile`

if [ `echo $ctlLine | wc -l` -ne "1" ] ; then
    echo "ERROR : $ctlFile Unable to fetch theme..."
    exit 1
fi

curTheme=$(echo "$ctlLine" | cut -d '|' -f 2)
fullPath=$(echo "$ctlLine" | cut -d '|' -f 3 | sed "s|~|$HOME|")
wallName=$(basename "$fullPath")
wallPath=$(dirname "$fullPath")
mapfile -d '' Wallist < <(find ${wallPath} -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -print0 | sort -z)

if [ ! -f "$fullPath" ] ; then
    if [ -d "$HOME/.config/hypr/hyprpaper/$curTheme" ] ; then
        wallPath="$HOME/.config/hypr/hyprpaper/$curTheme"
        mapfile -d '' Wallist < <(find ${wallPath} -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -print0 | sort -z)
        fullPath="${Wallist[0]}"
    else
        echo "ERROR: wallpaper $fullPath not found..."
        exit 1
    fi
fi


# evaluate options
while getopts "nps" option ; do
    case $option in
    n ) # set next wallpaper
        Wall_Change n ;;
    p ) # set previous wallpaper
        Wall_Change p ;;
    s ) # set input wallpaper
        shift $((OPTIND -1))
        if [ -f "$1" ] ; then
            Wall_Update "$1"
        fi ;;
    * ) # invalid option
        echo "n : set next wall"
        echo "p : set previous wall"
        echo "s : set input wallpaper"
        exit 1 ;;
    esac
done


# set wallpaper
Wall_Set
