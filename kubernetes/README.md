# Descreption
In this example, we will deploy wordpress by using Linode kubernetes. We use g6-standard-1 instance with 2 GB/1 Core in this example.

## Componen
First thing first, we need to install this component first. 
- Nginx: https://kubernetes.github.io/ingress-nginx/deploy/
- Metric Server "Don't forget add --kubelet-insecure-tls and use internal comunication"
- LinkerD: https://linkerd.io/2/getting-started/

## WordPress
1. Namespace: wordpress
2. Persisntence volume in: /usr/share/nginx/html/

Note: Cause we don't use NFS, so we can't scale it. 

## Database - MariaDB
1. Namespace: database
2. Type: steteful
3. Persisntence volume in: /var/lib/mysql