-- vim: ts=2 sw=2 sts=2 expandtab:cindent:formatoptions+=cro  
--------- --------- --------- --------- --------- ---------  

package.path = '../src/?.lua;' .. package.path 
require "lib"
require "ok"

function xxx()
end

-- ## Main 
-- If called as top-level file.

return {main = function() xxx() end}
