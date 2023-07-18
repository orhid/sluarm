local sluarm = {}

os.capture = function (cmd)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

local stringify_params = function (params)
  local output = ''
  for key, value in pairs(params) do
    output = output .. ' --' .. key:gsub('_', '-') .. ' ' .. value
  end
  return output
end

sluarm.srun = function (command, params)
  local jobid = os.capture('srun' .. stringify_params(params) .. ' ' .. command):gsub('[^%d]', '')
  return jobid
end

sluarm.sbatch = function (command, params)
  local jobid = os.capture('sbatch' .. stringify_params(params) .. ' ' .. command):gsub('[^%d]', '')
  return jobid
end

sluarm.status = function (jobid)
  os.capture('sacct -nPX -o State -j ' .. jobid)
end

return sluarm
