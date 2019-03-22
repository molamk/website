---
title: "WIP - Hackernews Clone With Graphql and Prisma)"
date: 2019-03-05T06:44:15-05:00
draft: true
---

# Table of contents

- [Table of contents](#table-of-contents)
- [Set-up the project](#set-up-the-project)
  - [Create the project directory](#create-the-project-directory)
  - [Set-up `npm`](#set-up-npm)
  - [Create a `src/index.js` file](#create-a-srcindexjs-file)
  - [Run the server](#run-the-server)

# Set-up the project

## Create the project directory

```bash
mkdir hackernews-clone
cd hackernews-clone
git init
npm init -y
echo "node_modules" >> .gitignore
```

## Set-up `npm`

```bash
npm i --save graphql graphql-yoga
```

```json
{
    "scripts": {
        "start": "node src/index.js"
    }
}
```

## Create a `src/index.js` file

```bash
mkdir src
touch src/index.js
```

```js
// File: src/index.js
const { GraphQLServer } = require('graphql-yoga')

// 1
const typeDefs = `
type Query {
  info: String!
}
`

// 2
const resolvers = {
  Query: {
    info: () => `This is the API of a Hackernews Clone`
  }
}

// 3
const server = new GraphQLServer({
  typeDefs,
  resolvers,
})
server.start(() => console.log(`Server is running on http://localhost:4000`))
```

## Run the server

```bash
npm start

# TODO: Inclde a screenshot of `localhost:4000
```