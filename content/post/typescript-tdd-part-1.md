---
title: "TypeScript + TDD = 🔥 (part 1)"
date: 2019-03-02T19:42:55-05:00
draft: false
---

# Table of contents

- [Table of contents](#table-of-contents)
- [Setting up `git` and `npm`](#setting-up-git-and-npm)
- [Installing the necessary dependencies](#installing-the-necessary-dependencies)
  - [Core](#core)
  - [Development](#development)
  - [TypeScript `@types` packages](#typescript-types-packages)
- [NPM scripts](#npm-scripts)
- [Initialize `TypeScript`](#initialize-typescript)
  - [Add a `.prettierrc` file](#add-a-prettierrc-file)
  - [Add an `.vscode/settings.json`](#add-an-vscodesettingsjson)
  - [Add a `.huskyrc` file](#add-a-huskyrc-file)
  - [Add parameters to `tsconfig.json`](#add-parameters-to-tsconfigjson)
  - [Add `tslint-config-prettier` to `tslint.json`](#add-tslint-config-prettier-to-tslintjson)
  - [Add `nyc` to `package.json` for coverage](#add-nyc-to-packagejson-for-coverage)
- [Smoke test](#smoke-test)
  - [Create `index.ts` and `index.spec.ts`](#create-indexts-and-indexspects)
  - [Fill the files with a _smoke test_](#fill-the-files-with-a-smoke-test)
  - [Run the test](#run-the-test)
  - [Push the code](#push-the-code)

# Setting up `git` and `npm`

```bash
# Git
git init
git remote add origin git@github.com:YOUR_USERNAME/YOUR_REPOSITORY.git

# NPM
npm init

# Git
echo "# Awesome repository name" >> README.md
git add .
git commit -m "Initial commit"
git push -u origin master
```

# Installing the necessary dependencies

## Core

- `express`: Micro web framework
- `body-parser`: To parse the body of HTTP requests using multiple `content-type`
- `dotenv`: Externalize configuration in `.env` files according to __12 factor app__
- `mongoose`: Help interface with __MongoDb__

## Development

- `typescript`: Enforce types and get cleaner code with JavaScript
- `ts-node`: Transpile `TypeScript` code into `JavaScript`
- `nodemon`: Watch files and hot reload your server`
- `tslint-config-prettier`: Code formatting and tslint harmony
- `prettier-tslint`: TSlint integration with prettier
- `mocha`: Test runner
- `chai`: Testing framework
- `chai-http`: Web testing framework for `Node.js`
- `nyc`: For test coverage
- `husky`: Hooks to make sure your code is _green_ before committing

## TypeScript `@types` packages

- `@types/node`
- `@types/express`
- `@types/body-parser`
- `@types/dotenv`
- `@types/mongoose`
- `@types/chai`
- `@types/chai-http`
- `@types/mocha`

# NPM scripts

```json
{
  "pre-commit": "npm audit && npm run lint && npm test",
  "build": "npm run pre-commit && tsc",
  "start": "npm run build && node dist/index.js",
  "test": "nyc mocha --require ts-node/register --require source-map-support/register --full-trace --bail src/**/*.spec.ts",
  "coverage": "nyc report",
  "dev": "nodemon --watch 'src/**/*' -e ts --exec npm run server --silent",
  "server": "npm run lint --silent && ts-node ./src/index.ts",
  "postinstall": "npm run build",
  "lint": "tslint -c tslint.json -p tsconfig.json",
  "clean": "rm -rf ./dist ./coverage ./.nyc_output
}
```

# Initialize `TypeScript`

```bash
tsc --init
tslint --init
```

## Add a `.prettierrc` file

```json
{
  "printWidth": 100,
  "singleQuote": true
}
```

## Add an `.vscode/settings.json`

```json
{
  "prettier.tslintIntegration": true,
}
```

## Add a `.huskyrc` file

```json
{
  "hooks": {
    "pre-commit": "npm run pre-commit"
  }
}
```

## Add parameters to `tsconfig.json`

```json
{
  "compilerOptions": {
    "target": "es6",
    "module": "commonjs",
    "lib": ["es2016", "dom"],
    "outDir": "./dist",
    "rootDir": "./src",
    "removeComments": true,
    "strict": true,
    "esModuleInterop": true,
    "inlineSourceMap": true
  },
  "include": ["src"]
}
```

## Add `tslint-config-prettier` to `tslint.json`

```json
{
  "defaultSeverity": "error",
  "extends": ["tslint:recommended", "tslint-config-prettier"],
  "jsRules": {},
  "rules": {},
  "rulesDirectory": []
}
```

## Add `nyc` to `package.json` for coverage

```bash
npm i --save-dev nyc
```

```json
{
  "extension": [
    ".ts"
  ],
  "include": [
    "src/**/*.ts"
  ],
  "exclude": [
    "src/**/*.spec.ts"
  ],
  "reporter": [
    "text",
    "html"
  ],
  "require": [
    "ts-node/register",
    "source-map-support/register"
  ],
  "all": true,
  "cache": false,
  "check-coverage": true,
  "statements": 90,
  "functions": 90,
  "branches": 90,
  "lines": 90
}
```

# Smoke test

## Create `index.ts` and `index.spec.ts`

```bash
mkdir src
touch src/index.ts
touch src/index.spec.ts
```

## Fill the files with a _smoke test_

```typescript
// File: src/index.ts
export const addNumber = (...args) =>
    args.reduce((acc, curr) => curr += acc, 0);

// File: src/index.spec.ts
import chai from 'chai';
import 'mocha';
import { addNumbers } from './index';

describe('Smoke test', () => {
  it('should return the correct sum', () => {
    const actualSum = addNumbers(1, 2, 3, 4);
    chai.expect(actualSum).to.equal(10);
  });
});
```

## Run the test

```bash
npm test

# Output
> nyc mocha -r ts-node/register src/**/*.spec.ts

  Smoke test
    ✓ should return the correct sum
    ✓ should fail if sum is incorrect

  2 passing (4ms)

----------|----------|----------|----------|----------|-------------------|
| File       | % Stmts    | % Branch   | % Funcs    | % Lines    | Uncovered Line #s   |
| ---------- | ---------- | ---------- | ---------- | ---------- | ------------------- |
| All files  | 100        | 100        | 100        | 100        |                     |
| index.ts   | 100        | 100        | 100        | 100        |                     |
| ---------- | ---------- | ---------- | ---------- | ---------- | ------------------- |
```

## Push the code

```bash
git add .
git commit -m "Smoke test"
git push
```
