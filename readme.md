### Ansible role for Oracle ee database install

Ansible role for Oracle Database install based on https://github.com/oracle/docker-images/blob/master/OracleDatabase/dockerfiles/12.1.0.2/Dockerfile.ee

build docker image
```
docker build --shm-size 1g -t oracledb .
```

start docker image for tests
```
cd tests
ansible-playbook test_oracle_docker.yml -e "oracle_install_db=True oracle_install_db_patch=True" -v
```
