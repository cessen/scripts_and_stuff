#!/usr/bin/env bash

export NIXPKGS_ALLOW_INSECURE=1

FHS=`nix-build --no-out-link -E 'with import <nixpkgs> {};
  buildFHSUserEnv {
    name = "fhs";
    targetPkgs = pkgs: with pkgs; [
      pkg-config

      alsa-lib
      at-spi2-atk
      atk
      cairo
      dbus
      e2fsprogs
      expat
      fontconfig
      freetype
      gdk-pixbuf
      glib
      gnome3.gdm
      gtk3
      gtk4
      libdrm
      libGLU
      libglvnd
      libkrb5
      libxkbcommon
      mpg123
      mpv
      nspr
      nss
      pango
      pulseaudio
      qt5.full
      qt6.full
      systemd
      vulkan-extension-layer
      vulkan-loader
      vulkan-validation-layers
      zlib

      xorg.libICE
      xorg.libSM
      xorg.libX11
      xorg.libxcb
      xorg.libXcomposite
      xorg.libXcursor
      xorg.libXdamage
      xorg.libXext
      xorg.libXfixes
      xorg.libXi
      xorg.libXrandr
      xorg.libXrender
      xorg.libXtst
      xorg.libXxf86vm
      xorg.xcbutilimage
      xorg.xcbutilkeysyms
      xorg.xcbutilrenderutil
      xorg.xcbutilwm
    ];
  }
'`

"$FHS/bin/fhs" -c '"$@"' bash $@
