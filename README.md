# Puppet Server

This Image attempts to create a useable Puppet Master running the Puppetlabs
PuppetServer (https://github.com/puppetlabs/puppet-server) Master.

##  environment variables 
### JAVA_ARGS
You can update the JAVA_ARGS Setting by passing the PUPPETSERVER_JAVA_ARGS environment
variable. 


The default set in the Dockerfile is 512m
PUPPETSERVER_JAVA_ARGS="-Xms512m -Xmx512m"

To set JAVA_ARGS back to the PuppetLabs default use:

```Shell
docker run -it -d -e PUPPETSERVER_JAVA_ARGS="-Xms2g -Xmx2g -XX:MaxPermSize=256m" --name puppet -h puppet tfhartmann/puppetserver
```


## Examples

Run a puppet master useing the image defaults. This will run a local Puppet Server, exposing port 8140.
The master will autosign certs.

```Shell
docker run -it -d --name puppet -h puppet tfhartmann/puppetserver
```


Run a puppet server and mount your own /etc/puppet directory for testing. Keeping in mind this will
overwrite any config file in /etc/puppet with (puppet.conf, auth.conf, and fileserver.conf etc) with
whatever you have in your local directory.

```Shell
docker run -d --name puppet -v /home/user/puppet:/etc/puppet -h puppet tfhartmann/puppetserver
```

Run Puppet Server interactivly, mounting your local puppet repo over /etc/puppet 
In this case you'll also need to run "puppetserver foreground" to run the server

```Shell
docker run -it --rm --name puppet -v /home/user/puppet:/etc/puppet -h puppet tfhartmann/puppetserver /bin/bash
```

Run a Puppet Server and test agent

Start the Puppet Server:
```Shell
docker run -it -d --name puppet -h puppet tfhartmann/puppetserver

Start the agent and run a puppet run (twice) 
```Shell
docker run -it --link puppet:puppet tfhartmann/puppetserver /bin/bash
[root@1de898077e80 /]# puppet agent --test && puppet agent --test
Info: Creating a new SSL key for 1de898077e80.example.com
Info: Caching certificate for ca
Info: csr_attributes file loading from /etc/puppet/csr_attributes.yaml
Info: Creating a new SSL certificate request for 1de898077e80.example.com
Info: Certificate Request fingerprint (SHA256): BF:8D:90:1E:FB:9C:B4:4F:CA:56:49:FD:5A:6C:9F:04:30:9C:BF:D9:60:EB:E0:2F:61:DF:54:37:E6:19:63:3C
Info: Caching certificate for 1de898077e80.example.com
Info: Caching certificate_revocation_list for ca
Info: Caching certificate for ca
Info: Retrieving pluginfacts
Info: Retrieving plugin
Info: Caching catalog for 1de898077e80.example.com
Info: Applying configuration version '1424445523'
Info: Creating state file /var/lib/puppet/state/state.yaml
Notice: Finished catalog run in 0.01 seconds
Info: Retrieving pluginfacts
Info: Retrieving plugin
Info: Caching catalog for 1de898077e80.example.com
Info: Applying configuration version '1424445495'
Notice: Finished catalog run in 0.01 seconds
[root@1de898077e80 /]#
```
