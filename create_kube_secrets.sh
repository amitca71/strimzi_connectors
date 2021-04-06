#!/usr/bin/bash -x
for i in $(ls -a secrets/.env*)
do 
	export SECRET_NAME=`echo $i | cut -f 2 -d . | cut -f 2 -d _`
	out_name=./secrets/${SECRET_NAME}_secret.yaml 
	source $i
	INPUT_FILE=secret_template.yaml OUTPUT_FILE=$out_name ./render-connector-config.sh
	microk8s kubectl apply -f $out_name
done
