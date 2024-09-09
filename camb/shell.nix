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
      hash = "sha256-e1sBwaCMLVcXrFdoDdANoRezlUBYnnKjjkuGvDkw/t8=";
    };

	buildInputs = [ forutils pkgs.which ];
	propagatedBuildInputs = [ packaging pkgs.gfortran forutils ];
	nativeBuildInputs = [ packaging pkgs.gfortran forutils ];
    buildPhase = ''
      export FORUTILSPATH=${forutils}/Release
	  python setup.py build
    '';
	postInstall = ''
	'';
  };

  forutils = pkgs.stdenv.mkDerivation {
    pname = "forutils";
    version = "1.0";
    src = pkgs.fetchFromGitHub {
      owner = "cmbant";
      repo = "forutils";
      rev = "e046cdfcf8670eeb8f2fd755184f1225fd819787";
      hash = "sha256-/5LJFL7KYh6axJGuEY51SljHk1I3q7HIYOPIz4eRRdw=";
    };
  
    buildInputs = [ pkgs.gfortran ];
  
    buildPhase = ''
    '';
  
    installPhase = ''
      mkdir -p $out
      cp -r Release $out/
      cp -r Debug $out/
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
    buildInputs = with pkgs.python311Packages; [
     pkgs.python311

     numpy
     scipy
     sympy
     #pkgs.python311Packages.packaging
     #packaging

     camb
    ];
	shellHook = ''
	'';
  }
