---
title: "Building a scalable URL shortener"
date: 2019-03-20T22:33:26.746Z
draft: true
---

# Table of contents

- [Table of contents](#table-of-contents)
- [System design](#system-design)
  - [Requirements](#requirements)
  - [Capacity estimation](#capacity-estimation)
  - [API](#api)
  - [Database design](#database-design)
  - [Algorithms](#algorithms)
  - [Data partitioning & replication](#data-partitioning--replication)
  - [Caching](#caching)
  - [Load balancing](#load-balancing)
  - [Cleanup & Purging](#cleanup--purging)
  - [Telemetry](#telemetry)
  - [Security](#security)
- [Implementation](#implementation)
  - [Set-up](#set-up)
  - [Continuous integration / deployment](#continuous-integration--deployment)
  - [Back-end](#back-end)
  - [Front-end](#front-end)
- [Todo](#todo)
- [References](#references)

# System design

## Requirements

We start by defining our requirements so we can have a clear picture of what we're building. We will have:

- **Functional requirements** which are the features to be implemented.
- **Non-functional requirements** which are qualitative aspects of our system. For example availability, security, low-latency, etc...
- **Extended requirements** which translate into _"nice to have"_ features.

### Functional

- **Shortening**: Should generate a unique shorter link for a given URL.
- **Resolving**: When a user accesses a link, it should resolve it to the actual URL.
- **Customization**: Users should be able to choose custom link for their URLs.
- **Expiration**: Links should be able to expire after a default duration. Users can set their custom expiry time-span.

### Non-functional

- **Availability**: The system should be highly available
- **Minimal latency**: Redirections should happen in real-time
- **Secure**: Generated links should be unpredictable

### Extended

- **Analytics**: How many redirection? From which geo-locations? IP addresses?
- **Accessibility**: Expose the service through a REST API to facilitate its integration

## Capacity estimation

The system we're creating will be _read-heavy_. This is because it will be doing a lot more redirections than new URL shortenings. For next steps, we're going to assume a **100:1 read/write ratio**.

### Traffic

Let's say our users will shorten on average **500M URLs per Month**. That means we will have **50B redirections per Month**.

Next we calculate how many [Queries per second](https://en.wikipedia.org/wiki/Queries_per_second) our system needs to perform. We find that it has **200 QPS** for writes, and **20K QPS** for reads.

### Storage

In order to estimate the storage capacity that our system needs we require two other parameters.

- **How long we will retain the data?** Let's say we'll keep URLs for 5 years. Then we will save in total around **30B** objects in our database.
- **How much storage we need per URL?** Assuming that an URL & its shortened link (with metadata) is about _500 bytes_, we end up with **15TB** in total.

### Bandwidth

To calculate the bandwidth we multiply the *Queries Per Second* and the *estimated size of our objects*.

- **Incoming**, we'll need about **100 KB/s**.
- **Outgoing**, would be **10 MB/s**.

### Memory

In order to read *frequently/recently retrieved* data we'll use caching. This will also help reduce the load on the database. Let's say we want to cache the **20% hottest URLs each day** from all of our URLs, *how much memory does our cache need?*

Since we have **1.7B** read queries per day and our estimated object size is **500 bytes**, we end up with **170 GB** in memory for our caching needs.

### Summary

| Parameter           | Value    |
| ------------------- | -------- |
| URL shortenings     | 200 QPS  |
| Redirections       | 20K QPS  |
| Storage for 5 years | 15 TB    |
| Incoming bandwidth  | 100 KB/s |
| Outgoing bandwidth  | 10 MB/s  |
| Cache memory        | 170 GB   |

## API

Since we want to expose our service to other developers through an API, we will provide them with API keys.

```yaml
# Shorten a URL
- create:
  - api_key: 'string'
  - original_url: 'string'
  - custom_name: 'string'
  - expiry_date: 'number'

# Resolve a short URL
- get:
  - short_url: 'string'

# Delete a URL
- delete:
  - api_key: 'string'
  - short_url: 'string'
```

## Database design

First, let's find out **what database(s) should we use?** We expect to store billions of records, with each one taking a small space (less than 1KB). We also don't need have complex relationships between records. This make a **NoSQL** the way to go, for example with **[Cassandra](https://cassandra.apache.org)**. As for the caching we can use **[Redis](https://redis.io)**.

Now let's design our **schemas**. We will need two tables, one for the **URL data** and the other for the **user** who created the URL.

```yaml
# URL
- primary_key:
  - hash: 'varchar(16)'
- others:
  - original_url: 'varchar(512)'
  - created_at: 'datetime'
  - expires_at: 'datetime'
  - user_id: 'int'

# User
- primary_key:
  - user_id: 'int'
- others:
  - email: 'varchar(32)'
  - username: 'varchar(20)'
  - created_at: 'datetime'
  - last_login: 'datetime'
```

## Algorithms

## Data partitioning & replication

## Caching

## Load balancing

## Cleanup & Purging

## Telemetry

## Security

- **Authentication**
- **Rate limiting**

# Implementation

## Set-up

## Continuous integration / deployment

## Back-end

## Front-end

# Todo

- Implement a System Design app

# References

- [Grokking the system design interview](https://www.educative.io/collection/5668639101419520/5649050225344512)
