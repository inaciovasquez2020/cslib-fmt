"""Exact fixed-5-edge directed graph enumerator, bounded and dependency-free.

Run next to locality_audit.py, e.g.: python3 locality_chunk5.py 0 5000
A timeout or invalid range exits nonzero; no partial run is a PASS.
"""
import sys,itertools,time,json,math
from locality_audit import canon,ef_types,ball

start=int(sys.argv[1]); stop=int(sys.argv[2]); n=5
if not (0 <= start < stop <= math.comb(25, 5) and stop - start <= 5000):
    raise SystemExit("RANGE_INVALID: require 0 <= start < stop <= 53130 and chunk <= 5000")
t0=time.monotonic(); s={'start':start,'stop':stop,'graphs':0,'r2_iso_pairs':0,'r2_q2_failures':0,'r3_iso_pairs':0,'r3_q2_failures':0}
for index, edges in enumerate(itertools.islice(itertools.combinations(range(25),5),start,stop)):
    if index % 128 == 0 and time.monotonic() - t0 > 120:
        raise TimeoutError("CHUNK_INCOMPLETE_TIMEOUT_120S")
    g=sum(1<<e for e in edges)
    types=ef_types(g,n,2)
    balls2=[ball(g,r,n,2) for r in range(n)]
    balls3=[ball(g,r,n,3) for r in range(n)]
    cache={}
    def sig(root,rad,b):
        # canonicalization only depends on actual rooted ball
        k=(root,b)
        if k not in cache: cache[k]=canon(g,root,n,rad)
        return cache[k]
    cs2=[sig(r,2,balls2[r]) for r in range(n)]
    cs3=[sig(r,3,balls3[r]) for r in range(n)]
    s['graphs']+=1
    for a in range(n):
        for b in range(a+1,n):
            if cs2[a]==cs2[b]:
                s['r2_iso_pairs']+=1
                if types[a]!=types[b]: s['r2_q2_failures']+=1
            if cs3[a]==cs3[b]:
                s['r3_iso_pairs']+=1
                if types[a]!=types[b]: s['r3_q2_failures']+=1
s['wall_seconds']=round(time.monotonic()-t0,3)
print(json.dumps(s,sort_keys=True),flush=True)
