{ lib, stdenv, fetchFromGitHub, python3Packages }:

python3Packages.buildPythonPackage rec {
  pname = "rivalcfg";
  version = "4.14.0";

  src = fetchFromGitHub {
    owner = "flozz";
    repo = "rivalcfg";
    rev = "v${version}";
    sha256 = "LQpEHcKXkepfsgG7tGYsmM43FkUSBgm1Cn5C1RmTggI=";
  };

  nativeBuildInputs = with python3Packages; [ setuptools hidapi ];
  propagatedBuildInputs = with python3Packages; [ setuptools hidapi ];

  doCheck = false;

  postInstall = ''
    mkdir -p $out/lib/udev/rules.d
    $out/bin/rivalcfg --print-udev > $out/lib/udev/rules.d/99-steelseries-rival.rules
  '';

  preFixup = ''
    wrapPythonPrograms
  '';
}
