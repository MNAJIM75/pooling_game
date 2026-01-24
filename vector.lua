local vector = {}

function vector.new(_x, _y)
  return {x = _x or 0, y = _y or 0}
end

function vector.length(_v)
  local sqr_length = vector.sqr_length(_v)
  return math.sqrt(sqr_length)
end

function vector.sqr_length(_v)
  local x, y = _v.x, _v.y
  return x*x+y*y
end

function vector.sqr_dist(_va, _vb)
  local x = _va.x - _vb.x
  local y = _va.y - _vb.y
  return x*x+y*y
end

function vector.distance(_va, _vb)
  local x = _va.x - _vb.x
  local y = _va.y - _vb.y
  local r = x*x+y*y
  return math.sqrt(r)
end


return vector
