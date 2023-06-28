FROM crystallang/crystal:1.8.2-alpine

WORKDIR /travel_plan

COPY . /travel_plan/

RUN shards install 

RUN export PATJH=/usr/bin/pg_dump
RUN export PATH=/usr/bin:$PATH

CMD ["crystal", "run", "src/server.cr", "0.0.0.0:3000"]