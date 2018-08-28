--vim: ts=2 sw=2 sts=2 expandtab:cindent:formatoptions+=cro 
--------- --------- --------- --------- --------- --------- 

require "sample"

-- ## Example

--
--      n = nums{ 4,10,15,38,54,57,62,83,100,100,174,190,
--                215,225,233,250,260,270,299,300,306,
--                333,350,375,443,475,525,583,780,1000}
--      print(n.mu, n.sd) ==> 270.3, 231.946
--    

-- Inside a `num`:

function num()  
  return {n=0, mu=0, m2=0, sd=0, 
          lo=10^32, hi=-10^32, some=sample(),
          w=1}
end

-- Bulk add to a `num`:

function nums(t,f,      n)
  f=f or function(x) return x end
  n=num()
  for _,x in pairs(t) do numInc(n, f(x)) end
  return n
end

-- Add `x` to a `num`:

function numInc(t,x,    d) 
  if x == "?" then return x end
  t.n  = t.n + 1
  sampleInc(t.some, x)
  d    = x - t.mu
  t.mu = t.mu + d/t.n
  t.m2 = t.m2 + d*(x - t.mu)
  if x > t.hi then t.hi = x end
  if x < t.lo then t.lo = x end
  if (t.n>=2) then 
    t.sd = (t.m2/(t.n - 1 + 10^-32))^0.5 end
  return x  
end

-- Remove `x` from a `num`. Note: due to
-- the approximation of this method, this
-- gets inaccurate for small `x` numbers
-- and very small sample sizes (small `n`,
-- say, less than 5)

function numDec(t,x,    d) 
  if (x == "?") then return x end
  if (t.n == 1) then return x end
  t.n  = t.n - 1
  d    = x - t.mu
  t.mu = t.mu - d/t.n
  t.m2 = t.m2 - d*(x- t.mu)
  if (t.n>=2) then
    t.sd = (t.m2/(t.n - 1 + 10^-32))^0.5 end
  return x
end

-- Normalization

function numNorm(t,x,     y) 
  return x=="?" and 0.5 or (x-t.lo) / (t.hi-t.lo + 10^-32)
end

-- Misc

function numXpect(i,j,   n)  
  n = i.n + j.n +0.0001
  return i.n/n * i.sd+ j.n/n * j.sd
end
