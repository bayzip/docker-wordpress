## Run
After running minikube, you can use by creating deployment and services 

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

After that you can akses wordpress using command
```shell script
minikube service webserver --url
```

## Scalling
Since this wordpress support scalling, you can alwaays change replicate or scale deploymeng using this command

```shell script
# Using edit
kubectl edit deployment webserver

# Change replicate from file and apply
kubectl apply -f wordpress-deploy.yml

# Using scale option
kubecl scale deployment.v1.apps/webserver --replicas=xxxx
```