{ pkgs ? import <nixpkgs> {} }:
let
  camb = pkgs.python311Packages.buildPythonPackage rec {
	pname = "camb";
	version = "1.5.7";
	format = "wheel";
    src = pkgs.fetchFromGitHub {
      owner = "cmbant";
      repo = "CAMB";
      rev = "ecd375bff3cd736b3590a22c8f9663b9e6180ee2";
      hash = "sha256-e1sBwaCMLVcXrFdoDdANoRezlUBYnnKjjkuGvDkw/t8=";
    };

	postInstall = ''
	'';
  };
  packaging = pkgs.python311Packages.buildPythonPackage rec {
	pname = "packaging";
	version = "24.1";
	format = "wheel";
    src = pkgs.fetchFromGitHub {
      owner = "pypa";
      repo = "packaging";
      rev = "a716c52b5f3ca9b4a512f538b80ced8ee01b2775";
      hash = "sha256-5ay2MwEw90yc0K3PvyEaxsChX83aJ60jL1rY6q55B2Y=";
    };

	postInstall = ''
	'';
  };

in
  pkgs.mkShell {
    buildInputs = [
     pkgs.python311

     pkgs.python311Packages.numpy
     pkgs.python311Packages.scipy
     pkgs.python311Packages.sympy
     #pkgs.python311Packages.packaging
     packaging

     camb
    ];
	shellHook = ''
	'';
  }
