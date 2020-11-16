#-------------------------------------------------------------------------------
# Copyright 2017 Cognizant Technology Solutions
#   
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License.  You may obtain a copy
# of the License at
# 
#   http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
# License for the specific language governing permissions and limitations under
# the License.
#-------------------------------------------------------------------------------

#!/bin/sh
# /etc/init.d/Grafana

### BEGIN INIT INFO
# Provides: Runs a Grafana script on startup
# Required-Start: Grafana start
# Required-Stop: Grafana stop
# Default-Start: 2 3 4 5
# Default-stop: 0 1 6
# Short-Description: Simple script to run Grafana program at boot
# Description: Runs a Grafana program at boot
### END INIT INFO

[[ -z "${GRAFANA_HOME}" ]] && GRAFANA_HOME_VAR=sudo env | grep GRAFANA_HOME | cut -d'=' -f2 || GRAFANA_HOME_VAR="${GRAFANA_HOME}"
GRAFANA_HOME_VAR=$GRAFANA_HOME_VAR/grafana/bin
echo $GRAFANA_HOME_VAR
case "$1" in
  start)
    if [[ $(ps aux | grep '[g]rafana-server' | awk '{print $2}') ]]; then
     echo "Grafana already running"
    else
     echo "Starting Grafana"
     cd $GRAFANA_HOME_VAR
     sudo nohup ./grafana-server &
     echo $! > grafana-pid.txt
    fi
    if [[ $(ps aux | grep '[g]rafana-server' | awk '{print $2}') ]]; then
     echo "Grafana Started Successfully"
    else
     echo "Grafana Failed to Start"
    fi
    ;;
  stop)
    echo "Stopping Grafana"
    if [[ $(ps aux | grep '[g]rafana-server' | awk '{print $2}') ]]; then
     sudo kill -9 $(ps aux | grep '[g]rafana-server' | awk '{print $2}')
    else
     echo "Grafana already in stopped state"
    fi
    if [[ $(ps aux | grep '[g]rafana-server' | awk '{print $2}') ]]; then
     echo "Grafana Failed to Stop"
    else
     echo "Grafana Stopped"
    fi
    ;;
  restart)
    echo "Restarting Grafana"
    if [[ $(ps aux | grep '[g]rafana-server' | awk '{print $2}') ]]; then
     echo "Grafana stopping"
     sudo kill -9 $(ps aux | grep '[g]rafana-server' | awk '{print $2}')
     echo "Grafana stopped"
     echo "Grafana starting"
     cd $GRAFANA_HOME_VAR
     sudo nohup ./grafana-server &
     echo $! > grafana-pid.txt
     echo "Grafana started"
    else
     echo "Grafana already in stopped state"
     echo "Grafana starting"
     cd $GRAFANA_HOME_VAR
     sudo nohup ./grafana-server &
     echo $! > grafana-pid.txt
     echo "Grafana started"
    fi
    ;;
  status)
    echo "Checking the Status of Grafana"
    if [[ $(ps aux | grep '[g]rafana-server' | awk '{print $2}') ]]; then
     echo "Grafana is running"
    else
     echo "Grafana is stopped"
    fi
    ;;
  *)
    echo "Usage: /etc/init.d/Grafana {start|stop|restart|status}"
    exit 1
    ;;
esac
exit 0
