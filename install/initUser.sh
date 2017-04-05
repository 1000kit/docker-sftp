#!/bin/bash



## USER:PASSWORD:UID/GID:ENCRYPTED:DIRS (,separated)
#echo "init User: $SFTP_USERS"
# Add users
IFS=',' read -a users <<< "$SFTP_USERS"
for userData in "${users[@]}"; do
    IFS=':' read -a data <<< "$userData"
    
    user="${data[0]}"
    pass="${data[1]}"

    if [ ! -z "${data[2]}" ]; then
      uid="${data[2]}"
    fi   
    if [ "${data[3]}" == "e" ]; then
      encrypted=yes
    fi
    if [ ! -z "${data[4]}" ]; then 
      createDirs=${data[4]}
    fi
    if ! [ $uid ]; then
        uid=$(shuf -i 1500-2000 -n 1)
    fi
   
    #echo "Add User $uid $user"
    useradd -u $uid $user -d /home/${user}

    #echo "change passwd: $user:$pass"
    if [ "$encrypted" == "yes" ]; then
      echo "$user:$pass" | chpasswd -e
    else
      echo "$user:$pass" | chpasswd
    fi

    if [ ! -z "${createDirs}" ]; then
       IFS=";"
       for dd in ${createDirs}; do
           echo "--> mkdir -p /home/${user}/${dd}"
           mkdir -p /home/${user}/${dd}
       done
    fi
    
    chown -R ${user}:${user} /home/${user}
    chmod 755 /home/${user}
done

exec "$@"

#end
