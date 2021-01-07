FROM apache/zeppelin:0.9.0

ENV RUN_FILE="init.sh" \
    INSTALL_DIR=/opt/install

RUN mkdir $INSTALL_DIR

COPY ojdbc8.jar /zeppelin/interpreter/jdbc/
COPY interpreter_osql.json /zeppelin/conf/
COPY $RUN_FILE $INSTALL_DIR\

CMD exec $INSTALL_DIR/$RUN_FILE
