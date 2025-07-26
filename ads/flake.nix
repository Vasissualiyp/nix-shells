{
  description = "Citerius flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };
        ads = pkgs.python311Packages.buildPythonPackage rec {
          pname = "ads";
          version = "0.12.7";
    	  src = pkgs.fetchFromGitHub {
  		    owner = "andycasey";
  		    repo = "ads";
  		    rev = "6aa0e854a1f3dc1dcd242a36426ad5855b2cbcfe";
  		    hash = "sha256-lGfCyDCxRfLmzzAXpAJtxczWK1/UdEC7096JRBiKEcs=";
  		  };
          propagatedBuildInputs = with pkgs.python311Packages; [ six requests werkzeug mock ];
        };
          python = pkgs.python311Packages.python;
          pythonEnv = (python.withPackages (ps: with ps; [
		  ads
		  ]));
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            pythonEnv
          ];
        };
      }
    );
}
