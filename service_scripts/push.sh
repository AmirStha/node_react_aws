for ARGUMENT in "$@"
do

    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)   

    case "$KEY" in
            profile)     PROFILE=${VALUE} ;; 
            region)       REGION=${VALUE} ;;   
            localImage)   LOCAL_IMAGE=${VALUE} ;;
            ecrImage)     ECR_IMAGE=${VALUE} ;;
            *)   
    esac    


done

echo "REGION = $REGION"
echo "LOCAL_IMAGE = $LOCAL_IMAGE"
echo "ECR_IMAGE = $ECR_IMAGE"
echo "PROFILE = $PROFILE"

$(aws ecr get-login --region $REGION --no-include-email --profile=$PROFILE)
docker tag $LOCAL_IMAGE:latest $ECR_IMAGE:latest
docker push $ECR_IMAGE:latest