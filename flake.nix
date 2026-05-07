{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};

      # [PHP and PHP extensions][1] required by [Laravel][2].
      #
      # [1]: https://nixos.org/manual/nixpkgs/stable/#sec-php
      # [2]: https://laravel.com/docs/13.x/deployment
      php = pkgs.php85.withExtensions ({ all, ... }: with all; [
        ctype
        curl
        dom
        fileinfo
        filter
        # hash          # Already bundled with PHP - https://www.php.net/manual/en/hash.installation.php
        mbstring
        openssl
        # pcre          # Already bundled with PHP - https://www.php.net/manual/en/pcre.installation.php
        pdo
        session
        tokenizer
        # xml           # Removed for "module already loaded" error with composer
        iconv           # Required by mbstring
        xmlwriter       # Required by composer and phpunit
        pdo_sqlite      # Required by laravel as default
      ]);
    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          php
          php.packages.composer
        ];
      };
    };
}
