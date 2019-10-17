for ARGUMENT in "$@"
do

    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)   

    case "$KEY" in
            stack_name)   STACK_NAME=${VALUE} ;;
            profile)      PROFILE=${VALUE} ;; 
            region)       REGION=${VALUE} ;;   
            *)   
    esac    


done

echo "STACK_NAME = $STACK_NAME"
echo "profile = $PROFILE"
echo "region = $REGION"

aws cloudformation delete-stack \
--profile ${PROFILE} \
--stack-name ${STACK_NAME} \
--region ${REGION}