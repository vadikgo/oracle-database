# Dockerfile for building oracle conatiner
#

# pull base image
FROM oraclelinux:7

COPY . /tmp/oracle-database
RUN set -x \
    && curl -k https://sbt-opir-253.sigma.sbrf.ru/opir/opir-stuff/raw/master/ansible/ansible-install.sh | sh \
    && cd /tmp/oracle-database/tests \
    && ansible-playbook test_oracle_install.yml -e "oracle_install_db=True oracle_install_db_patch=True"

#ENTRYPOINT ["/usr/bin/tini", "--", "/start_oracle.sh"]
EXPOSE 1521 1158
