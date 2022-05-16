self: { darwin, lib, stdenv, fetchFromGitHub, premake4, pkg-config, ...}: {
  tess2 = stdenv.mkDerivation rec {
    pname = "tess2";
    version = "1.0.2";

    src = fetchFromGitHub {
      owner = "memononen";
      repo = "libtess2";
      rev = "v1.0.2";
      sha256 = "sha256-mDxvfaLvFhLO1drw7f+KX97i+3dJCxFvXyxze5HsW4U=";
    };

    prePatch = lib.optionalString stdenv.isDarwin ''
      sed -i 's/glfw3/glfw/' premake4.lua
    '';

    nativeBuildInputs = [ premake4 pkg-config ];

    makeFlags = [ "config=release" ];
    buildPhase = ''
      make -C Build tess2 config=release
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out/lib $out/include
      cp Build/libtess2.a $out/lib
      cp Include/* $out/include

      runHook postInstall
    '';

    meta = with lib; {
      homepage = "https://github.com/memononen/libtess2";
      license = lib.licenses.sgi-b-20;
    };
  };
}
