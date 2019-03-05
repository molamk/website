---
title: "TypeScript + TDD = 🔥 (part 2)"
date: 2019-03-03T02:43:32-05:00
draft: false
---

# Table of contents

- [Table of contents](#table-of-contents)
- [Add a health-check endpoint](#add-a-health-check-endpoint)
  - [Add an `.env` file](#add-an-env-file)
  - [Create a test for the endpoint](#create-a-test-for-the-endpoint)
  - [Create the actual endpoint](#create-the-actual-endpoint)
  - [Run the test](#run-the-test)
- [Package the app in a `Docker` container](#package-the-app-in-a-docker-container)
  - [Add a `.dockerignore` file](#add-a-dockerignore-file)
  - [Add a `Dockerfile`](#add-a-dockerfile)
  - [Add some `npm` utility scripts for `Docker`](#add-some-npm-utility-scripts-for-docker)
  - [Run a smoke test](#run-a-smoke-test)
- [Push the image to _Dockerhub_](#push-the-image-to-dockerhub)
  - [Create a _repository_](#create-a-repository)
  - [Create a `scripts/docker-tag.sh`](#create-a-scriptsdocker-tagsh)
  - [Write the _tag_ and _push_ script](#write-the-tag-and-push-script)
  - [Push the image](#push-the-image)
  - [If you're low on bandwidth](#if-youre-low-on-bandwidth)
  - [Smoke test](#smoke-test)

# Add a health-check endpoint

## Add an `.env` file

```bash
echo "PORT=3000" >> .env
```

## Create a test for the endpoint

```typescript
import chai, { expect } from 'chai';
import chaiHttp from 'chai-http';
import 'mocha';
import { server } from './index';

chai.use(chaiHttp);

describe('GET /health-check', () => {
  it('should return a staus code of 200', done => {
    chai
      .request(server)
      .get('/health-check')
      .then(res => {
        expect(res.status).to.eq(200);
        done();
      })
      .catch(done);
  });

  after(() => {
    server.close();
  });
});
```

## Create the actual endpoint

```typescript
import dotenv from 'dotenv';
import express from 'express';

export const config = dotenv.config();
const app = express();
const port = process.env.PORT;

app.get('/health-check', (_, res) => res.sendStatus(200));

export const server = app.listen(port, () => {
  // tslint:disable-next-line: no-console
  console.log(`Express app listening on port ${port}`);
});
```

## Run the test

```bash
npm test

# Output
GET /health-check
    ✓ should set up the app correctly
    ✓ should return a staus code of 200

  2 passing (16ms)

----------|----------|----------|----------|----------|-------------------|
File      |  % Stmts | % Branch |  % Funcs |  % Lines | Uncovered Line #s |
----------|----------|----------|----------|----------|-------------------|
All files |      100 |      100 |      100 |      100 |                   |
 index.ts |      100 |      100 |      100 |      100 |                   |
----------|----------|----------|----------|----------|-------------------|
```

# Package the app in a `Docker` container

## Add a `.dockerignore` file

```dockerignore
.vscode
.nyc_output
coverage
.env
node_modules
dist
```

## Add a `Dockerfile`

```docker
FROM node:alpine

WORKDIR /app
COPY package.json /app
COPY package-lock.json /app
RUN npm install
COPY . /app

CMD [ "npm", "start" ]
```

## Add some `npm` utility scripts for `Docker`

```json
{
  "docker:build": "docker build -t molamk/crud-tdd:latest .",
  "docker:run": "docker run --network host --env PORT=3000 --expose 3000 --name crud-tdd-container molamk/crud-tdd:latest",
  "docker:remove-container": "docker rm crud-tdd-container",
  "docker:remove-image": "docker rmi molamk/crud-tdd:latest"
}
```

## Run a smoke test

```bash
curl localhost:3000/health-check

# Output
OK
```

# Push the image to _Dockerhub_

## Create a _repository_

- Go to [Dockerhub](hub.docker.com)
- Create an account or log in
- Create a _new repository_ named `crud-tdd`

## Create a `scripts/docker-tag.sh`

```bash
# Command line
mkdir scripts && cd scripts
touch docker-tag.sh
chmod +x docker-tag.sh && cd ..
```

## Write the _tag_ and _push_ script

```bash
#!/bin/bash

username=molamk
local_image=crud-tdd-image
tag=latest
repository_name=crud-tdd
remote_image="$username"/"$repository_name":"$tag"

docker tag "$local_image":"$tag" "$remote_image"
docker push "$remote_image"
```

## Push the image

```bash
# Tag and push
docker login
./scripts/docker-push.sh
```

## If you're low on bandwidth

Limit the number of _concurrent uploads_ in the  [`dockerd` configuration file](https://docs.docker.com/engine/reference/commandline/dockerd/)

```bash
sudo echo '{ "max-concurrent-uploads": 1 }' >> /etc/docker/daemon.json
```

## Smoke test

```bash
npm run docker:pull
npm run docker:run-from-remote

curl localhost:3000/health-check

# Output
OK
```