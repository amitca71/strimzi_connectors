#!/usr/bin/bash -x
for i in $(ls -a secrets/.env*)
do 
	export ACCOUNT_NAME=`echo $i | cut -f 2 -d . | cut -f 2 -d _`
	out_name=./secrets/${ACCOUNT_NAME}_secret.properties
	source $i
	INPUT_FILE=single_account_template.properties OUTPUT_FILE=$out_name ./render-connector-config.sh
done
#cp secret_header_template.yaml ./secrets/kafka_secrets.yaml
for i in  $(ls -a secrets/*_secret.properties*)
do
	cat $i>>./secrets/kafka_secrets.properties
done
microk8s kubectl -n kafka create secret generic kafka-connector-secrets \
  --from-file=./secrets/kafka_secrets.properties
