{
  stdenv,
  lib,
  kernel,
  fetchFromGitHub,
  ...
}:

stdenv.mkDerivation rec {
  pname = "r8126";
  version = "10.015.00-1";

  src = fetchFromGitHub {
    owner = "awesometic";
    repo = "realtek-r8126-dkms";
    rev = version;
    sha256 = "sha256-tCB53d5hkXiYjja1W7o9p94S87rGa9nXh8yXvreQBn4=";
  };

  hardeningDisable = [ "pic" ];

  nativeBuildInputs = kernel.moduleBuildDependencies;

  preBuild = ''
    substituteInPlace src/Makefile --replace "BASEDIR :=" "BASEDIR ?="
    substituteInPlace src/Makefile --replace "modules_install" "INSTALL_MOD_PATH=$out modules_install"
  '';

  makeFlags = [
    "KVER=${kernel.modDirVersion}"
    "BSRC=${kernel.dev}/lib/modules/${kernel.modDirVersion}"
  ];

  buildFlags = [ "modules" ];

  meta = with lib; {
    homepage = "https://github.com/awesometic/realtek-r8126-dkms";
    description = "Realtek r8126 driver";
    longDescription = ''
      A kernel module for Realtek 8126 5Gb network cards.
    '';
    # once r8126 is included in mainline kernel we can uncomment the following
    # and change the version accordingly
    # broken = lib.versionAtLeast kernel.version "6.14.2";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ nobody ];
  };
}