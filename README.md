# cider-i3xrocks

An [i3xrocks](https://github.com/regolith-linux/i3xrocks) blocklet that displays the currently playing track from [Cider](https://cider.sh/) (Apple Music) in your i3bar.

Shows **Artist - Song** when music is playing. Left-click toggles play/pause. Hides automatically when Cider isn't running or nothing is playing.

## Prerequisites

- [Regolith Linux](https://regolith-linux.org/) with i3xrocks
- [Cider](https://cider.sh/) with RPC API enabled
- `curl`, `jq` (install with `sudo apt install curl jq`)

## Installation

```bash
git clone https://github.com/your-user/cider-i3xrocks.git
cd cider-i3xrocks
./install.sh
```

### Configure your API token

Get your Cider RPC API token from Cider's settings, then:

```bash
echo 'your-token-here' > ~/.config/cider-i3xrocks/token
chmod 600 ~/.config/cider-i3xrocks/token
```

The token file is readable only by your user (unix file permissions).

### Activate

Reload i3 to pick up the new block:

```bash
regolith-look refresh
```

## Customization

Override these [Xresources](https://regolith-linux.org/docs/howtos/override-xres/) to customize appearance:

| Xresource | Default | Description |
|-----------|---------|-------------|
| `i3xrocks.label.cider` | `♫` | Icon/label before the track info |
| `i3xrocks.cider.maxlength` | `40` | Max display length before truncation |
| `i3xrocks.label.color` | `#7B8394` | Icon color |
| `i3xrocks.value.color` | `#D8DEE9` | Track text color |
| `i3xrocks.value.font` | `Source Code Pro Medium 13` | Font |

## Troubleshooting

Test the Cider API directly:

```bash
# Check Cider is running (should return 204)
curl -s -o /dev/null -w "%{http_code}" \
  -H "apitoken: $(cat ~/.config/cider-i3xrocks/token)" \
  http://localhost:10767/api/v1/playback/active

# Get now-playing info
curl -s -H "apitoken: $(cat ~/.config/cider-i3xrocks/token)" \
  http://localhost:10767/api/v1/playback/now-playing | jq .
```

Test the blocklet script directly:

```bash
bash scripts/cider
```

## Uninstall

```bash
sudo rm /usr/share/i3xrocks/scripts/cider
sudo rm /etc/regolith/i3xrocks/conf.d/50-cider
rm -rf ~/.config/cider-i3xrocks
```

## License

MIT
