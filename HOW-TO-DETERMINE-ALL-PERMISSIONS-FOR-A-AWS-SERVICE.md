From: https://meirg.co.il/2021/04/23/determining-aws-iam-policies-according-to-terraform-and-aws-cli/

Terminal 1:

docker rm iamlive-test
winpty docker run \
  -p 80:10080 \
  -p 443:10080 \
  --name iamlive-test \
  -it unfor19/iamlive-docker \
  --mode proxy \
  --bind-addr 0.0.0.0:10080 \
  --force-wildcard-resource \
  --output-file "/app/iamlive.log"


Terminal 2:

unset HTTP_PROXY HTTPS_PROXY AWS_CA_BUNDLE
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
 
export HTTP_PROXY=http://127.0.0.1:80 \
       HTTPS_PROXY=http://127.0.0.1:443 \
       AWS_CA_BUNDLE="${HOME}/.iamlive/ca.pem"

docker cp iamlive-test:/home/appuser/.iamlive/ ~/