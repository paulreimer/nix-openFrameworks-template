{ pkgs, packages }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; packages.default.nativeBuildInputs
  ++ [
    # Debug dependencies
    gdb
  ]
  ++ lib.optionals stdenv.isLinux ([
    # Runtime dependencies
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    xorg.xinit
    xorg.xorgserver
  ]);

  buildInputs = packages.default.propagatedBuildInputs;

  CFLAGS = packages.default.CFLAGS;
  LDFLAGS = packages.default.LDFLAGS;
}
