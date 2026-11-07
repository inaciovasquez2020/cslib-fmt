"""Bounded exact locality audit, no dependencies and no repository mutation.

Semantics: one directed binary relation, self-loops allowed; ordered source/target
are vertices of the SAME finite structure. Signature of rooted radius-r induced
neighborhoods computed by exhaustive root-fixing permutations. EF ranks are
computed exactly using atomic types and finite sets of lower-rank extension types.
"""
import itertools, hashlib, json, sys, time


def nbr(g, x, n):
    return {y for y in range(n) if (g & (1 << (x*n+y))) or (g & (1 << (y*n+x)))}

def ball(g, root, n, r):
    a={root}; q={root}
    for _ in range(r):
        q=(set().union(*(nbr(g,x,n) for x in q)) if q else set())-a
        a |= q
    return tuple(sorted(a))

def canon(g, root, n, r):
    a=ball(g,root,n,r)
    if len(a)==1:
        return (1, bool(g & (1 << (root*n+root))))
    others=[x for x in a if x!=root]
    best=None
    for p in itertools.permutations(others):
        order=(root,)+p
        bits=0
        for i,u in enumerate(order):
            for j,v in enumerate(order):
                if g & (1 << (u*n+v)):
                    bits |= 1 << (i*len(a)+j)
        if best is None or bits<best: best=bits
    return len(a),best

def atoms(g,tup,n):
    k=len(tup)
    e=0
    idx=0
    for i in range(k):
        for j in range(i+1,k):
            if tup[i] == tup[j]: e|=1<<idx
            idx+=1
    for i in range(k):
        for j in range(k):
            if g & (1 << (tup[i]*n+tup[j])): e|=1<<idx
            idx+=1
    return e

def ef_types(g,n,q):
    """Quantifier-rank q exact one-root types via bounded back-and-forth."""
    def sub(t,d):
        a=atoms(g,t,n)
        if d==0: return a
        return (a, frozenset(sub(t+(x,),d-1) for x in range(n)))
    return [sub((x,),q) for x in range(n)]

def full_n4():
    n=4
    t=time.monotonic()
    stats={"graphs":0,"radius2_equal_pairs":0,"rank2_failures":0,"radius3_equal_pairs":0,"radius3_rank2_failures":0}
    for g in range(1<<(n*n)):
        stats['graphs']+=1
        r2=[canon(g,a,n,2) for a in range(n)]
        r3=[canon(g,a,n,3) for a in range(n)]
        typ=ef_types(g,n,2)
        for a in range(n):
            for b in range(a+1,n):
                if r2[a]==r2[b]:
                    stats['radius2_equal_pairs']+=1
                    if typ[a]!=typ[b]: stats['rank2_failures']+=1
                if r3[a]==r3[b]:
                    stats['radius3_equal_pairs']+=1
                    if typ[a]!=typ[b]: stats['radius3_rank2_failures']+=1
    stats['wall_seconds']=round(time.monotonic()-t,3)
    return stats

if __name__=='__main__':
    n=5
    witness={(0,1),(0,2),(1,3),(1,4),(3,0)}
    g=sum(1<<(u*n+v) for u,v in witness)
    t=ef_types(g,n,2)
    print('WITNESS',json.dumps({'r2_iso':canon(g,2,n,2)==canon(g,4,n,2),'rank2_non_equiv':t[2]!=t[4],'r3_iso':canon(g,2,n,3)==canon(g,4,n,3)}),flush=True)
    if '--full-4' in sys.argv:
        print('FULL4',json.dumps(full_n4(),sort_keys=True),flush=True)

def sparse_n5(max_edges=4):
    n=5
    t0=time.monotonic()
    stats={"graphs":0,"radius2_equal_pairs":0,"radius2_rank2_failures":0,"radius3_equal_pairs":0,"radius3_rank2_failures":0}
    for edge_count in range(max_edges+1):
        for edges in itertools.combinations(range(n*n),edge_count):
            g=sum(1<<e for e in edges)
            stats['graphs']+=1
            typ=ef_types(g,n,2)
            r2=[canon(g,x,n,2) for x in range(n)]
            r3=[canon(g,x,n,3) for x in range(n)]
            for a in range(n):
                for b in range(a+1,n):
                    if r2[a]==r2[b]:
                        stats['radius2_equal_pairs']+=1
                        if typ[a]!=typ[b]: stats['radius2_rank2_failures']+=1
                    if r3[a]==r3[b]:
                        stats['radius3_equal_pairs']+=1
                        if typ[a]!=typ[b]: stats['radius3_rank2_failures']+=1
    stats['max_edges']=max_edges
    stats['wall_seconds']=round(time.monotonic()-t0,3)
    return stats

if __name__=='__main__' and '--sparse-5-4' in sys.argv:
    print('SPARSE5',json.dumps(sparse_n5(4),sort_keys=True),flush=True)
