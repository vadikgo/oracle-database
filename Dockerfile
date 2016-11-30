# Dockerfile for building oracle conatiner
#

# pull base image
FROM oraclelinux:7

COPY . /tmp/oracle-database
RUN set -x \
    && yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y \
    && yum install ansible -y \
    && yum install https://github.com/krallin/tini/releases/download/v0.13.0/tini_0.13.0-amd64.rpm -y \
    && cd /tmp/oracle-database/tests \
    && ansible-playbook test_oracle_install.yml -e "oracle_install_db=True oracle_install_db_patch=True"

ENTRYPOINT ["/usr/bin/tini", "--", "su - oracle -c /opt/oracle/runOracle.sh"]
EXPOSE 1521 1158
