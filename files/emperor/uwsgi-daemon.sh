#!/bin/sh

### BEGIN INIT INFO
# Provides:          uwsgi-emperor
# Required-Start:    $all
# Required-Stop:     $all
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: starts the uwsgi emperor app server
# Description:       starts uwsgi app server using start-stop-daemon
### END INIT INFO

#
# Source: https://gist.github.com/petrikoz/f966f8d15856bf1114c4#file-uwsgi-daemon-sh
#

PATH=/opt/uwsgi:/sbin:/bin:/usr/sbin:/usr/bin
DAEMON=/usr/local/bin/uwsgi

NAME=uwsgi-emperor
DESC=uwsgi-emperor

# modify as needed
EMPEROR_CONFIG=/etc/uwsgi/emperor.ini

test -x $DAEMON || exit 0

# Include uwsgi defaults if available
if [ -f /etc/default/uwsgi ] ; then
        . /etc/default/uwsgi
fi

set -e

DAEMON_OPTS="--ini $EMPEROR_CONFIG"

case "$1" in
  start)
        echo -n "Starting $DESC: "
        start-stop-daemon --start --exec $DAEMON -- $DAEMON_OPTS
        echo "$NAME."
        ;;
  stop)
        echo -n "Stopping $DESC: "
        start-stop-daemon --signal 3 --quiet --retry 2 --stop \
                --exec $DAEMON
        echo "$NAME."
        ;;
  reload)
        killall -1 $DAEMON
        ;;
  force-reload)
        killall -15 $DAEMON
       ;;
  restart)
        echo -n "Restarting $DESC: "
        start-stop-daemon --signal 3 --quiet --retry 2 --stop \
                --exec $DAEMON
        sleep 1
        start-stop-daemon --start --quiet --exec $DAEMON -- $DAEMON_OPTS
        echo "$NAME."
        ;;
  status)
        killall -10 $DAEMON
        ;;
      *)
            N=/etc/init.d/$NAME
            echo "Usage: $N {start|stop|restart|reload|force-reload|status}" >&2
            exit 1
            ;;
esac
exit 0
