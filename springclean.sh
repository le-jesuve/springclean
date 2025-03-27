#!/usr/bin/env  bash

#!/usr/bin/env bash
# springclean
# Maintainer: Luke Byars <le.jesuve at gmail dot com>
##
# SPDX-FileCopyrightText: 2025 Luke Byars <le.jesuve at gmail dot com>

# # SPDX-License-Identifier: GPL-3.0-only
#
# Metadata (for package managers):
# Version: 1.0.0
# Architecture: any
# Dependencies: bash
#
# Usage: Organizes files by extension

declare -A default_dirs=(
  [cpp]="cpp"
  [pdf]="books"
  [txt]="notes"
)

declare -A user_dirs

declare -a found_extensions

declare manual_mode=0

load_config() {
  local CONFIG_FILE="$HOME/.config/springclean/springclean.conf"
  if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "No config found, writing template" >&2
    mkdir -p "$HOME/.config/springclean"
    touch "$CONFIG_FILE"
    printf "# Custom directory mappings for filetypes\n# Format: EXTENSION=DIRECTORYNAME\n\n# Documents & Text\npdf=documents\ntxt=text\nmd=markdown\nodt=documents\nods=spreadsheets\nodp=presentations\ncsv=data\njson=data\nxml=data\nrtf=documents\n\n# Programming\nsh=scripts\nbash=scripts\nzsh=scripts\npy=python\npl=perl\nrb=ruby\nc=code\ncpp=code\nh=headers\ngo=golang\nrs=rust\njava=java\nclass=java\njar=java\njs=javascript\nts=typescript\nphp=php\nlua=lua\n\n# System & Config\nconf=config\ncfg=config\nyml=config\nservice=systemd\nsocket=systemd\ntimer=systemd\nlock=system\nlog=logs\npkg.tar.zst=arch_packages\nPKGBUILD=arch_builds\n\n# Archives\nzip=archives\ntar=archives\ngz=archives\nxz=archives\nzst=archives\nrar=archives\n7z=archives\n\n# Media - Images\njpg=images\npng=images\ngif=images\nwebp=images\ntiff=images\nsvg=vector\npsd=photoshop\nxcf=gimp\nkra=krita\n\n# Media - Audio\nmp3=audio\nflac=audio\nwav=audio\naiff=audio\nogg=audio\nmidi=midi\nflp=flstudio\nal=ableton\n\n# Media - Video\nmp4=video\nmkv=video\navi=video\nmov=video\nwebm=video\nflv=video\nblend=blender\naep=after_effects\n\n# 3D & Models\nfbx=3d_models\nobj=3d_models\nstl=3d_print\nma=maya\nmb=maya\n\n# Virtualization\niso=disk_images\nimg=disk_images\nqcow2=virtual_machines\nvdi=virtual_machines\n\n# Security & Keys\npem=certificates\ncrt=certificates\nkey=keys\ngpg=encrypted\n\n# Desktop & Themes\ndesktop=shortcuts\ntheme=themes\nicons=icons\n\n# Temporary\nbak=backups\ntmp=temporary\n" >"$CONFIG_FILE"
    return 1
  fi

  while IFS='=' read -r ext dir; do
    if [[ -n "$ext" && ! "$ext" =~ ^# ]]; then
      user_dirs["$ext"]="${dir//[^[:alnum:]_-]/}"
    fi
  done <"$CONFIG_FILE"
}

show_help() {
  cat <<EOF
springclean v1.0.0 

Usage: ${0##*/} [-m] [-p DIR]

orgnaises loose files in a directory into subdirectories based on file extension.

Options:
  -m        Manual mode (prompt for subdirectory names)
  -p DIR    Target directory (default: current)
  -h        Show this help
EOF
  exit 0
}

while getopts 'mp:h' OPTION; do
  case $OPTION in
  p)
    if [[ -d "$OPTARG" ]]; then
      cd "$OPTARG"
      echo "Changed directory to $OPTARG"
    else
      echo "Invalid directory: $OPTARG" >&2
      exit 1
    fi
    ;;
  m)
    manual_mode=1
    ;;
  h)
    show_help
    ;;
  esac
done

find_extensions() {
  shopt -s nullglob
  for file in *.*; do
    local ext="${file##*.}"
    if [[ -n "$ext" && ! " ${found_extensions[@]} " =~ " $ext " ]]; then
      found_extensions+=("$ext")
    fi
  done
  shopt -u nullglob

  if [[ ${#found_extensions[@]} -eq 0 ]]; then
    echo "No files with extensions found." >&2
    return 1
  fi
}

get_target_dir() {
  local ext="$1"

  if [[ -v "user_dirs[$ext]" && ${manual_mode} == 0 ]]; then
    echo "${user_dirs[$ext]}"
    return
  fi

  if [[ -v default_dirs[$ext] && ${manual_mode} == 0 ]]; then
    echo "${default_dirs[$ext]}"
    return
  fi

  while true; do
    read -rp "Enter directory name for .$ext files? (default: ${ext}_files):" dir
    dir=$(tr -d '[:space:]' <<<"$dir" | tr -cd '[:alnum:]_-')

    if [[ -z "$dir" ]]; then
      dir="${ext}_files"
    fi

    if [[ "$dir" =~ ^[a-zA-Z0-9_-]+$ ]]; then
      echo "$dir"

      user_dirs["$ext"]="$dir"
      return
    else
      echo "Invalid directory name. Use only letters, numbers, underscores, and hyphens."
    fi
  done
}

main() {
  load_config || echo "Edit the configuration file at $HOME/.config/sorter/sorter.conf to set defaults, then run again"
  find_extensions

  for ext in "${found_extensions[@]}"; do
    target=$(get_target_dir "$ext")
    if [[ ! -d "$target" ]]; then
      mkdir -p "$target"
      echo "Created directory: $target"
    fi
    mv -- *."$ext" "$target/" 2>/dev/null && echo "Moved .$ext to $target/"
  done
}

main "$@"
