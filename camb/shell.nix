{ pkgs ? import <nixpkgs> {} }:
let
  camb = pkgs.python311Packages.buildPythonPackage rec {
	pname = "camb";
	version = "1.5.7";
	#format = "wheel";
    src = pkgs.fetchFromGitHub {
      owner = "cmbant";
      repo = "CAMB";
      rev = "ecd375bff3cd736b3590a22c8f9663b9e6180ee2";
      hash = "sha256-rHUY2S+MDXk/qujlCmC2CS3i6i9SOBtf3sBukEDFdBI=";
	  fetchSubmodules = true;
    };

	buildInputs = [ pkgs.which pkgs.gfortran ];
	propagatedBuildInputs = [ packaging pkgs.gfortran ];
	nativeBuildInputs = [ packaging pkgs.gfortran pkgs.which pkgs.python311Packages.setuptools pkgs.python311Packages.wheel ];
	format = "other";
    buildPhase = ''
	  python setup.py build
    '';
	# Custom install phase to copy the built files manually
    installPhase = ''
      mkdir -p $out/lib/python3.11/site-packages
      cp -r build/lib*/* $out/lib/python3.11/site-packages/
    '';
	preDistPhases = [ "buildPhase" "installPhase" ];
	postInstall = ''
	'';
  };

  packaging = pkgs.python311Packages.buildPythonPackage rec {
	pname = "packaging";
	version = "24.1";
	format = "pyproject";
    src = pkgs.fetchFromGitHub {
      owner = "pypa";
      repo = "packaging";
      rev = "a716c52b5f3ca9b4a512f538b80ced8ee01b2775";
      hash = "sha256-5ay2MwEw90yc0K3PvyEaxsChX83aJ60jL1rY6q55B2Y=";
    };

	buildInputs = with pkgs.python311Packages; [ pyproject-api flit-core ];
	postInstall = ''
	'';
  };

in
  pkgs.mkShell {
    buildInputs = with pkgs; [
     python311

     python311Packages.numpy
     python311Packages.scipy
     python311Packages.sympy
     #pkgs.python311Packages.packaging
     #packaging

     camb
    ];
	shellHook = ''
	'';
  }
