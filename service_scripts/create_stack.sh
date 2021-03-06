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
            s3_branch)     S3_BRANCH=${VALUE} ;; 
            ecs_branch)    ECS_BRANCH=${VALUE} ;; 
            team)         TEAM=${VALUE} ;; 
            ecs_memory)   ECS_MEMORY=${VALUE} ;;   
            ecs_cpu)      ECS_CPU=${VALUE} ;;   
            *)   
    esac    


done

# filePath = "file://${PWD}/cloudformation/${YAML_FILE_NAME}";
# stringContain() { [ -z "${2##*$1*}" ]; }
# if stringContain 'o "Msys' `echo $uname -a`;then filePath="${PWD}/cloudformation/${YAML_FILE_NAME}";
# fi
# echo $filePath

echo "STACK_NAME = $STACK_NAME"
echo "YAML_FILE_NAME = $YAML_FILE_NAME"
echo "profile = $PROFILE"
echo "user = $USERNAME"
echo "token = $BIT_TOKEN"
echo "region = $REGION"
echo "s3_branch" = $S3_BRANCH
echo "ecs_branch" = $ECS_BRANCH
echo "team" = $TEAM
echo "ecs_cpu" = $ECS_CPU
echo "ecs_memory" = $ECS_MEMORY

echo "Creating a cloudformation stack ${STACK_NAME} using yaml ${YAML_FILE_NAME} from $PWD/cloudformation"

aws cloudformation create-stack \
--profile ${PROFILE} \
--capabilities CAPABILITY_IAM \
--stack-name ${STACK_NAME} \
--region ${REGION} \
--template-body ${PWD}/cloudformation/${YAML_FILE_NAME} \
--parameters ParameterKey=BitNodeToken,ParameterValue=${BIT_TOKEN} ParameterKey=AWSUserName,ParameterValue=${USERNAME} ParameterKey=CodeBuildRepositoryBranch,ParameterValue=${S3_BRANCH} ParameterKey=CustomDeploymentTriggerBranch,ParameterValue=${ECS_BRANCH} ParameterKey=TeamName,ParameterValue=${TEAM} ParameterKey=CPU,ParameterValue=${ECS_CPU} ParameterKey=MEMORY,ParameterValue=${ECS_MEMORY}  
# --parameters ParameterKey=CustomS3BucketName,ParameterValue=pj-test-node-react 