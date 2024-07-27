#!/usr/bin/env sh

OPTSTRING=":hm:v:"
MAC=""
VOLUME=70

function print_info
{
  cat << "EOF"
    ./autobluetooth.sh -[-m|v] <arguments>
    -h,   help
    -m,   set mac address of device(required)
    -v,   set volume
          (default: 70)
EOF
}

while getopts $OPTSTRING option; do
  case ${option} in
    h)
      print_info
      exit;;
    m)
      MAC=$OPTARG
      ;;
    v)
      if ! [[ $OPTARG =~ ^[0-9]+$ ]] ; then
        echo "./autobluetooth.sh: -v arg must be an integer" >&2
        exit 1
      fi
      VOLUME=$OPTARG
      ;;
    ?)
      exit 1
      ;;
  esac
done

# connecting speaker
bluetoothctl connect ${MAC}

# show connected notification
DEVICE=($(bluetoothctl devices))
DEVICENAME="${DEVICE[2]}"
for (( i=3;i<${#DEVICE[@]};i++)); do
  DEVICENAME="${DEVICENAME} ${DEVICE[${i}]}"
done

dunstify "t2" -a "Speaker connected" "${DEVICENAME}" -t 800

# set volume
sleep 3
pamixer --set-volume ${VOLUME}

