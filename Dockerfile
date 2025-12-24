Hi, I'm trying to fix my Fly.io deployment. There's a build error on my Dockerfile.

Please fix my Dockerfile for me to the best of your ability. And give me the updated version so I can paste in Fly.io web deployment UI.

Error logs:

```
flyctl deploy --build-only --push -a auto-vlog-ffmpeg-worker --image-label deployment-6d57fb7e0e29f4fcd107c3c288eb720c 
==> Verifying app config
Validating /usr/src/app/fly.toml
[32m✓[0m Configuration is valid
--> Verified app config
==> Building image
Waiting for depot builder...

==> Building image with Depot
--> build:  (​)
#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 207B 0.1s done
#1 DONE 0.2s

#2 [internal] load metadata for docker.io/library/node:18-bullseye
#2 DONE 0.5s

#3 [internal] load .dockerignore
#3 transferring context: 2B 0.1s done
#3 DONE 0.1s

#4 [1/6] FROM docker.io/library/node:18-bullseye@sha256:0d9e9a8dcd5a83ea737ed92227a6591a31ad70c8bb722b0c51aff7ae23a88b6a
#4 resolve docker.io/library/node:18-bullseye@sha256:0d9e9a8dcd5a83ea737ed92227a6591a31ad70c8bb722b0c51aff7ae23a88b6a done
#4 DONE 0.0s

#5 [internal] load build context
#5 transferring context: 43.16kB 0.1s done
#5 DONE 0.2s

#6 [2/6] RUN apt-get update && apt-get install -y ffmpeg
#6 CACHED

#7 [3/6] WORKDIR /app
#7 CACHED

#8 [4/6] COPY package.json ./
#8 CACHED

#9 [5/6] RUN npm install
#9 6.751 npm error code EJSONPARSE
#9 6.751 npm error path /app/package.json
#9 6.751 npm error JSON.parse Unexpected end of JSON input while parsing "\n"
#9 6.752 npm error JSON.parse Failed to parse JSON data.
#9 6.752 npm error JSON.parse Note: package.json must be actual JSON, not just JavaScript.
#9 6.756 npm error A complete log of this run can be found in: /root/.npm/_logs/2025-12-24T00_26_46_534Z-debug-0.log
#9 ERROR: process "/bin/sh -c npm install" did not complete successfully: exit code: 1
------
 > [5/6] RUN npm install:
6.751 npm error code EJSONPARSE
6.751 npm error path /app/package.json
6.751 npm error JSON.parse Unexpected end of JSON input while parsing "\n"
6.752 npm error JSON.parse Failed to parse JSON data.
6.752 npm error JSON.parse Note: package.json must be actual JSON, not just JavaScript.
6.756 npm error A complete log of this run can be found in: /root/.npm/_logs/2025-12-24T00_26_46_534Z-debug-0.log
------
==> Building image
Waiting for depot builder...

==> Building image with Depot
--> build:  (​)
#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 207B done
#1 DONE 0.0s

#2 [internal] load metadata for docker.io/library/node:18-bullseye
#2 DONE 0.2s

#3 [internal] load .dockerignore
#3 transferring context: 2B done
#3 DONE 0.0s

#4 [1/6] FROM docker.io/library/node:18-bullseye@sha256:0d9e9a8dcd5a83ea737ed92227a6591a31ad70c8bb722b0c51aff7ae23a88b6a
#4 resolve docker.io/library/node:18-bullseye@sha256:0d9e9a8dcd5a83ea737ed92227a6591a31ad70c8bb722b0c51aff7ae23a88b6a done
#4 DONE 0.0s

#5 [internal] load build context
#5 transferring context: 4.11kB 0.0s done
#5 DONE 0.0s

#6 [2/6] RUN apt-get update && apt-get install -y ffmpeg
#6 CACHED

#7 [3/6] WORKDIR /app
#7 CACHED

#8 [4/6] COPY package.json ./
#8 CACHED

#9 [5/6] RUN npm install
#9 0.856 npm error code EJSONPARSE
#9 0.857 npm error path /app/package.json
#9 0.857 npm error JSON.parse Unexpected end of JSON input while parsing "\n"
#9 0.857 npm error JSON.parse Failed to parse JSON data.
#9 0.857 npm error JSON.parse Note: package.json must be actual JSON, not just JavaScript.
#9 0.860 npm error A complete log of this run can be found in: /root/.npm/_logs/2025-12-24T00_26_49_515Z-debug-0.log
#9 ERROR: process "/bin/sh -c npm install" did not complete successfully: exit code: 1
------
 > [5/6] RUN npm install:
0.856 npm error code EJSONPARSE
0.857 npm error path /app/package.json
0.857 npm error JSON.parse Unexpected end of JSON input while parsing "\n"
0.857 npm error JSON.parse Failed to parse JSON data.
0.857 npm error JSON.parse Note: package.json must be actual JSON, not just JavaScript.
0.860 npm error A complete log of this run can be found in: /root/.npm/_logs/2025-12-24T00_26_49_515Z-debug-0.log
------
Error: failed to fetch an image or build from source: error building: failed to solve: process "/bin/sh -c npm install" did not complete successfully: exit code: 1
Dockerfile failed to build error
unsuccessful command 'flyctl deploy --build-only --push -a auto-vlog-ffmpeg-worker --image-label deployment-6d57fb7e0e29f4fcd107c3c288eb720c '
```

Dockerfile


```
FROM node:18-bullseye

RUN apt-get update && apt-get install -y ffmpeg

WORKDIR /app

COPY package.json ./
RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm", "start"]

```


fly.toml


```
# fly.toml app configuration file generated for auto-vlog-ffmpeg-worker on 2025-12-24T00:25:20Z
#
# See https://fly.io/docs/reference/configuration/ for information about how to use this file.
#

app = 'auto-vlog-ffmpeg-worker'
primary_region = 'iad'

[build]

[http_service]
  internal_port = 3000
  force_https = true
  auto_stop_machines = 'stop'
  auto_start_machines = true
  min_machines_running = 0
  processes = ['app']

[[vm]]
  memory = '1gb'
  cpu_kind = 'shared'
  cpus = 1
  memory_mb = 1024

```

