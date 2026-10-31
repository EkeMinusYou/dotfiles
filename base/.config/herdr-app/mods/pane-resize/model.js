// Move the nearest split boundary without changing the total sibling weight.
export function resize(root, pane, direction, step = 0.05) {
  const axis = { left: "row", right: "row", up: "column", down: "column" }[direction];
  if (!axis) return [];
  const path = [];
  function find(node) {
    if (node.id === pane) return true;
    const children = (node.children ?? []).filter(child => !child.hidden);
    for (let index = 0; index < children.length; index++) {
      path.push({ node, children, index });
      if (find(children[index])) return true;
      path.pop();
    }
    return false;
  }
  if (!find(root)) return [];
  const split = path.reverse().find(({ node, children }) => node.type === axis && node.resizable !== false && children.length > 1);
  if (!split) return [];
  const { children, index } = split;
  const forward = direction === "right" || direction === "down";
  const before = forward ? Math.min(index, children.length - 2) : Math.max(0, index - 1);
  const a = children[before], b = children[before + 1];
  if (a.size?.px !== undefined || b.size?.px !== undefined) {
    throw new Error("This split uses fixed pixel sizes.");
  }
  const aw = a.size?.weight ?? 1, bw = b.size?.weight ?? 1;
  if (!(aw > 0 && bw > 0 && Number.isFinite(aw + bw))) throw new Error("Invalid split sizes.");
  const total = aw + bw;
  const current = aw / total;
  const bounded = Math.max(0.1, Math.min(0.9, current + (forward ? step : -step)));
  const share = forward ? Math.max(current, bounded) : Math.min(current, bounded);
  if (Math.abs(share - current) < 0.000001) return [];
  return [{ id: a.id, weight: total * share }, { id: b.id, weight: total * (1 - share) }];
}

export function applySizes(root, sizes) {
  const byId = new Map(sizes.map(size => [size.id, size.weight]));
  function visit(node) {
    if (byId.has(node.id)) node.size = { weight: byId.get(node.id) };
    for (const child of node.children ?? []) visit(child);
  }
  visit(root);
}
