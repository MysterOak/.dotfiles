# TODO
- [ ] Integrate secrets management -> [sops-nix](https://github.com/Mic92/sops-nix) / [agenix](https://github.com/ryantm/agenix)
- [ ] Improve documentation -> comments and readme (maybe docs folder?)
- [ ] Clean up one-click install+deployment
- [ ] Make everything into options (programs, services, etc.) to make each host config more modular/easier to comprehend
- [ ] Finish & polish the server config
- [ ] Integrate ricing into dotfiles
- [x] GitOps -> [comin](https://github.com/nlewo/comin/tree/main)

# Installation on an empty machine

0. Clone the repo to an existing machine with nix
```bash
cd && git clone https://github.com/MysterOak/.dotfiles
```
Make sure `~/.dotfiles/.iso/default.nix` contains a valid ssh key!!

1. On said machine, create the installer-iso from the flake by running:
```bash
nix build ~/.dotfiles#nixosConfigurations.iso.config.system.build.isoImage
```
This assumes that the `.dotfiles` directory is in `~/.dotfiles`. If not, adjust accordingly.

2. Boot the new system into the created iso. (**!!Disable secure boot!!**)

3. Run nixos-anywhere, replace the target ip & the hostname with the values of the target
```bash
TARGET=x.x.x.x
HOSTNAME=your-target-hostname
nix run github:nix-community/nixos-anywhere -- --flake "~/.dotfiles#${HOSTNAME}" --target-host nixos@"${TARGET}"
```

4. Secureboot [hint](https://github.com/nix-community/lanzaboote/issues/413)

# Installation on an existing machine

0. Clone the repo to a (different) existing machine with nix
```bash
cd && git clone https://github.com/MysterOak/.dotfiles
```
Make sure `~/.dotfiles/.iso/default.nix` contains a valid ssh key!! (/ or have ssh password auth enabled for an admin user)

1. Run nixos-anywhere, replace the target ip & the hostname with the values of the target
```bash
TARGET = x.x.x.x
HOSTNAME = your-target-hostname
nix run github:nix-community/nixos-anywhere -- --flake "~/.dotfiles/.#${HOSTNAME}" --target-host root@"${TARGET}"
```

2. Secureboot [hint](https://github.com/nix-community/lanzaboote/issues/413)
