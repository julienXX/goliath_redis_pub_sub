Goliath & Redis pub/sub
=======================

Goliath server that streams events emitted by a Redis publisher.

Run the server:
```
bundle exec ruby server.rb -vs
```

In an other terminal:
```
curl -N localhost:9000
```

In Redis:
```
PUBLISH 'events' "{count: 1}"
```

In curl you should see:
```
{"id":1379520280,"data":"{count: 1}"}
```
