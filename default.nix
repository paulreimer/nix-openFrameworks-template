{ pkgs, packages }:
packages.libopenFrameworks.overrideAttrs (oldAttrs: rec {
  pname = "emptyExample";
  version = "0.0.1";

  srcs = oldAttrs.srcs ++ [
    ./addons
    ./src
  ];

  buildPhase = ''
    ninja --verbose -C out ${pname}
  '';

  installPhase = ''
    mkdir -p $out/bin/
    mv ./out/${pname} $out/bin/
  '';

  propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [
    packages.libopenFrameworks
  ];
})
