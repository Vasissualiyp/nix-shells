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
        arxiv = pkgs.python311Packages.buildPythonPackage rec {
          pname = "arxiv";
          version = "2.1.3";
          src = pkgs.fetchPypi {
            inherit pname version;
            sha256 = "sha256-MjZSIZlNLPBWV8H632OibvyMzewYWQKB7gNRW/74vE4=";
          };
          propagatedBuildInputs = with pkgs.python311Packages; [ feedparser requests ];
        };
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            arxiv
          ];
        };
      }
    );
}
