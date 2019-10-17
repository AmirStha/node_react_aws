for ARGUMENT in "$@"
do

    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)   

    case "$KEY" in
            profile)     PROFILE=${VALUE} ;; 
            region)       REGION=${VALUE} ;;   
            localImage)   LOCAL_IMAGE=${VALUE} ;;
            ecrRepo)     ECR_REPO=${VALUE} ;;
            *)   
    esac    


done

echo "PROFILE = $PROFILE"
echo "REGION = $REGION"
echo "LOCAL_IMAGE = $LOCAL_IMAGE"
echo "ECR_REPO = $ECR_REPO"

$(aws ecr get-login --region $REGION --no-include-email --profile=$PROFILE)
docker tag $LOCAL_IMAGE:latest $ECR_REPO:latest
docker push $ECR_REPO:latest