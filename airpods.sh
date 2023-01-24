#!/bin/bash
#
# needs AirStatus installed and running
#
# displays airpod info
# get airpod device info
# get last line of output from /tmp/airstatus.out
function get_airpod_info {
    airstatus=$(tail -n 1 /tmp/airstatus.out)
    case=$(echo $airstatus | jq -r '.charge | .case')
    left=$(echo $airstatus | jq -r '.charge | .left')
    right=$(echo $airstatus | jq -r '.charge | .right')
    ch_case=$(echo $airstatus | jq -r '.charging_case')
    ch_left=$(echo $airstatus | jq -r '.charging_left')
    ch_right=$(echo $airstatus | jq -r '.charging_right')
    model=$(echo $airstatus | jq -r '.model')
    date=$(echo $airstatus | jq -r '.date')
    echo $left $right $case $ch_left $ch_right $ch_case $model $date
}

# if value is -1 then return "   "
function fix_value {
    value=$1
    # if value is -1
    if [ $value -eq -1 ]; then
        value="   "
        echo $value
    # if value is gretaer equal than 1 and smaller equal to 100
    elif [ $value -ge 1 ] && [ $value -le 100 ]; then
        value=$(echo $value | awk '{printf "%3d", $1}')
        echo $value
    fi
}

function get_state {
    #if value is "true" than return 1
    #if value is "false" than return 0
    value=$1
    if [ "$value" = "true" ]; then
        echo 1
    elif [ "$value" = "false" ]; then
        echo 0
    fi
}

function display_airpods {
    # has parameter for left, right, case
    # has parameter for charging_left_charging_right, charging_case
    # has parameter for model
    # has parameter for date
    data=$(get_airpod_info)
    left=$(fix_value $(echo $data | awk '{print $1}'))
    right=$(fix_value $(echo $data | awk '{print $2}'))
    case=$(fix_value $(echo $data | awk '{print $3}'))
    ch_left=$(echo $data | awk '{print $4}')
    ch_right=$(echo $data | awk '{print $5}')
    ch_case=$(echo $data | awk '{print $6}')
    model=$(echo $data | awk '{print $7}')
    date=$(echo $data | awk '{print $8}')
    
    # if get_state is 1 than return ⚡️
    # if get_state is 0 than return " "
    if [ $(get_state $ch_left) -eq 1 ]; then
        ch_left="⚡️"
    elif [ $(get_state $ch_left) -eq 0 ]; then
        ch_left="  "
    fi

    if [ $(get_state $ch_right) -eq 1 ]; then
        ch_right="⚡️"
    elif [ $(get_state $ch_right) -eq 0 ]; then
        ch_right="  "
    fi

    if [ $(get_state $ch_case) -eq 1 ]; then
        ch_case="⚡️"
    elif [ $(get_state $ch_case) -eq 0 ]; then
        ch_case="  "
    fi

    #echo $(get_airpod_info)
    
    # if model is AirPodsPro2
    if [ "$model" = "AirPodsPro2" ]; then
        echo ""
        echo ""
        echo "ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC4nYF5eXl5eXl5eXl5eXl5eXl5eXmAnLiAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC5eIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiJeYCAgCiAgICcuICcnICAgICAgICAgIC5gICAnICAgICAgICAuIl5eLCwsLCwsLCwsLCwsLCwsLCwsLCwsImBeXiAKICAnYCh4ISIsYCAgICAgIGAsOjpceCInLiAgICAgIGAsXiI6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6ImAiYAogLl5gPi9fOiwiYGAuIF5gIiI6IXQtYGAuICAgICAgYCJeLDo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6OjosXixgCiAgJywsImk7LCw+fSwuWy0sLCwhLF4iYCAgICAgICBgIl4sOjo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6OixeLGAKICAgIF5pPDohPmk6ICBeaT5pOzxpXiAgICAgICAgIGAiXiw6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Il4sYAogICAgJzpJICAgICAgICAgICAgbDouICAgICAgICAgYCxeLDo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6OjosXixgCiAgICBgO0kuICAgICAgICAgIC5JSScgICAgICAgICAuOjo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Ojo6Oi4KICAgIGBpSS4gICAgICAgICAgLmxpYCAgICAgICAgICAnO2whIWxsbGxsbGxsbGxsbGxsbGxsbCEhbDsnIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYDpJIWlpaWlpaWlpaWlpaWlpaWkhSTpgICAgCg==" \
            | base64 --decode
        echo ""
        echo "  $ch_left $left %      $ch_right $right %                  $ch_case $case %"
        echo ""
    # if model is Airpods1
    elif [ "$model" = "AirPods1" ]; then
        echo ""
        echo ""
        echo "ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAuLicnJycnJycnJycnJycnJy4gICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYGAnJycnJycnJycnJycnYGBgYGAuICAgCiAgIC4gLicuLCcgICAgICxpLicuICAgICAgICAgICAgICAgIF5eLidgYGBgYGBgYGBgYGBgYGAgJyIuICAKICA6J0k6JydeXi4gICAnIiwuYF5sYCAgICAgICAgICAgICAgImAuYGBgYGBgYGBgYGBgYGBgXi4nIicgIAogIDo6aWwsSSwnYC4gIGAuJzo6O2ksLiAgICAgICAgICAgICAiYC5gYGBgYGBgYGBgYGBgYF5eLiciJyAgCiAgIF4sO0lJLF5gJyAuXmBebEk6YC4gICAgICAgICAgICAgICJgLmBgYGBgYGBgYF5eXl5eXl4uJyInICAKICAgICAgICAuXl5gIC5eXicgICAgICAgICAgICAgICAgICAgImAuYGBgYGBgYGBgXl5eXl5eXi4nIicgIAogICAgICAgIC5eXmAgLiJeJyAgICAgICAgICAgICAgICAgICAiYC5gYGBgYGBgYF5eXl5eXl5eLiciJyAgCiAgICAgICAgLl5eYCAuIl4nICAgICAgICAgICAgICAgICAgICJgLl5gYGBgYGBeXl5eXl5eXl4uJyInICAKICAgICAgICAuXl5gIC5eYCcgICAgICAgICAgICAgICAgICAgIl4uXmBgYGBgXl5eXl5eXl5eXi4nIicgIAogICAgICAgIC4iLF4gLiwsYCAgICAgICAgICAgICAgICAgICAiXi5gYGBgYGBgYGBgYGBgXl5eLiciLiAgCiAgICAgICAgJywhOiAuSTw6ICAgICAgICAgICAgICAgICAgIGAsYF5eXl5eXl5eXl5eXl5eXl5gIiIgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGA6Ozs7Ozs7Ozs7Ozs7Ozs7OjpeICAgIAo=" \
            | base64 --decode
        echo ""
        echo "   $ch_left $left %  $ch_right $right %                      $ch_case $case %"
        echo ""
    fi
}

function is_connected {
    # get bluetooth device name and check if it is AirPods......
    bluetooth=$(bluetoothctl info | grep Name | grep -oP '(?<=Name: ).*' | grep -oP '(^AirPods)')
    #echo $bluetooth
    if [ "$bluetooth" = "AirPods" ]; then
        return 1
    else
        return 0
    fi
}

# if is_connected returns 1 then display_airpods
# if is_connected returns 0 then echo "AirPods: disconnected"
if is_connected; then
    echo "AirPods: disconnected"
else
    display_airpods
fi