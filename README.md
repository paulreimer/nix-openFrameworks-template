# nix-openFrameworks-template

## Build
### Using nix
```
nix build ".?submodules=1"
```

The application executable will be in `result/bin/`.

### Directly using `gn`
```
nix develop ".?submodules=1"
gn gen out
ninja -C out openFrameworks
ninja -C out
```

The application executable will be in `out/`.
