if [ $1 = "start" ] 
then
    git pull origin master
    mix deps.get
    mix compile
    echo "Starting Watson"
    if [ -f ./rel/watson/bin/watson ]
    then
        ./rel/watson/bin/watson start
        echo "Watson started"
    fi



elif [ $1 = "stop" ]
then
    echo "Stopping Watson"
    ./rel/watson/bin/watson stop
    echo "Watson stopped"
fi
