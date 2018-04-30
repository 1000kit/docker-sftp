# docker-sftp
Docker image to provide sftp functionality - based  on 1000kit/base.

This image is based on
* https://github.com/atmoz/sftp
* https://github.com/Akegata/sftp-centos

## build

use simply the build.sh
~~~
  $ ./build.sh
~~~

## Sample

start docker:
~~~
  $ docker run -it -p 2222:22 -e SFTP_USERS=tkitftp:passwd1234:1001 1000kit/sftp /bin/bash
~~~

try to connect with:
~~~
  $ sftp -P 2222 tkitftp@localhost
  $ sftp -o PubkeyAuthentication=no -P 2222 tkitftp@localhost
~~~


## docker-compose
download docker-compose.yml file and adapt to your needs

~~~
  $ docker-compose up
~~~
