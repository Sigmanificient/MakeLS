{
  description = "Language Server for Make(file)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    pre-commit-hooks,
  }: let
    defaultSystems = [
      "aarch64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
      "x86_64-linux"
    ];

    forAllSystems = function:
      nixpkgs.lib.genAttrs defaultSystems
      (system: function nixpkgs.legacyPackages.${system});
  in {
    formatter = forAllSystems (pkgs: pkgs.alejandra);

    checks = forAllSystems (pkgs: let
      commit-name = {
        enable = true;
        name = "commit name";
        entry = ''
          ${pkgs.python310.interpreter} ${./check_commit_msg_format.py}
        '';

        stages = ["commit-msg"];
      };

      hooks = {
        inherit commit-name;

        alejandra.enable = true;
        check-merge-conflicts.enable = true;
        check-shebang-scripts-are-executable.enable = true;
        check-added-large-files.enable = true;
      };
    in {
      pre-commit-check = pre-commit-hooks.lib.${pkgs.system}.run {
        inherit hooks;
        src = ./.;
      };
    });

    devShells.default = forAllSystems (pkgs:
      pkgs.mkShell {
        packages = with pkgs; [
          python310
          black
        ];
      });

    packages = forAllSystems (pkgs: let
      pypkgs = pkgs.python310.pkgs;
    in {
      default = self.packages.${pkgs.system}.make_ls;
      make_ls =
        pypkgs.callPackage ./make_ls.nix
        {};
    });
  };
}
