import { View, div } from "gpui-kit";
import { v_flex } from "gpui-base";
import { appHome, closeOverlay, exec, focused, panes, props, run, spaces, theme } from "herdr";
import { applySizes, resize } from "./model.js";

export default class PaneResize extends View {
  init(_props, cx) {
    this.target = focused();
    this.root = null;
    this.message = "Loading…";
    this.closed = false;
    this.handle = cx.focus_handle();
    this.handle.focus();
    const pane = panes().find(p => p.pane === this.target?.pane);
    if (!pane || pane.zoomed) {
      this.message = pane?.zoomed ? "Unzoom the pane with Ctrl+S, Z first." : "Focus a split pane first.";
      return;
    }
    const space = spaces().find(s => s.id === this.target.space);
    this.machine = space?.machine ?? null;
    this.local = id => this.machine && id.startsWith(`${this.machine}/`) ? id.slice(this.machine.length + 1) : id;
    cx.spawn(async cx => {
      try {
        const result = await exec("python3", [`${appHome()}/mods/pane-resize/read-layout.py`, ...(this.machine ? [this.machine] : [])]);
        if (this.closed) return;
        if (result.code !== 0) throw new Error(result.stderr.trim() || "Cannot read pane layout.");
        const document = JSON.parse(result.stdout);
        this.root = document?.spaces?.find(s => s.id === this.local(this.target.space))?.tabs?.find(t => t.id === this.local(this.target.tab))?.root ?? null;
        this.message = this.root ? "h j k l / ← ↓ ↑ →: resize · Esc / Enter: done" : "No split pane found in this tab.";
      } catch (error) {
        this.message = String(error.message ?? error);
      }
      cx.notify();
    });
  }

  close() { this.closed = true; }

  dismiss(cx) {
    this.closed = true;
    closeOverlay(props().overlay);
    cx.stop_propagation();
  }

  key(event, cx) {
    if (event.key === "escape" || event.key === "enter") {
      this.dismiss(cx);
      return;
    }
    const modifiers = event.modifiers;
    if (modifiers.control || modifiers.alt || modifiers.platform) return;
    const key = event.key_char ?? event.key;
    const direction = { h: "left", j: "down", k: "up", l: "right", left: "left", down: "down", up: "up", right: "right" }[key];
    if (!direction) return;
    cx.stop_propagation();
    if (!this.root || this.closed) return;
    if (focused()?.pane !== this.target.pane || panes().find(p => p.pane === this.target.pane)?.zoomed) {
      this.message = "Pane focus changed. Close and reopen resize mode.";
      cx.notify();
      return;
    }
    try {
      const sizes = resize(this.root, this.local(this.target.pane), direction);
      for (const size of sizes) run("layout.resize", { ...size, id: this.machine ? `${this.machine}/${size.id}` : size.id });
      applySizes(this.root, sizes);
      this.message = sizes.length ? "h j k l / ← ↓ ↑ →: resize · Esc / Enter: done" : "No movable boundary in this direction.";
    } catch (error) {
      this.message = String(error.message ?? error);
    }
    cx.notify();
  }

  render() {
    const t = theme();
    return v_flex().id("pane-resize").track_focus(this.handle)
      .on_key_down((event, cx) => this.key(event, cx))
      .on_mouse_down("left", (_event, cx) => this.dismiss(cx))
      .on_mouse_down("right", (_event, cx) => this.dismiss(cx))
      .size_full().justify_end()
      .child(div().w_full().h(28).px(12).flex().items_center()
        .bg(t.chrome).text_size(12).text_color(t.accent)
        .child(`Resize · ${this.message}`));
  }
}
