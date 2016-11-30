### ansible role for oracle ee database install

build docker image
```
docker build --shm-size 1g -t oracledb .
```

start docker image for tests
```
cd tests
ansible-playbook test_oracle_docker.yml -e "oracle_install_db=True oracle_install_db_patch=True" -v
```
