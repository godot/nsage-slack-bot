###Slack bot logging every message to ElasticSearch [proof of concept]###
based on https://github.com/slackhq/node-slack-client

##installation##

###nodejs and coffee and npm###

[Installing-Node.js-via-package-manage](https://github.com/nodejs/node-v0.x-archive/wiki/Installing-Node.js-via-package-manager)

##install dependencies##

```
npm install
```

##setup##

```
cp .env.example .env
```

and edit

##starting bot##

```
./node_modules/coffee-script/bin/coffee app.coffee
```


## usage ##

####searching achived messages####

```
@botname: q query
```

#### jokes ####

```
@botname: joke firstname lastname
```
