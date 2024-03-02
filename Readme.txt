docker build -t flask-hello-world:latest .
docker push KO
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml