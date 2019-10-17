for ARGUMENT in "$@"
do

    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)   

    case "$KEY" in
            stack_name)   STACK_NAME=${VALUE} ;;
            yaml_file)    YAML_FILE_NAME=${VALUE} ;;     
            profile)      PROFILE=${VALUE} ;; 
            region)       REGION=${VALUE} ;;   
            user)         USERNAME=${VALUE} ;;     
            token)        BIT_TOKEN=${VALUE} ;; 
            s3branch)     S3_BRANCH=${VALUE} ;; 
            ecsbranch)    ECS_BRANCH=${VALUE} ;; 
            team)         TEAM=${VALUE} ;;     
            *)   
    esac    


done

echo "Updating a cloudformation stack ${STACK_NAME} using yaml ${YAML_FILE_NAME} from $PWD/cloudformation"
aws cloudformation update-stack \
--profile ${PROFILE}
--capabilities CAPABILITY_IAM \
--stack-name ${STACK_NAME} \
--region ${REGION} \
--template-body file://${PWD}/cloudformation/${YAML_FILE_NAME} \
--parameters ParameterKey=BitNodeToken ParameterValue=${BIT_TOKEN},ParameterKey=AWSUserName ParameterValue=${USERNAME},ParameterKey=CodeBuildRepositoryBranch ParameterValue=${S3_BRANCH},ParameterKey=CustomDeploymentTriggerBranch ParameterValue=${ECS_BRANCH},ParameterKey=TeamName ParameterValue=${TEAM}  
# --parameters ParameterKey=CustomS3BucketName,ParameterValue=pj-test-node-react