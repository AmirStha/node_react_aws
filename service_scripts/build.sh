for ARGUMENT in "$@"
do

    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)   

    case "$KEY" in
            localImage)   LOCAL_IMAGE=${VALUE} ;;
            token)      BIT_TOKEN=${VALUE} ;; 
            *)   
    esac    


done

docker build -t ${LOCAL_IMAGE} --build-arg BIT_NODE_TOKEN=${BIT_TOKEN} .