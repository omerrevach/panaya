```
curl -L -o minikube-linux-amd64 https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
minikube start
```


```
# give permissions to run the script. It will install the kubernetes sealed secrets and deploy them
chmod +x install_deploy_sealed-secrets.sh
```

```
# this is for running the init.sql when the mysql pod is created
kubectl create configmap init-db-config --from-file=init-db/init.sql
```

```
helm upgrade --install panaya flask-app
```

```
# to open in browser

# get the nodeport of the flask service
kubectl get svc

# in browser to access the app
192.168.49.2:<nodePort>
```
#