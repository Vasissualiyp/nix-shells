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

in
  pkgs.mkShell {
    buildInputs = [
     forutils
    ];
	shellHook = ''
	FORUTILSPATH=${forutils}/Release
	'';
  }
