{ pkgs }:
pkgs.stdenv.mkDerivation rec {
  pname = "emptyExample";
  version = "0.0.1";

  srcs = [
    ./.gn
    ./BUILD.gn
    ./BUILDCONFIG.gn
    ./toolchain
    ./addons
    ./src
    ./openFrameworks
  ];

  phases = [ "unpackPhase" "configurePhase" "buildPhase" ];

  unpackPhase = ''
    for src in $srcs; do
      cp -r "$src" $(stripHash "$src")
    done
  '';

  configurePhase = ''
    gn gen out
  '';

  buildPhase = ''
    ninja --verbose -C out ${pname}
    mkdir -p $out/bin/
    cp -r ./out/${pname} $out/bin/
  '';

  nativeBuildInputs = with pkgs; [
    # Build system dependencies
    gn
    ninja
  ];

  propagatedBuildInputs = with pkgs; [
    # openFrameworks dependencies
    cairo
    curl
    freeimage
    freetype
    glew
    glfw3
    glm
    nlohmann_json
    pugixml
    rtaudio
    tess2
    uriparser
    utf8cpp
  ]
  ++ lib.optionals stdenv.isLinux ([
    fontconfig
    glib
    gst_all_1.gst-plugins-base
    gst_all_1.gstreamer
    kissfft
    libsndfile
    openal
    systemd
    xorg.libX11
    xorg.libXrandr
  ])
  ++ lib.optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
    AVFoundation
    AppKit
    Cocoa
    CoreFoundation
    CoreMedia
    CoreServices
    CoreText
    OpenGL
  ]);

  CFLAGS = with pkgs; [
    "-I${lib.getDev cairo}/include/cairo"
    "-I${lib.getDev curl}/include"
    "-I${lib.getDev freeimage}/include"
    "-I${lib.getDev freetype}/include"
    "-I${lib.getDev glew}/include"
    "-I${lib.getDev glfw3}/include"
    "-I${lib.getDev glm}/include"
    "-I${lib.getDev nlohmann_json}/include"
    "-I${lib.getDev pugixml}/include"
    "-I${lib.getDev tess2}/include"
    "-I${lib.getDev uriparser}/include"
    # non-standard include paths:
    "-I${lib.getDev nlohmann_json}/include/nlohmann"
    "-I${lib.getDev rtaudio}/include/rtaudio"
    "-I${lib.getDev utf8cpp}/include/utf8cpp"
  ]
  ++ lib.optionals stdenv.isLinux ([
    "-I${glib.out}/lib/glib-2.0/include"
    "-I${lib.getDev fontconfig}/include"
    "-I${lib.getDev libsndfile}/include"
    "-I${lib.getDev openal}/include"
    "-I${lib.getDev systemd}/include"
    "-I${lib.getDev xorg.libX11}/include"
    "-I${lib.getDev xorg.libXrandr}/include"
    # non-standard include paths:
    "-I${lib.getDev glib}/include/glib-2.0"
    "-I${lib.getDev gst_all_1.gst-plugins-base}/include/gstreamer-1.0"
    "-I${gst_all_1.gst-plugins-base}/lib/gstreamer-1.0/include"
    "-I${lib.getDev gst_all_1.gstreamer}/include/gstreamer-1.0"
    "-I${lib.getDev kissfft}/include/kissfft"
  ]);

  LDFLAGS = with pkgs; [
    "-L${lib.getLib cairo}/lib"
    "-L${lib.getLib curl}/lib"
    "-L${lib.getLib freeimage}/lib"
    "-L${lib.getLib freetype}/lib"
    "-L${lib.getLib glew}/lib"
    "-L${lib.getLib glfw3}/lib"
    "-L${lib.getLib glm}/lib"
    "-L${lib.getLib nlohmann_json}/lib"
    "-L${lib.getLib pugixml}/lib"
    "-L${lib.getLib rtaudio}/lib"
    "-L${lib.getLib tess2}/lib"
    "-L${lib.getLib uriparser}/lib"
    "-L${lib.getLib utf8cpp}/lib"
  ]
  ++ lib.optionals stdenv.isLinux ([
    "-L${lib.getLib fontconfig}/lib"
    "-L${lib.getLib glib}/lib"
    "-L${lib.getLib gst_all_1.gstreamer}/lib"
    "-L${lib.getLib libsndfile}/lib"
    "-L${lib.getLib openal}/lib"
    "-L${lib.getLib systemd}/lib"
  ]);
}
