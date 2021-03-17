#!/bin/bash
export CARLA_ROOT=/opt/carla-simulator
export PORT=2000
export ROUTES=leaderboard/data/routes_training/route_17.xml
export TEAM_AGENT=image_agent.py
export TEAM_CONFIG=/home/lelei/weights/epoch=24.ckpt
export HAS_DISPLAY=1
export PYTHONPATH=$PYTHONPATH:$CARLA_ROOT/PythonAPI/carla
export PYTHONPATH=$PYTHONPATH:$CARLA_ROOT/PythonAPI/carla/dist/carla-0.9.10-py3.7-linux-x86_64.egg
export PYTHONPATH=$PYTHONPATH:leaderboard
export PYTHONPATH=$PYTHONPATH:leaderboard/team_code
export PYTHONPATH=$PYTHONPATH:scenario_runner

if [ -d "$TEAM_CONFIG" ]; then
    CHECKPOINT_ENDPOINT="$TEAM_CONFIG/$(basename $ROUTES .xml).txt"
else
    CHECKPOINT_ENDPOINT="$(dirname $TEAM_CONFIG)/$(basename $ROUTES .xml).txt"
fi

python3 leaderboard/leaderboard/leaderboard_evaluator.py \
--track=SENSORS \
--scenarios=leaderboard/data/all_towns_traffic_scenarios_public.json  \
--agent=${TEAM_AGENT} \
--agent-config=${TEAM_CONFIG} \
--routes=${ROUTES} \
--checkpoint=${CHECKPOINT_ENDPOINT} \
--port=${PORT}

echo "Done. See $CHECKPOINT_ENDPOINT for detailed results."
