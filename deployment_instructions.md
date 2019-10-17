## Deploy in a new AWS Account

- If you are going to deploy in a completely new AWS account, please copy the cloudformation templates to an S3 bucket

```bash
aws s3 cp ./cloudformation/templates_ecs s3://pj-test-ecs-deploy-resources-bucket/templates --recursive
```

# Steps for deployment

## Three cloudformation stack needs to be deployed

<!-- ## Common Steps

- ./service_scripts/create_stack.sh shailendra-s3-deploy-ecs main.ecs.yaml 7b76e084-98d0-4cf6-852b-50aabea4e593(where the three parameters are stackname, yamlConfigFile, bitToken) -->

## 1> codecommit stack

### step 1:

- To create code commit repo

  Example

  ```bash
  ./service_scripts/create_stack.sh stack_name="projectrt-ecs-fargate-deploy" yaml_file="main.codecommit.yaml" profile="default" user="shailendra" token="7b76e084-98d0-4cf6-852b-50aabea4e593" region="ap-south-1"
  ```

  replace the value inside with your required inputs,

  - "**stack_name**" should be unique
  - "**yaml_file**" is the file used for the task for codecommit is main.codecommit.yaml
  - "**profile**" is the aws profile you want to use ( refer to ~/.aws/config)
  - "**user**" can be only those accounts with access to aws resources, ( shailendra and amir are valid and tested aws users)
  - "**token**" is the bit node token, for now you can you the one in the example
  - "**region**" is the aws region you want to deploy your application
    \

* check if resources are created in aws console(Cloudformation Section)
* push the code to the code commit repo(manual for now for first time)
* To push follow the two steps:

  ```bash
  git remote add <origin_name> <code_commit_repo_url>
  ```

  Example
  /
  code_commit_repo_url: https://git-codecommit.<region: example ap-south-1>.amazonaws.com/v1/repos/<example:projectrt-codecommit-node-react>

  you can also find it in code commit and just use it for now.

  ```bash
  git push --set-upstream cicd <branch_name>
  ```

currently s3 rests in master and ecs in staging by default

## 2> s3 stack

### step 1:

- To create code commit repo
  Example

  ```bash
  ./service_scripts/create_stack.sh stack_name="projectrt-s3-deploy" yaml_file="main.s3.yaml" profile="default" user="shailendra" token="7b76e084-98d0-4cf6-852b-50aabea4e593" region="ap-south-1"
  ```

  replace the value inside with your required imputs user can be only those accounts with access to aws resources for now shailendra and amir are valid and tested.the yaml_file is the file used for the task for s3 is main.s3.yaml.

## 3> ecs stack

### step 1:

- create bucket will do it later using cli(for now manual only for cloud team)
- put all the template codes there(above created bucket) inside templates directory
- bucket name as constant with value "ecs-configuration"

### step 2:

- To create ecr repo
  Example

```bash
./service_scripts/create_stack.sh stack_name="projectrt-ecr-repo" yaml_file="main.docker_ecr.yaml" profile="default" user="shailendra" token="7b76e084-98d0-4cf6-852b-50aabea4e593" region="ap-south-1"
```

replace the value inside with your required imputs user can be only those accounts with access to aws resources for now shailendra and amir are valid and tested.the yaml_file is the file used for the task for ecrrepocreation is main.docker_ecr.yaml.

### step 3:

- build docker image
- update details inside push
- finally execute ./service_scripts/push.sh
- To create ecs stack
  Example
  ```bash
  ./service_scripts/create_stack.sh stack_name="projectrt-ecs-fargate-deploy" yaml_file="main.ecs.yaml" profile="default" user="shailendra" token="7b76e084-98d0-4cf6-852b-50aabea4e593" region="ap-south-1"
  ```
  replace the value inside with your required imputs user can be only those accounts with access to aws resources for now shailendra and amir are valid and tested.the yaml_file is the file used for the task for ecs deployment is main.ecs.yaml.
