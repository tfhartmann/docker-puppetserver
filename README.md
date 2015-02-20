
Spin up a test master with the defaults
docker run -it -d --name puppet -h puppet 22e3f97a5825

Spin up a puppet server and mount your own /etc/puppet directory for testing

docker run -it --rm --name puppet -v /Users/alaric/git/vertica-core-puppet:/etc/puppet -h puppet 22e3f97a5825 /bin/bash

Link a test client 

docker run -it -h eng999.verticacorp.com --link puppet:puppet 22e3f97a5825 /bin/bash
