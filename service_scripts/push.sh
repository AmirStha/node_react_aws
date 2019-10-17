$(aws ecr get-login --region us-west-2 --no-include-email)
docker tag ecs-node-react-ecr:latest 713147272639.dkr.ecr.us-west-2.amazonaws.com/shailendra-ecr-node-react-ecr:latest
docker push 713147272639.dkr.ecr.us-west-2.amazonaws.com/shailendra-ecr-node-react-ecr:latest