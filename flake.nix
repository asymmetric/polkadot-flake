{
  description = "Polkadot flake";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    polkadot = {
      url = github:paritytech/polkadot/v0.8.29;
      flake = false;
    };
  };

  outputs = { self, nixpkgs, polkadot }: {

    defaultPackage.x86_64-linux =
      with import nixpkgs { system = "x86_64-linux"; };

      rustPlatform.buildRustPackage {
        pname = "polkadot";
        version = "0.8.29";

        src = polkadot;

        cargoSha256 = "sha256-4VmRIrd79odnYrHuBLdFwere+7bvtUI3daVs3ZUKsdY=";

        nativeBuildInputs = [ clang ];

        LIBCLANG_PATH = "${llvmPackages.libclang}/lib";
        PROTOC = "${protobuf}/bin/protoc";
        SKIP_WASM_BUILD = 1;

        doCheck = false;
      };

  };
}
