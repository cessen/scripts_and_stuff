#!/usr/bin/env bash

FHS=`nix-build --no-out-link -E 'with import <nixpkgs> {};
  buildFHSUserEnv {
    name = "fhs";
    targetPkgs = pkgs: with pkgs; [
      pkg-config
      mpv
      zlib
      glib
      nss
      nspr
      freetype
      cairo
      gtk3
      gtk4
      glib
      expat
      fontconfig
      gdk-pixbuf
      pango
      cairo
      gtk3
      gdm
      libdrm
      libglvnd
      libGLU
      vulkan-loader
      vulkan-extension-layer
      vulkan-validation-layers
      libxkbcommon
      systemd
      pulseaudio
      dbus
      atk
      at-spi2-atk
      xorg.libX11
      xorg.libXfixes
      xorg.libXi
      xorg.libXxf86vm
      xorg.libXrender
      xorg.libXcomposite
      xorg.libXdamage
      xorg.libXcursor
      xorg.libXrandr
      xorg.libxcb
      xorg.xcbutilkeysyms
      xorg.xcbutilwm
      xorg.xcbutilimage
      xorg.xcbutilrenderutil
      xorg.libXext
      xorg.libXtst
    ];
  }
'`

"$FHS/bin/fhs"
