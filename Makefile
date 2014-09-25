


NAME=aooj/hbase
VERSION=1.0


build:
	docker build -t $(NAME):$(VERSION) .


run:
	docker run --name hbase -p 127.0.0.1:2181:2181 -p 127.0.0.1:60000:60000 -p 127.0.0.1:60010:60010 -p 127.0.0.1:60020:60020 -p 127.0.0.1:60030:60030 -d $(NAME):$(VERSION)

shell:
	docker run -ti --link hbase:hbase --rm $(NAME):$(VERSION) /bin/bash

debug: build
	docker run -ti --rm $(NAME):$(VERSION) /bin/bash	
