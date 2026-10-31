# Pane resize mode

Press `Ctrl+S`, release, then `r` in the Herdr desktop app. Use `h/j/k/l`
or the arrow keys to move a split boundary by 5% of the adjacent panes'
combined size. Only a small status strip appears at the bottom; panes stay
fully visible without dimming or a central dialog. Press Escape or Enter,
or click, to finish. Unzoom a pane first with
`Ctrl+S`, then `z`.

The mod reads the tab's split tree once when opened, using `python3` and
`hc connect` (`doc.get`). Size changes use Herdr's `layout.resize` command,
which persists them through the app. It never writes the core document
directly. Reopen resize mode after changing the tab's split structure.

The mod supports nested horizontal and vertical splits, including remote
spaces. It keeps each adjacent pair's total weight and limits its ratio
to 10–90%. Fixed pixel sizes are left alone.

`install.sh` installs this folder through Stow. The binding lives in
`../../keys.json`.

Validation:

```sh
node --test model.test.mjs
/Applications/Herdr.app/Contents/MacOS/Herdr check "$PWD"
```
