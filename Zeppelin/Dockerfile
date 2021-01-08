FROM apache/zeppelin:0.9.0

ENV RUN_FILE="init.sh" \
    INSTALL_DIR=/opt/install

COPY ojdbc8.jar /zeppelin/interpreter/jdbc/
COPY interpreter.json /zeppelin/conf/
COPY $RUN_FILE $INSTALL_DIR/

USER root

RUN chmod ug+x $INSTALL_DIR/*.sh

CMD exec $INSTALL_DIR/$RUN_FILE
