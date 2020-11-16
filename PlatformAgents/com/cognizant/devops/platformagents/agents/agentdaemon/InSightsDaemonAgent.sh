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
#! /bin/sh
# /etc/init.d/InSightsDaemonAgent

### BEGIN INIT INFO
# Provides: Runs a Python script on startup
# Required-Start: BootPython start
# Required-Stop: BootPython stop
# Default-Start: 2 3 4 5
# Default-stop: 0 1 6
# Short-Description: Simple script to run python program at boot
# Description: Runs a python program at boot
### END INIT INFO
#export INSIGHTS_AGENT_HOME=/home/ec2-user/insightsagents
source /etc/profile

case "$1" in
  start)
    if [[ $(ps aux | grep '[a]gentdaemon.AgentDaemonExecutor' | awk '{print $2}') ]]; then
     echo "InSightsDaemonAgent already running"
    else
     echo "Starting InSightsDaemonAgent"
     cd $INSIGHTS_AGENT_HOME/AgentDaemon
     python -c "from com.cognizant.devops.platformagents.agents.agentdaemon.AgentDaemonExecutor import AgentDaemonExecutor; AgentDaemonExecutor()" &
    fi
    if [[ $(ps aux | grep '[a]gentdaemon.AgentDaemonExecutor' | awk '{print $2}') ]]; then
     echo "InSightsDaemonAgent Started Sucessfully"
    else
     echo "InSightsDaemonAgent Failed to Start"
    fi
    ;;
  stop)
    echo "Stopping InSightsDaemonAgent"
    if [[ $(ps aux | grep '[a]gentdaemon.AgentDaemonExecutor' | awk '{print $2}') ]]; then
     sudo kill -9 $(ps aux | grep '[a]gentdaemon.AgentDaemonExecutor' | awk '{print $2}')
    else
     echo "InSightsDaemonAgent already in stopped state"
    fi
    if [[ $(ps aux | grep '[a]gentdaemon.AgentDaemonExecutor' | awk '{print $2}') ]]; then
     echo "InSightsDaemonAgent Failed to Stop"
    else
     echo "InSightsDaemonAgent Stopped"
    fi
    ;;
  restart)
    echo "Restarting InSightsDaemonAgent"
    if [[ $(ps aux | grep '[a]gentdaemon.AgentDaemonExecutor' | awk '{print $2}') ]]; then
     echo "InSightsDaemonAgent stopping"
     sudo kill -9 $(ps aux | grep '[a]gentdaemon.AgentDaemonExecutor' | awk '{print $2}')
     echo "InSightsDaemonAgent stopped"
     echo "InSightsDaemonAgent starting"
     cd $INSIGHTS_AGENT_HOME/AgentDaemon
     python -c "from com.cognizant.devops.platformagents.agents.agentdaemon.AgentDaemonExecutor import AgentDaemonExecutor; AgentDaemonExecutor()" &
     echo "InSightsDaemonAgent started"
    else
     echo "InSightsDaemonAgent already in stopped state"
     echo "InSightsDaemonAgent starting"
     cd $INSIGHTS_AGENT_HOME/AgentDaemon
     python -c "from com.cognizant.devops.platformagents.agents.agentdaemon.AgentDaemonExecutor import AgentDaemonExecutor; AgentDaemonExecutor()" &
     echo "InSightsDaemonAgent started"
    fi
    ;;
  status)
    echo "Checking the Status of InSightsDaemonAgent"
    if [[ $(ps aux | grep '[a]gentdaemon.AgentDaemonExecutor' | awk '{print $2}') ]]; then
     echo "InSightsDaemonAgent is running"
    else
     echo "InSightsDaemonAgent is stopped"
    fi
    ;;
  *)
    echo "Usage: /etc/init.d/InSightsDaemonAgent {start|stop|restart|status}"
    exit 1
    ;;
esac
exit 0
