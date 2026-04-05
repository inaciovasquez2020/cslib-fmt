#!/usr/bin/env bash
set -euo pipefail

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

cat > "$TMP/cur2_witness.py" <<'PY'
#!/usr/bin/env python3
from collections import deque

def normalize_edge(u, v):
    return (u, v) if u <= v else (v, u)

class Graph:
    def __init__(self, n, edges):
        self.n = n
        self.edges = sorted({normalize_edge(u, v) for (u, v) in edges})
        self.adj = {i: set() for i in range(n)}
        for u, v in self.edges:
            self.adj[u].add(v)
            self.adj[v].add(u)

    def dist(self, s, t):
        q = deque([s])
        seen = {s: 0}
        while q:
            u = q.popleft()
            if u == t:
                return seen[u]
            for v in sorted(self.adj[u]):
                if v not in seen:
                    seen[v] = seen[u] + 1
                    q.append(v)
        return None

    def ball_code(self, root, R):
        q = deque([root])
        seen = {root: 0}
        order = [root]
        while q:
            u = q.popleft()
            if seen[u] == R:
                continue
            for v in sorted(self.adj[u]):
                if v not in seen:
                    seen[v] = seen[u] + 1
                    if seen[v] <= R:
                        q.append(v)
                        order.append(v)
        verts = sorted(seen.keys(), key=lambda x: (seen[x], x))
        idx = {v: i for i, v in enumerate(verts)}
        ecode = []
        for u in verts:
            for v in verts:
                if idx[u] < idx[v] and v in self.adj[u]:
                    ecode.append((idx[u], idx[v]))
        levels = tuple(seen[v] for v in verts)
        return (levels, tuple(ecode))

    def local_multiset(self, R):
        return tuple(sorted(self.ball_code(v, R) for v in range(self.n)))

    def connected_components(self):
        seen = set()
        c = 0
        for s in range(self.n):
            if s in seen:
                continue
            c += 1
            q = deque([s])
            seen.add(s)
            while q:
                u = q.popleft()
                for v in self.adj[u]:
                    if v not in seen:
                        seen.add(v)
                        q.append(v)
        return c

    def cycle_rank(self):
        return len(self.edges) - self.n + self.connected_components()

def lift_from_base(base_n, base_edges, twist_edge_set):
    lift_edges = []
    for (u, v) in base_edges:
        twisted = normalize_edge(u, v) in twist_edge_set
        for b in (0, 1):
            uu = 2 * u + b
            vv = 2 * v + (1 - b if twisted else b)
            lift_edges.append(normalize_edge(uu, vv))
    return Graph(2 * base_n, lift_edges)

def cycle4_base():
    return 4, [(0,1), (1,2), (2,3), (3,0)]

def main():
    base_n, base_edges = cycle4_base()
    G0 = lift_from_base(base_n, base_edges, set())
    G1 = lift_from_base(base_n, base_edges, {normalize_edge(0,1)})

    R = 1
    local_eq = (G0.local_multiset(R) == G1.local_multiset(R))

    cur2_G0 = G0.cycle_rank()
    cur2_G1 = G1.cycle_rank()
    sep = (cur2_G0 != cur2_G1)

    print(f"R={R}")
    print(f"LOCAL_EQ={1 if local_eq else 0}")
    print(f"CUR2_G0={cur2_G0}")
    print(f"CUR2_G1={cur2_G1}")
    print(f"CUR2_SEPARATES={1 if sep else 0}")

    if local_eq and sep:
        print("TIFF_WITNESS_FOUND")
    else:
        print("NO_TIFF_WITNESS")

if __name__ == "__main__":
    main()
PY

python3 "$TMP/cur2_witness.py"
