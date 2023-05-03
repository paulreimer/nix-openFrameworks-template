# nix-openFrameworks-template

## Build
### Using nix
```
nix build ".?submodules=1"
```

The application executable will be in `result/bin/`.

### Directly using `gn`
```
nix develop
gn gen out
ninja -C out
```

The application executable will be in `out/`.
