let
    # You can replace "unstable" with any channel name to use that channel.
    pkgs = import <unstable> {};
    name = "blender_dev_env";

    # Shorthand.
    pypkgs = pkgs.python310Packages;

    # Custom build of freetype with brotli support added.
    freetype_brotli = with pkgs; stdenv.mkDerivation rec {
      name = "freetype_brotli";
      pname = "freetype";
      version = "2.12.1";

      src = fetchurl {
        url = "mirror://savannah/${pname}/${pname}-${version}.tar.xz";
        sha256 = "sha256-R2byAVfMTPDNKS+Av5F/ktHEObJDrDAY3r9rkUDEGn8=";
      };

      propagatedBuildInputs = [ zlib bzip2 libpng brotli ]; # needed when linking against freetype

      # dependence on harfbuzz is looser than the reverse dependence
      nativeBuildInputs = [ pkg-config which makeWrapper ]
        # FreeType requires GNU Make, which is not part of stdenv on FreeBSD.
        ++ lib.optional (!stdenv.isLinux) gnumake;

      # patches = [
      #   ./enable-table-validation.patch
      # ] ++ lib.optional useEncumberedCode ./enable-subpixel-rendering.patch;

      outputs = [ "out" "dev" ];

      configureFlags = [
          "--bindir=$(dev)/bin"
          "--enable-freetype-config"
          "--with-brotli=yes"
      ];

      # native compiler to generate building tool
      CC_BUILD = "${buildPackages.stdenv.cc}/bin/cc";

      # The asm for armel is written with the 'asm' keyword.
      CFLAGS = lib.optionalString stdenv.isAarch32 "-std=gnu99";

      enableParallelBuilding = true;

      doCheck = true;

      postInstall = glib.flattenInclude + ''
        substituteInPlace $dev/bin/freetype-config \
          --replace ${buildPackages.pkg-config} ${pkgsHostHost.pkg-config}

        wrapProgram "$dev/bin/freetype-config" \
          --set PKG_CONFIG_PATH "$PKG_CONFIG_PATH:$dev/lib/pkgconfig"
      '';
    };
    # Embree 4, which isn't packaged in nixos yet.
    embree4 = with pkgs; stdenv.mkDerivation rec {
      pname = "embree";
      version = "4.0.1";

      src = fetchFromGitHub {
        owner = "embree";
        repo = "embree";
        rev = "v${version}";
        sha256 = "sha256-PNiJPyQxFOpzKIuxeWje7o+Aus1fcWm+i3uVqmjaJ4g=";
      };

      postPatch = ''
        # Fix duplicate /nix/store/.../nix/store/.../ paths
        sed -i "s|SET(EMBREE_ROOT_DIR .*)|set(EMBREE_ROOT_DIR $out)|" \
          common/cmake/embree-config.cmake
        sed -i "s|$""{EMBREE_ROOT_DIR}/||" common/cmake/embree-config.cmake
        # substituteInPlace common/math/math.h --replace 'defined(__MACOSX__) && !defined(__INTEL_COMPILER)' 0
        # substituteInPlace common/math/math.h --replace 'defined(__WIN32__) || defined(__FreeBSD__)' 'defined(__WIN32__) || defined(__FreeBSD__) || defined(__MACOSX__)'
      '';

      cmakeFlags = [
        "-DEMBREE_TUTORIALS=OFF"
        "-DEMBREE_RAY_MASK=ON"
      ];

      nativeBuildInputs = [ ispc pkg-config cmake ];
      buildInputs = [ tbb glfw openimageio2 libjpeg libpng xorg.libX11 xorg.libpthreadstubs ]
                    ++ lib.optionals stdenv.isDarwin [ glib ];

      meta = with lib; {
        description = "High performance ray tracing kernels from Intel";
        homepage = "https://embree.github.io/";
        maintainers = with maintainers; [ hodapp gebner ];
        license = licenses.asl20;
        platforms = platforms.unix;
      };
    };
in pkgs.stdenv.mkDerivation {
    nativeBuildInputs = with pkgs; [
        # Custom items.
        pypkgs.numpy
        pypkgs.python
        freetype_brotli

        # Normal items.
        addOpenGLRunpath
        alembic
        boost
        brotli
        c-blosc
        clang
        cmake
        # cudatoolkit
        embree4
        ffmpeg
        fftw
        gettext
        glew
        gmp
        ilmbase
        jemalloc
        libGL
        libGLU
        libepoxy
        libharu
        libjack2
        libjpeg
        libpng
        libsamplerate
        libsndfile
        libtiff
        libwebp
        llvm
        makeWrapper
        ocl-icd
        openal
        opencollada
        opencolorio
        openexr
        openimagedenoise
        openimageio2
        openjpeg
        opensubdiv
        openvdb
        pkg-config
        potrace
        pugixml
        SDL
        stdenv
        tbb
        xorg.libX11
        xorg.libXext
        xorg.libXi
        xorg.libXrender  
        xorg.libXxf86vm
        zlib
        zstd
    ];

    inherit name;
    shellHook = with pkgs; ''
        export PYTHON_LIBRARY="${pypkgs.python.libPrefix}"
        export PYTHON_LIBPATH="${pypkgs.python}/lib"
        export PYTHON_INCLUDE_DIR="${pypkgs.python}/include/${pypkgs.python.libPrefix}"
        export PYTHON_VERSION="${pypkgs.python.pythonVersion}"
        export PYTHON_NUMPY_PATH="${pypkgs.numpy}/${pypkgs.python.sitePackages}"
        export PYTHON_NUMPY_INCLUDE_DIRS="${pypkgs.numpy}/${pypkgs.python.sitePackages}/numpy/core/include"
    '';
}
