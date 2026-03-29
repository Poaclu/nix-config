# In your flake or a dedicated file, e.g. my-tool.nix
{ 
  lib,
  rustPlatform,
  fetchFromGitHub,
  llvmPackages
}:

rustPlatform.buildRustPackage {
  pname = "steelseriesgg-rs";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "Ven0m0";
    repo  = "steelseriesgg-rs";
    rev   = "main";
    hash  = "sha256-XQQe4QSJjMo8O+ptgSEfU1mkR2Rg8DXQQqAytfl6Mm8=";
  };

  cargoHash = "sha256-ToNbpG+vqLG1QKudjdAmkkYui/+0RKYc63n/mIrvDss=";

  doCheck = false; # skip tests — upstream bug in security_diagnostics.rs

  nativeBuildInputs = [
    llvmPackages.lld
    llvmPackages.bintools
  ];

  postInstall = ''
    mkdir -p $out/lib/udev/rules.d
    cp $src/assets/99-steelseries.rules $out/lib/udev/rules.d/
  '';

  meta = {
    description = "steelseriesgg-rs – SteelSeries GG for Linux";
    homepage    = "https://github.com/Ven0m0/steelseriesgg-rs";
    license     = lib.licenses.mit;
    maintainers = [];
    mainProgram = "ssgg";
  };
}
