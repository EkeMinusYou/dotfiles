import assert from "node:assert/strict";
import { test } from "node:test";
import { applySizes, resize } from "./model.js";

const pane = (id, weight = 1) => ({ id, type: "block", size: { weight } });
const split = (id, type, ...children) => ({ id, type, children });

test("moves the same horizontal boundary from either pane and preserves its total weight", () => {
  const root = split("tab", "row", pane("a", 2), pane("b", 3));
  assert.deepEqual(resize(root, "a", "right"), [{ id: "a", weight: 2.25 }, { id: "b", weight: 2.75 }]);
  const left = resize(root, "b", "left");
  assert.ok(Math.abs(left[0].weight - 1.75) < 0.000001);
  assert.equal(left[0].weight + left[1].weight, 5);
  applySizes(root, resize(root, "a", "right"));
  assert.equal(root.children[0].size.weight, 2.25);
});

test("finds the nearest matching split axis through nested panes", () => {
  const root = split("tab", "row", pane("a"), split("right", "column", pane("b"), pane("c")));
  assert.deepEqual(resize(root, "c", "up").map(size => size.id), ["b", "c"]);
  assert.deepEqual(resize(root, "c", "left").map(size => size.id), ["a", "right"]);
  assert.deepEqual(resize(root, "a", "down"), []);
});

test("selects the adjacent boundary in the requested direction among three siblings", () => {
  const root = split("tab", "row", pane("a"), pane("b"), pane("c"));
  assert.deepEqual(resize(root, "b", "left").map(size => size.id), ["a", "b"]);
  assert.deepEqual(resize(root, "b", "right").map(size => size.id), ["b", "c"]);
});

test("limits repeated resizing without reversing movement at an existing extreme", () => {
  const root = split("tab", "row", pane("a"), pane("b"));
  for (let i = 0; i < 50; i++) applySizes(root, resize(root, "a", "right"));
  assert.equal(root.children[0].size.weight, 1.8);
  assert.deepEqual(resize(root, "a", "right"), []);
  root.children[0].size.weight = 99;
  root.children[1].size.weight = 1;
  assert.deepEqual(resize(root, "a", "right"), []);
  assert.ok(resize(root, "a", "left")[0].weight < 99);
});

test("leaves unrelated, hidden and non-resizable nodes alone", () => {
  const root = split("tab", "row", pane("a"), { ...pane("hidden"), hidden: true }, pane("b"));
  assert.deepEqual(resize(root, "missing", "right"), []);
  assert.deepEqual(resize(root, "a", "right").map(size => size.id), ["a", "b"]);
  root.resizable = false;
  assert.deepEqual(resize(root, "a", "right"), []);
});
