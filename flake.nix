{
  description = "A flake for roslyn-language-server";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        roslyn-language-server = pkgs.rustPlatform.buildRustPackage {
          pname = "roslyn-language-server";
          version = "0.1.0";

          src = ./.;

          cargoLock = {
            lockFile = ./Cargo.lock;
          };
        };
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = [ roslyn-language-server ];
        };

        packages.roslyn-language-server = roslyn-language-server;
      }
    );
}
