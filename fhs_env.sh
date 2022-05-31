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
      libglvnd
      libGLU
      vulkan-loader
      vulkan-extension-layer
      vulkan-validation-layers
      libxkbcommon
      systemd
      pulseaudio
      xlibs.libX11
      xlibs.libXfixes
      xlibs.libXi
      xlibs.libXxf86vm
      xlibs.libXrender
      xlibs.libXcomposite
      xlibs.libXdamage
      xlibs.libXcursor
      xlibs.libXrandr
      xlibs.libxcb
      xlibs.xcbutilkeysyms
      xlibs.xcbutilwm
      xlibs.xcbutilimage
      xlibs.xcbutilrenderutil
    ];
  }
'`

"$FHS/bin/fhs"
