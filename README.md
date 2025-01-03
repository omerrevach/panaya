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
1. **Clone the minikube branch**
    ```
    git clone --branch minikube --depth 1 https://github.com/omerrevach/panaya.git
    cd panaya
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

3. **Add minikube ingress**
    ```
    minikube addons enable ingress
    ```

4. **Install the Helm Chart**
    ```bash
    helm upgrade --install panaya flask-app
    ```

5. **Open app in browser**
    ```
    sudo nano /etc/hosts

    # add this line
    192.168.49.2 panaya.com

    # in browser enter:
    http://panaya.com
    ```
5. **To remove everything**
    ```
    helm uninstall panaya
    kubectl delete sealedsecret my-db-secret
    kubectl delete configmap init-db-config
    ```