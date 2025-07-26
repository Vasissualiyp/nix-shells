{ pkgs ? import <nixpkgs> {} }:
let
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
      echo "Forutils installed in $out"
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
     forutils
	 python311
	 python311Packages.setuptools
	 python311Packages.wheel
	 packaging
	 pkgs.gfortran
    ];
	shellHook = ''
	FORUTILSPATH=${forutils}/Release
	'';
  }
