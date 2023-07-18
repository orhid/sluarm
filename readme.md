a lua library for basic slurm operations. this was mostly for my limited needs and has room for much more development.

*tested only on the clusters at ACK Cyfronet AGH*

# usage
both commands `sluarm.sbatch` and `sluarm.srun` take two arguments: the command to be executed as a string and a table of parameters to slurm. both return the jobid of the submitted job.

```lua
local params = {}
params.time = '00:36:00'
params.job_name = 'example-job'
params.nodes = '3'

local sluarm = require 'sluarm'
local jobid = sluarm.sbatch('batch-script', params)
print(jobid)
```

the command `sluarm.status` takes a jobid and returns its status
