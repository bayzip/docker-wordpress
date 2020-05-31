## Run with Minikube
After running minikube using `minikube start`, you can follow this command to create network and pods. 

```shell script
# MariaDB
kubectl create -f mysql-deploy.yml
kubectl create -f mysql-services.yml

# Redis (Only if you activated session)
kubectl create -f redis-deploy.yml
kubectl create -f mysql-services.yml

# Nginx + PHP FPM include WordPress
kubectl create -f wordpress-deploy.yml
kubectl create -f wordpress-services.yml
```

To access it, you can use the following command
```shell script
minikube service webserver --url
```

## Scalling
If you want to do scaling up/down on WordPress, you can use volume persistence to avoid inconsistency and data loss. After that, you can use this command to scale it.
```shell script
# Using edit
kubectl edit deployment webserver

# Change replicate from file and apply
kubectl apply -f wordpress-deploy.yml

# Using scale option
kubecl scale deployment.v1.apps/webserver --replicas=xxxx
```