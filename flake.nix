{
  description = "Breeze cursors";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils/main";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      packagesFor = pkgs:
        let
          breeze-cursors = pkgs.stdenv.mkDerivation {
            pname = "breeze-cursors";
            version = self.lastModifiedDate;
            src = self;
            installPhase = ''
              mkdir -p $out/share/icons
              cp -r Breeze $out/share/icons
              cp -r Breeze_Light $out/share/icons
            '';
            meta = {
              description = "Breeze cursors";
              homepage = "https://github.com/stephaneyfx/breeze-cursors";
              license = pkgs.lib.licenses.lgpl3Only;
              platforms = pkgs.lib.platforms.all;
            };
          };
        in {
          inherit breeze-cursors;
          default = breeze-cursors;
        };
    in {
      overlays.default = final: prev: packagesFor final;
    } // flake-utils.lib.eachDefaultSystem (system: {
      packages = packagesFor nixpkgs.legacyPackages.${system};
    });
}
