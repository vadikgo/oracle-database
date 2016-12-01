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

ENV ORACLE_BASE /opt/oracle
ENV ORACLE_HOME $ORACLE_BASE/product/12.1.0/dbhome_1
ENV ORACLE_SID ORCLCDB
ENV ORACLE_PDB ORCLPDB1
ENV PATH $ORACLE_HOME/bin:$ORACLE_HOME/OPatch/:/usr/sbin:$PATH
ENV LD_LIBRARY_PATH $ORACLE_HOME/lib:/usr/lib
ENV CLASSPATH $ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib
USER oracle
ENTRYPOINT ["/usr/bin/tini", "--", "/opt/oracle/runOracle.sh"]
EXPOSE 1521 1158
