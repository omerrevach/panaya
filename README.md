# Employee List with minikube

## This is a simple web application for displaying employee information. The application uses Flask for the backend and MySQL as the database, with helm setup for easy deployment with minikube.


```
.
├── flask-app
│   ├── Chart.yaml
│   ├── templates
│   │   ├── flask-deployment.yaml
│   │   ├── flask-service.yaml
│   │   ├── _helpers.tpl
│   │   ├── mysql-deployment.yaml
│   │   └── mysql-service.yaml
│   └── values.yaml
├── init-db
│   └── init.sql
├── install_deploy_sealed-secrets.sh
└── README.md
```
#### `Prerequisites`
- Docker
- Docker Compose
- helm
- minikube

###  Setup Instructions
1. **Install and start minikube**
    ```
    curl -L -o minikube-linux-amd64 https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
    minikube start
    ```

2. **This script ensures that sensitive information, like database credentials, is securely managed in Kubernetes. By sealing the secrets, you avoid exposing them in plain text and protect them from unauthorized access**
    ```
    # give permissions to run the script. It will install the kubernetes sealed secrets and deploy them
    chmod +x install_deploy_sealed-secrets.sh
    ./install_deploy_sealed-secrets.sh
    ```

3. **Create a configmap for init.sql and mount it**
    ```
    kubectl create configmap init-db-config --from-file=init-db/init.sql
    ```

4 **Install the helm chart**
    ```
    helm upgrade --install panaya flask-app
    ```

5. **OPen app in browser**
    ```
    # get the nodeport of the flask service
    kubectl get svc

    # in browser to access the app
    192.168.49.2:<nodePort>
    ```
#