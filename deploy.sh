docker build  -t yihengchen/multi-client:latest -t yihengchen/multi-client:$SHA -f ./client/Dockerfile ./client
docker build  -t yihengchen/multi-server:latest -t yihengchen/multi-server:$SHA-f ./server/Dockerfile ./server
docker build  -t yihengchen/multi-worker:latest -t yihengchen/multi-worker:$SHA-f ./worker/Dockerfile ./worker

docker push yihengchen/multi-client:latest
docker push yihengchen/multi-server:latest
docker push yihengchen/multi-worker:latest

docker push yihengchen/multi-client:$SHA
docker push yihengchen/multi-server:$SHA
docker push yihengchen/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=yihengchen/multi-server:$SHA
kubectl set image deployments/client-deployment client=yihengchen/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=yihengchen/multi-worker:$SHA