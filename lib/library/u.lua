local U  = function (self, x, y )

  self.y = y
  self.x = x
  self.name = 'uclid'
  self.ports = { {-1, 0, 'in-pulses' },  { 1, 0, 'in-steps' }, {0, 1, 'u-output' } }
  self:spawn(self.ports)

  local pulses = self:listen(self.x - 1, self.y) or 1
  local steps = self:listen(self.x + 1, self.y) or 8
  local pos = pulses > 0 and (self.frame  % (steps == 0 and 1 or steps) + 1) or 0
  local pattern = self:gen_pattern(pulses, steps)
  local out = pattern[pos] and '*' or '.'
  
  self:write(0, 1, out)
  
end

return U