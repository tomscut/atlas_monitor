#!/bin/bash
#export JMXTRANS_HOME=/data/opt/jmxtrans
export MONITOR_OPTS=" -Dignore_jmx "
export LOG_LEVEL=INFO
export ADDITIONAL_JARS=${JMXTRANS_HOME}/lib/presto_monitor-1.0.0-SNAPSHOT.jar
export JAR_FILE=${JMXTRANS_HOME}/lib/jmxtrans-all.jar
export JMXTRANS_OPTS="-Dlogback.configurationFile=${JMXTRANS_HOME}/conf/logback.xml"

PWD="$(cd "$(dirname "$0")"; pwd)"
export PIDFILE=${PWD}/pid
export LOG_DIR=${PWD}/logs
cd ${PWD}
mkdir -p ${PWD}/logs

run() {
    ${JMXTRANS_HOME}/jmxtrans.sh run ${PWD}/conf/presto_monitor.json
}

start() {
    ${JMXTRANS_HOME}/jmxtrans.sh start ${PWD}/conf/presto_monitor.json
}

stop() {
    ${JMXTRANS_HOME}/jmxtrans.sh stop
}

restart() {
    ${JMXTRANS_HOME}/jmxtrans.sh restart ${PWD}/conf/presto_monitor.json
}

status() {
    ${JMXTRANS_HOME}/jmxtrans.sh status
}

case $1 in
    run)
        run
    ;;
    start)
        start
    ;;
    stop)
        stop
    ;;
    restart)
        restart
    ;;
    status)
        status
    ;;
    *)
        echo $"Usage: $0 {start|stop|restart|status} [filename.json]"
    ;;
esac
