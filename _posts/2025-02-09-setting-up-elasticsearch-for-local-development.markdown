---
layout: post
title:  "Setting up Elasticsearch for Local Development"
date:   2025-02-09 12:26:39 -0700
categories: elasticsearch
---

Elasticsearch is a distributed, RESTful search and analytics engine built on Apache Lucene. It efficiently indexes and searches
large volumes of structured and unstructured data in near real-time. It supports full-text search, filtering, aggregations,
and geo-search. Commonly used in log analytics, observability, and search applications, it scales horizontally and integrates
well with the ELK stack (Elasticsearch, Logstash, Kibana).

I like elasticsearch because it's open source, so if you want managed hosting, you could get it from elastic.co, or if you want
to host it yourself, you can set it up in your own infrastructure.

In this post, I will cover how to set up Elasticsearch for local development, because having it running locally gives you a very
flexible development environment to work with, you dont have to worry about security or cost of hosting a temporary instance
on cloud, and also you don't to rely on fast internet connection for local development if you already have downloaded elasticsearch
docker images.

The best source to setup elasticsearch with docker is ofcourse elasticsearch's own documentation:

- [Run Elasticsearch Docker](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#run-elasticsearch-docker)
-[Run Kibana Docker](https://www.elastic.co/guide/en/kibana/current/docker.html)

However, I found myself steering away from the official documentation, because I didn't want to setup complicated security setup for local development, and also I wanted to use a single node elasticsearch cluster for local development.

So, here I am going to share how I setup elasticsearch for local development, which is quick and easy, but this is not suitable for production deployment.

I have used docker compose to start elasticsearch and kibana, so it's nice and easy to start and tear down.

Here is a simple docker compose file `docker-compose.yml` that you can use to start elasticsearch and kibana locally.

```yaml
services:
  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:8.17.1
    ports:
      - 9200:9200
    environment:
      - discovery.type=single-node
      - ELASTIC_PASSWORD=elastic
      - xpack.security.enabled=false
    volumes:
      - ./esdata:/usr/share/elasticsearch/data

  kibana:
    image: docker.elastic.co/kibana/kibana:8.17.1
    ports:
      - 5601:5601
    volumes:
      - ./kibana.yml:/usr/share/kibana/config/kibana.yml
    depends_on:
      - elasticsearch
```

and here is the associated `kibana.yml` file:

```yaml
server.host: "0.0.0.0"
server.shutdownTimeout: "5s"
elasticsearch.hosts: [ "http://elasticsearch:9200" ]
elasticsearch.username: "kibana_user"
elasticsearch.password: "kibana_password"
```

Now, let's start with elasticsearch first.

```bash
# -d is for detached mode, so it will run in the background.
docker compose up elasticsearch -d
```

Next we neet to create a user for kibana on elasticsearch.

```bash
# create a user for kibana
docker compose exec elasticsearch /usr/share/elasticsearch/bin/elasticsearch-users useradd kibana_user -p "kibana_password" -r kibana_system
```

And, then start kibana.
```bash
# start kibana
docker compose up kibana -d
```

That's it, you have elasticsearch and kibana running on your local machine.

**Endpoints:**<br>
- Elasticsearch: [http://localhost:9200](http://localhost:9200)
- Kibana: [http://localhost:5601](http://localhost:5601)

Now, when you are done, you can tear down the containers by running `docker compose down`.

### Troubleshooting

1. Verify that elasticsearch is running.

```bash
curl -u elastic:elastic http://localhost:9200
```

If you see a error response, look into docker logs for elasticsearch.

2. Verify that kibana is running.

Navigate to [http://localhost:5601](http://localhost:5601), and you should see the kibana web interface.

If the kibana interface is not loading, then it's likely that it's not able to connect to elasticsearch.

check docker logs for kibana.
