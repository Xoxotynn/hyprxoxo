<div align="center">
  <h1>-- xoxo --</h1>
  <img width="250" src="https://github.com/Xoxotynn/hyprxoxo/blob/main/source/concepts/arch.svg">
  <br>
  <img src="https://img.shields.io/github/last-commit/Xoxotynn/hyprxoxo?style=for-the-badge&color=ffb4a2&labelColor=201a19">
  <img src="https://img.shields.io/github/repo-size/Xoxotynn/hyprxoxo?style=for-the-badge&color=a8c7ff&labelColor=1a1b1f">
</div>

## About

This is a fork of [klpod0s](https://github.com/klpod221/klpod0s) with some changes to make it work on my system and to my liking. I have also added some of my own scripts and configs to make it work better for me and maybe for you too.

Thanks to [klpod221](https://github.com/klpod221) for making this awesome dotfiles repo.

### Installation

The installation script is made for Arch, but **may** work on some Arch based distros.  

> **Warning**
>
> Install script will auto-detect nvidia card and install nvidia-dkms drivers for your kernel.  
> Nvidia drm will be enabled in grub, so please [ensure](https://wiki.archlinux.org/title/NVIDIA) your nvidia card supports dkms drivers/hyprland.

After minimal Arch install (with grub), clone and execute -

```shell
pacman -Sy git
git clone https://github.com/klpod221/klpod0s.git
cd ./klpod0s
./install.sh
```

> **Note**
>
> You can also create your own list (for ex. `custom_apps.lst`) with all your favorite apps and pass the file as a parameter to install it -
>
> ```shell
> ./install.sh custom_apps.lst
> ```

Please reboot after the install script completes and takes you to sddm login screen (or black screen) for the first time.

### Theming

- Available themes

  - [x] Catppuccin-Mocha
  - [x] Catppuccin-Latte

|                                                Catppuccin-Mocha                                                |
| :------------------------------------------------------------------------------------------------------------: |
| ![Catppuccin-Mocha#1](https://raw.githubusercontent.com/Xoxotynn/hyprxoxo/main/source/assets/theme_mocha_1.png) |
| ![Catppuccin-Mocha#2](https://raw.githubusercontent.com/Xoxotynn/hyprxoxo/main/source/assets/theme_mocha_2.png) |

|                                                Catppuccin-Latte                                                |
| :------------------------------------------------------------------------------------------------------------: |
| ![Catppuccin-Latte#1](https://raw.githubusercontent.com/Xoxotynn/hyprxoxo/main/source/assets/theme_latte_1.png) |
| ![Catppuccin-Latte#2](https://raw.githubusercontent.com/Xoxotynn/hyprxoxo/main/source/assets/theme_latte_2.png) |

## Styles

|                                              Theme Select                                               |
| :-----------------------------------------------------------------------------------------------------: |
| ![Theme Select](https://raw.githubusercontent.com/Xoxotynn/hyprxoxo/main/source/assets/theme_select.png) |

|                                              Wallpaper Select                                               |
| :---------------------------------------------------------------------------------------------------------: |
| ![Wallpaper Select](https://raw.githubusercontent.com/Xoxotynn/hyprxoxo/main/source/assets/walls_select.png) |

|                                               Launcher Style Select                                                |
| :----------------------------------------------------------------------------------------------------------------: |
| ![Launcher Style Select](https://raw.githubusercontent.com/Xoxotynn/hyprxoxo/main/source/assets/rofi_style_sel.png) |

|                                             Launcher Styles                                             |
| :-----------------------------------------------------------------------------------------------------: |
| ![rofi style#1](https://raw.githubusercontent.com/Xoxotynn/hyprxoxo/main/source/assets/rofi_style_1.png) |
| ![rofi style#2](https://raw.githubusercontent.com/Xoxotynn/hyprxoxo/main/source/assets/rofi_style_2.png) |
| ![rofi style#3](https://raw.githubusercontent.com/Xoxotynn/hyprxoxo/main/source/assets/rofi_style_3.png) |
| ![rofi style#4](https://raw.githubusercontent.com/Xoxotynn/hyprxoxo/main/source/assets/rofi_style_4.png) |
| ![rofi style#5](https://raw.githubusercontent.com/Xoxotynn/hyprxoxo/main/source/assets/rofi_style_5.png) |
| ![rofi style#6](https://raw.githubusercontent.com/Xoxotynn/hyprxoxo/main/source/assets/rofi_style_6.png) |
| ![rofi style#7](https://raw.githubusercontent.com/Xoxotynn/hyprxoxo/main/source/assets/rofi_style_7.png) |
| ![rofi style#8](https://raw.githubusercontent.com/Xoxotynn/hyprxoxo/main/source/assets/rofi_style_8.png) |

|                                               Wlogout Menu                                                |
| :-------------------------------------------------------------------------------------------------------: |
| ![Wlogout Menu#1](https://raw.githubusercontent.com/Xoxotynn/hyprxoxo/main/source/assets/wlog_style_1.png) |
| ![Wlogout Menu#2](https://raw.githubusercontent.com/Xoxotynn/hyprxoxo/main/source/assets/wlog_style_2.png) |

|                                                Game Launchers                                                |
| :----------------------------------------------------------------------------------------------------------: |
| ![Game Launcher](https://raw.githubusercontent.com/Xoxotynn/hyprxoxo/main/source/assets/game_launch.png) |

## Packages

### <code>nvidia</code>
<table>
    <tr><td>linux-[zen|lts]-headers</td><td>for main kernel (script will auto detect from /usr/lib/modules/)</td></tr>
    <tr><td>nvidia-dkms</td><td>nvidia drivers (script will auto detect from lspci -k | grep -A 2 -E "(VGA|3D)")</td></tr>
    <tr><td>nvidia-utils</td><td>nvidia utils (script will auto detect from lspci -k | grep -A 2 -E "(VGA|3D)")</td></tr>
</table>

### <code>utils</code>
<table>
    <tr><td>pipewire</td><td>audio and video server</td></tr>
    <tr><td>pipewire-alsa</td><td>for audio</td></tr>
    <tr><td>pipewire-audio</td><td>for audio</td></tr>
    <tr><td>pipewire-jack</td><td>for audio</td></tr>
    <tr><td>pipewire-pulse</td><td>for audio</td></tr>
    <tr><td>wireplumber</td><td>audio and video server</td></tr>
    <tr><td>networkmanager</td><td>network manager</td></tr>
    <tr><td>network-manager-applet</td><td>nm tray</td></tr>
    <tr><td>bluez</td><td>for bluetooth</td></tr>
    <tr><td>bluez-utils</td><td>for bluetooth</td></tr>
    <tr><td>blueman</td><td>bt tray</td></tr>
</table>

### <code>login</code>
<table>
    <tr><td>sddm-git</td><td>display manager for login</td></tr>
    <tr><td>qt6-wayland</td><td>for QT wayland XDP</td></tr>
    <tr><td>qt6-5compat</td><td>for sddm theme</td></tr>
</table>

### <code>hypr</code>
<table>
    <tr><td>hyprland-git</td><td>main window manager</td></tr>
    <tr><td>hyprshade</td><td>screen shader tool(for bluelight filter)</td></tr>
    <tr><td>dunst</td><td>graphical notification daemon</td></tr>
    <tr><td>rofi-lbonn-wayland-git</td><td>app launcher</td></tr>
    <tr><td>waybar</td><td>status bar</td></tr>
    <tr><td>swww</td><td>wallpaper app</td></tr>
    <tr><td>swaylock-effects-git</td><td>lockscreen</td></tr>
    <tr><td>wlogout</td><td>logout screen</td></tr>
    <tr><td>grimblast-git</td><td>screenshot tool</td></tr>
    <tr><td>slurp</td><td>selects region for screenshot/screenshare</td></tr>
    <tr><td>swappy</td><td>screenshot editor</td></tr>
    <tr><td>cliphist</td><td>clipboard manager</td></tr>
</table>

### <code>dependency</code>
<table>
    <tr><td>polkit-kde-agent</td><td>authentication agent</td></tr>
    <tr><td>xdg-desktop-portal-hyprland</td><td>XDG Desktop Portal</td></tr>
    <tr><td>pacman-contrib</td><td>for system update check</td></tr>
    <tr><td>parallel</td><td>for parallel processing</td></tr>
    <tr><td>jq</td><td>to read json</td></tr>
    <tr><td>imagemagick</td><td>for image processing</td></tr>
    <tr><td>pavucontrol</td><td>audio settings gui</td></tr>
    <tr><td>pamixer</td><td>for waybar audio</td></tr>
    <tr><td>fcitx5</td><td>for input method</td></tr>
    <tr><td>fcitx5-qt</td><td>for input method</td></tr>
    <tr><td>fcitx5-gtk</td><td>for input method</td></tr>
    <tr><td>fcitx5-configtool</td><td>for input method</td></tr>
</table>

### <code>theme</code>
<table>
    <tr><td>nwg-look</td><td>theming GTK apps</td></tr>
    <tr><td>kvantum</td><td>theming QT apps</td></tr>
    <tr><td>qt6ct</td><td>theming QT6 apps</td></tr>
</table>

### <code>apps</code>
<table>
    <tr><td>firefox</td><td>browser</td></tr>
    <tr><td>discord</td><td>communication</td></tr>
    <tr><td>telegram-desktop</td><td>messenger</td></tr>
    <tr><td>alacritty</td><td>terminal</td></tr>
    <tr><td>neofetch</td><td>fetch tool</td></tr>
    <tr><td>btop</td><td>system monitor</td></tr>
    <tr><td>yazi</td><td>file manager</td></tr>
    <tr><td>visual-studio-code-bin</td><td>gui code editor</td></tr>
    <tr><td>neovim</td><td>text editor</td></tr>
    <tr><td>notion-app-electron</td><td>notes</td></tr>
    <tr><td>p7zip</td><td>file archiver</td></tr>
    <tr><td>qbittorrent</td><td>torrent tracker</td></tr>
    <tr><td>steam</td><td>steam launcher and runtime</td></tr>
</table>

### <code>shell</code>
<table>
    <tr><td>zsh</td><td>main shell</td></tr>
    <tr><td>lsd</td><td>colorful file lister</td></tr>
    <tr><td>fzf</td><td>command line fuzzy finder</td></tr>
</table>

## Keybindings

### Windows/Session actions
|||
| :--- | :--- |
| <kbd>Super</kbd> + <kbd>Q</kbd>                                                                          | quit active/focused window                        |
| <kbd>Alt</kbd> + <kbd>F4</kbd>                                                                           | quit active/focused window                        |
| <kbd>Super</kbd> + <kbd>Del</kbd>                                                                        | quit hyprland session                             |
| <kbd>Super</kbd> + <kbd>W</kbd>                                                                          | toggle window on focus to float                   |
| <kbd>Super</kbd> + <kbd>J</kbd>                                                                          | toggle layout                                     |
| <kbd>Super</kbd> + <kbd>G</kbd>                                                                          | toggle window group                               |
| <kbd>Alt</kbd> + <kbd>Enter</kbd>                                                                        | toggle window on focus to fullscreen              |
| <kbd>Super</kbd> + <kbd>L</kbd>                                                                          | lock screen                                       |
| <kbd>Super</kbd> + <kbd>Backspace</kbd>                                                                  | logout menu                                       |

### Apps
|||
| :--- | :--- |
| <kbd>Super</kbd> + <kbd>T</kbd>                                                                          | launch alacritty terminal                         |
| <kbd>Super</kbd> + <kbd>E</kbd>                                                                          | launch yazi file manager                          |
| <kbd>Super</kbd> + <kbd>C</kbd>                                                                          | launch vscode                                     |
| <kbd>Super</kbd> + <kbd>F</kbd>                                                                          | launch firefox browser                            |

### Rofi
|||
| :--- | :--- |
| <kbd>Super</kbd> + <kbd>A</kbd>                                                                          | launch desktop applications                       |
| <kbd>Super</kbd> + <kbd>Tab</kbd>                                                                        | switch between opened applications                |
| <kbd>Super</kbd> + <kbd>R</kbd>                                                                          | browse system files                               |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>G</kbd>                                                       | launch steam games                                |

### Audio control
|||
| :--- | :--- |
| <kbd>F10</kbd>                                                                                           | mute audio output (toggle)                        |
| <kbd>F11</kbd>                                                                                           | decrease volume                                   |
| <kbd>F12</kbd>                                                                                           | increase volume                                   |

### Screen capturing
|||
| :--- | :--- |
| <kbd>Super</kbd> + <kbd>P</kbd>                                                                          | drag to select area / click on a window to print |
| <kbd>Super</kbd> + <kbd>Alt</kbd> + <kbd>P</kbd>                                                         | print focused screen                              |

### Custom scripts
|||
| :--- | :--- |
| <kbd>Super</kbd> + <kbd>Alt</kbd> + <kbd>G</kbd>                                                         | disable hypr effects for gamemode                 |
| <kbd>Super</kbd> + <kbd>Alt</kbd> + <kbd>→</kbd>                                                         | next wallpaper                                    |
| <kbd>Super</kbd> + <kbd>Alt</kbd> + <kbd>←</kbd>                                                         | previous wallpaper                                |
| <kbd>Super</kbd> + <kbd>Alt</kbd> + <kbd>↑</kbd>                                                         | next waybar mode                                  |
| <kbd>Super</kbd> + <kbd>Alt</kbd> + <kbd>↓</kbd>                                                         | previous waybar mode                              |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>D</kbd>                                                       | toggle (theme <//> wall) based colors             |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>T</kbd>                                                       | theme select menu                                 |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>A</kbd>                                                       | rofi style select menu                            |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>W</kbd>                                                       | wallpaper select menu                             |
| <kbd>Super</kbd> + <kbd>V</kbd>                                                                          | clipboard history paste                           |

### Move focus
|||
| :--- | :--- |
| <kbd>Super</kbd> + <kbd>←</kbd><kbd>→</kbd><kbd>↑</kbd><kbd>↓</kbd>                                      | move focus                                        |
| <kbd>Alt</kbd> + <kbd>Tab</kbd>                                                                          | move focus (down)                                 |

### Switch workspaces
|||
| :--- | :--- |
| <kbd>Super</kbd> + <kbd>Ctrl</kbd> + <kbd>←</kbd><kbd>→</kbd>                                            | switch workspaces relative to the active one      |
| <kbd>Super</kbd> + <kbd>MouseScroll</kbd>                                                                | cycle through workspaces                          |
| <kbd>Super</kbd> + <kbd>Ctrl</kbd> + <kbd>↓</kbd>                                                        | move to first empty workspace                     |
| <kbd>Super</kbd> + <kbd>[1-5]</kbd>                                                                      | switch to workspace [1-5]                         |

### Move windows
|||
| :--- | :--- |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>←</kbd><kbd>→</kbd><kbd>↑</kbd><kbd>↓</kbd>                   | move active window within the current workspace   |
| <kbd>Super</kbd> + <kbd>LeftClick</kbd>                                                                  | change the window position (drag)                 |
| <kbd>Super</kbd> + <kbd>RightClick</kbd>                                                                 | resize the window (drag)                          |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>[1-5]</kbd>                                                   | move active window to workspace [1-5]             |
| <kbd>Super</kbd> + <kbd>Alt</kbd> + <kbd>[1-5]</kbd>                                                     | move active window to workspace [1-5] (silently)  |

### Special workspace
|||
| :--- | :--- |
| <kbd>Super</kbd> + <kbd>Alt</kbd> + <kbd>S</kbd>                                                         | move window to special workspace                  |
| <kbd>Super</kbd> + <kbd>S</kbd>                                                                          | toogle to special workspace                       |

### Language
|||
| :--- | :--- |
| <kbd>Ctrl</kbd> + <kbd>Space</kbd>                                                                       | switch keyboard layout                            |
