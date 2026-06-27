{ lib
, stdenv
, dpkg
, autoPatchelfHook
, makeWrapper
, fetchurl
, qt5
, gst_all_1
, libv4l
, alsa-lib
, libudev-zero  # or systemd for libudev
, avahi
}:

stdenv.mkDerivation rec {
  pname = "iriun";
  version = "2.9.1"; # check the actual version

  src = fetchurl {
    url = "https://iriun.gitlab.io/iriunwebcam-2.9.1.deb";
    hash = "sha256-slpTyetT96waR7XvcXSZDdl/Ziacc4hgM5XCxX8WC4Q=";
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
    qt5.wrapQtAppsHook
  ];

  buildInputs = [
    qt5.qtbase
    qt5.qtmultimedia
    qt5.qtdeclarative
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    libv4l
    alsa-lib
    libudev-zero
    avahi
  ];

  unpackPhase = "dpkg-deb -x $src .";

  installPhase = ''
    mkdir -p $out/bin $out/share
    cp usr/local/bin/iriunwebcam $out/bin/
    cp -r usr/share/* $out/share/ 2>/dev/null || true
  '';

  meta = {
    description = "Use your phone as a wireless webcam";
    homepage = "https://iriun.com";
    license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
    mainProgram = "iriunwebcam";
  };
}
