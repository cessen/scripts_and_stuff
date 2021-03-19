#!/bin/sh

SCRIPT=${@:-bash}

FHS=$(cat << EOF | bash
nix-build --no-out-link -E 'with import <nixpkgs> {};
  buildFHSUserEnv {
    name = "fhs";
    runScript = "$SCRIPT";
    targetPkgs = p: with p; [
      #qt3
      #qt4
      #qt5.full
      #gtk2
      #gtk3
      mpv
      zlib
      glib
      nss
      nspr
      freetype
      expat
      fontconfig
      libglvnd
      libGLU
      libxkbcommon
      systemd
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
'
EOF
)

"$FHS/bin/fhs"
