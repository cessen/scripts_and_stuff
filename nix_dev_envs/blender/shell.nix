{ pkgs ? import <nixpkgs> {} }:

(pkgs.buildFHSEnv {
  name = "Blender Dev Env";

  targetPkgs = pkgs: (with pkgs; [
    # Note: use nix-locate to find packages that contain files (headers,
    # shared objects, etc.) that are reported missing during building.

    cmake
    clang
    clang-tools  # For clangd.
    ccache
    lldb
    mold
    pkg-config

    libGL
    libGL.dev
    pipewire
    pipewire.dev

    # addDriverRunpath
    # shaderc
    # vulkan-headers vulkan-loader

    xorg.libX11
    xorg.libXext
    xorg.libXi
    xorg.libXrender
    xorg.libXxf86vm
    xorg.libXfixes
    xorg.xorgproto
    xorg.libSM
    xorg.libICE

    xorg.libX11.dev
    xorg.libXext.dev
    xorg.libXi.dev
    xorg.libXrender.dev
    xorg.libXxf86vm.dev
    xorg.libXfixes.dev
    xorg.xorgproto.out
    xorg.libSM.out
    xorg.libICE.out

    # For header files that are otherwise missing.
    llvmPackages_20.libc.out
  ]);

  runScript = "fish";

  profile=''
    export NIX_ENFORCE_NO_NATIVE=0
    export CMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH:/usr
  '';
}).env
