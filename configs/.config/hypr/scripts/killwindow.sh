if [[ $(hyprctl activewindow -j | jq -r ".class") == "AmneziaVPN" ]]; then
  kill $(ps -u $USER | grep AmneziaVPN | awk '{print $1}')
else
  hyprctl dispatch killactive
fi
