# Shota's dotfiles

## Set up

```
$ sh brew.sh

# enable fish
echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish

$ sh darwin.sh
$ sh bootstrap.sh
$ sh mise.sh
```

## Set up colima

```
colima start \
  --arch aarch64 \
  --vm-type=vz \
  --vz-rosetta \
  --cpu 10 \
  --memory 12 \
  --disk 100 \
  --mount-type=virtiofs \
  --network-address
docker context use colima
```
