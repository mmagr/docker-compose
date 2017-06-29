#!/bin/bash -e

getIp() {
  name=$(docker ps -f name=$1 --format "{{.Names}}")
  if [[ ! -z "$name" ]] ; then
      docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $name
  fi
}

getPass() {
  echo "$(< /dev/urandom tr -dc [:alnum:] | head -c8)"
}


idx="$(hostname | grep -oP '\d{2}')"
gpasswd="$(getPass)"

cat <<PAYLOAD |
{
  "username": "team_$idx", 
  "passwd":"$gpasswd", 
  "service":"hackathon", 
  "email":"team$idx@noemail.com", 
  "name":"Team $idx"
} 
PAYLOAD
curl -sS $(getIp auth):5000/user \
           -H 'content-type: application/json' \
           -d @- | python -m json.tool

echo $gpasswd | tee /tmp/team$idx.passwd
