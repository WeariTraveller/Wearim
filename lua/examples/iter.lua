-- Will Iter:map() evaluate the callback eagerly?
local iter = vim.iter { 1, 2, 3 }
print "Iter:map will be called soon"
iter:map(function(v) print(v) end)
print "Iter:map has just been called, let's call Iter:totable"
iter:totable()
print "Iter:totable has been called"

-- Will vim.iter() evaluate the iterator function eagerly?
print "vim.iter will be called soon"
iter = vim.iter((function()
  local max = 3
  local curr = 0
  return function()
    curr = curr + 1
    if curr > max then return nil end
    print(curr)
    return curr
  end
end)())
print "vim.iter has just been called, let's call Iter:totable"
iter:totable()
print "Iter:totable has been called"
