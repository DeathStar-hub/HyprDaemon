# Paru Bottom-Up Search Fix

To enable bottom-up search order in paru (most popular results first without scrolling):

```bash
mkdir -p ~/.config/paru
echo "[options]" > ~/.config/paru/paru.conf
echo "BottomUp" >> ~/.config/paru/paru.conf
```

Or create `~/.config/paru/paru.conf` manually with:

```
[options]
BottomUp
```

This prints search results from bottom to top, placing high-popularity packages at the top of the output.

Run `paru -Ss <package>` to test—results should start with the most popular packages.