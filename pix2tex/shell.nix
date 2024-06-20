{ pkgs ? import <nixpkgs> {} }:
let
  pix2tex = pkgs.python311Packages.buildPythonPackage rec {
	pname = "pix2tex";
	version = "0.1.2";
    format = "wheel";
    src = pkgs.fetchurl {
      url = "https://files.pythonhosted.org/packages/ef/51/e5a49cee59c8632723a18f7b1a5f2d431825f589b12f6d61891ba020d8fb/pix2tex-0.1.2-py3-none-any.whl";
      sha256 = "sha256-3GRHxaijpW/I0NT3XKqI9GVsuGuI1qcVpE9gAFUv8Jc=";
    };
	postInstall = ''
      # Define the writable directory for weights
      #mkdir /home/vasilii/Software/LaTeX-OCR/weights
      # Create the symlink
      ln -sfn /home/vasilii/Software/LaTeX-OCR/weights $out/lib/python3.11/site-packages/pix2tex/model/checkpoints
    '';
  };
  xtransformers = pkgs.python311Packages.buildPythonPackage rec {
    pname = "x-transformers";
    version = "0.15.0";
    format = "wheel";
    src = pkgs.fetchurl {
	  url = "https://files.pythonhosted.org/packages/be/52/62fd9d73f4c3f56442c590bc020f25597df5ba37db789f7861922b991e5c/x_transformers-0.15.0-py3-none-any.whl";
      sha256 = "sha256-f+788y9GAFwrkUHX3AsIoKRy5Kf06h+V6ejdTnkicwk=";
    };
  };
  entmax = pkgs.python311Packages.buildPythonPackage rec {
    pname = "entmax";
    version = "1.0";
    src = pkgs.fetchPypi {
	  inherit pname version;
      sha256 = "sha256-HNlyHDSTWCTgccjCCQBxHK1gw9hLyeRmjzt6iHO/Ys8=";
    };
    buildInputs = with pkgs.python311Packages; [ torch pytest ];
  };
in
  pkgs.mkShell {
    buildInputs = [
	 # For building: pix2tex
     pkgs.python311
     pkgs.python311Packages.pytorch
     pkgs.python311Packages.albumentations
     pkgs.python311Packages.pyqt6
     pkgs.python311Packages.pyqt6-webengine
     pkgs.python311Packages.screeninfo
     pkgs.python311Packages.pynput
     pkgs.python311Packages.pyside6
	 # For building xtransformers and running pix2tex
     pkgs.python311Packages.einops
     pkgs.python311Packages.torch
     entmax
	 # For running pix2tex
     pkgs.python311Packages.pandas
     pkgs.python311Packages.munch
     pkgs.python311Packages.transformers
     pkgs.python311Packages.timm
     pkgs.python311Packages.tqdm
     pkgs.python311Packages.tokenizers
     pkgs.python311Packages.numpy
     pkgs.python311Packages.pillow
     #pkgs.python311Packages.entmax
	 pix2tex
	 xtransformers
    ];
  }
