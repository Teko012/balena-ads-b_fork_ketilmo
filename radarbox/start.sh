#!/usr/bin/env bash
set -e

if [ -z $RADARBOX_KEY ]; then
        echo "The legacy radarbox service is deprecated, and replaced by airnav-radar. This service will now shut down. "
        echo " "
        curl --retry 10 --retry-all-errors --header "Content-Type:application/json" "$BALENA_SUPERVISOR_ADDRESS/v2/applications/$BALENA_APP_ID/stop-service?apikey=$BALENA_SUPERVISOR_API_KEY" -d '{"serviceName": "'$BALENA_SERVICE_NAME'"}';                                                                         
else
        python3 server.py 2>&1 &

        while :
        do

                echo "##############################################################"
                echo "                CONFIGURATION CHANGE REQUIRED!                "
                echo "##############################################################"
                echo "                                                              "
                echo "RadarBox feeding has moved to the new service *airnav-radar*. "
                echo "                                                              "
                echo "To continue feeding, you must update your configuration:      "
                echo "                                                              "
                echo "1. In the balena dashboard, add a new configuration variable  "
                echo "for the **airnav-radar** service:                             "
                echo "   - Name: AIRNAV_RADAR_KEY                                   "
                echo "   - Value: $RADARBOX_KEY                                     "
                echo "                                                              "   
                echo "2. Delete the legacy variable: RADARBOX_KEY.                  "
                echo "                                                              "
                echo "3. Click the *Apply all changes* button to activate.          "
                echo "                                                              "
                echo "For detailed instructions, visit the documentation page:      "
                echo "https://bit.ly/anrbmigration                                  "
                echo "                                                              "
                echo "Note: If you have modified the default docker-compose.yml,    "
                echo "you must update it accordingly.                               "
                echo "                                                              "
                echo "##############################################################"                                                                                                   
                echo "                                                              "                                                                                                                                               
                sleep 600;  
        done
  fi    
# Wait for any services to exit.
wait -n