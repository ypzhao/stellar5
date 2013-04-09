stellar5
========

An IDE totally based on HTML5 technologies integrating online and offline development experience


Prerequisites
------------
Before you install the stellar5, you'll need to make sure your machine complies with the following prerquisites:
1. The node version should be >= 0.7.12 and I strongly recommend that you use [nvm](https://github.com/creationix/nvm) to install the node.
2. You should install the 'now','http-proxy','connect' before you run the install.sh at the stellar5 directory like following:

    npm install now http-proxy connect


Installation
------------
Linux:
* ./install.sh

other OS:
Please see install.sh for the steps


Troubleshooting
---------------
If you encounter a problem when running install.sh, you can try to fix it as follows:


    cd stellar5/third_party/web-simulator


and change the first line of the configure file as : sudo npm install -g jake jshint csslint uglify-js


Running
-------
* native mode:
  ** Download node-webkit from 
  ** nw /path/to/stellar5

* cloud mode:
  ./start_server.sh

