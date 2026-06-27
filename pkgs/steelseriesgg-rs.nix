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
    rev   = "4a4dfb46ff066fcee96e1db795badae9ef1226ef";
    hash  = "sha256-BANyLv16QgGDZ8d2/y4uTCQI2cODRC3MqTqvingRYvw=";
  };

  cargoHash = "sha256-tDaWYgelLcTh99QgzOIoOH7fzXJAuGp0X7OjmmirkO4=";

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
