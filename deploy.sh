#build the images and tag them
docker build -t shivendra30/multi-client:latest -t shivendra30/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shivendra30/multi-server:latest -t shivendra30/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shivendra30/multi-worker:latest -t shivendra30/multi-worker:$SHA -f ./worker/Dockerfile ./worker

#push the latest version of the images
docker push shivendra30/multi-client:latest
docker push shivendra30/multi-server:latest
docker push shivendra30/multi-worker:latest

#push the SHA version of the images
docker push shivendra30/multi-client:$SHA
docker push shivendra30/multi-server:$SHA
docker push shivendra30/multi-worker:$SHA

#Apply our config files with kubectl
kubectl apply -f k8s
#Imperative commands to fetch a specific tag of the image
kubectl set image deployments/server-deployment server=shivendra30/multi-server:$SHA
kubectl set image deployments/client-deployment client=shivendra30/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=shivendra30/multi-worker:$SHA


#We are using GIT SHA to avoid setting a manual version everytime we push our code. 
#This helps us autogenerate a unique tag for our image every time

