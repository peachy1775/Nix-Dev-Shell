{
  description = "A CTF Nix Shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      config.allowUnsupportedSystem = true;
    };
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        # Essentials
        openvpn
        docker
        unzip
        file
        steam-run

        # Network tools
        nmap
        netcat-gnu
        wireshark
        gobuster
        burpsuite

        # Binaries / Debuggers / Reverse Engineering Tools
        nix-ld
        strace
        ltrace
        hexedit
        gdb
        radare2
        ghidra
        binwalk
        fastjar

        # Brute force/hash/login tools
        hydra
        medusa
        hashcat
        hashid

        # Exploits
        metasploit

        # Web Exploits
        sqlmap

        # Steganography / Image hacks
        exiftool
        steghide
        zsteg
        pngcheck

        # Programming/Scripting
        nasm
        pyright
        (python3.withPackages (python-pkgs: with python-pkgs; [
          # Web exploitation
          requests
          flask
          beautifulsoup4
          urllib3
          websockets
          httpx
          jwt

          # Reverse engineering / binary exploitation
          pwntools
          capstone
          unicorn
          keystone
          angr
          z3-solver

          # Crypto
          pycryptodome
          base58
          gmpy2
          sympy

          # General-purpose / scripting
          numpy
          python
          matplotlib
          tqdm
          ipython
          black
          isort
          pytest
          mypy
          pipx
        ]))
      ];

      shellHook = ''
        echo "Life Is Peachy"
        export PS1="\[\e[1;36m\]\A [GetHacked@\h] \[\e[38;5;151m\]\w\n\[\e[38;5;218m\]\\$\[\e[0m\] "
        alias e="exit"
        alias py="python3"
        
        # Fix massive UI scaling
        export QT_AUTO_SCREEN_SCALE_FACTOR=0
        export QT_SCALE_FACTOR=1
      '';
    };
  };
}
