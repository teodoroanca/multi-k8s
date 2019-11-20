#!/usr/bin/env bash
docker build -t teodoroanca/multi-client:latest -t teodoroanca/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t teodoroanca/multi-server:latest -t teodoroanca/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t teodoroanca/multi-worker:latest -t teodoroanca/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push teodoroanca/multi-client:latest
docker push teodoroanca/multi-server:latest
docker push teodoroanca/multi-worker:latest

docker push teodoroanca/multi-client:$SHA
docker push teodoroanca/multi-server:$SHA
docker push teodoroanca/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=teodoroanca/multi-client:$SHA
kubectl set image deployments/server-deployment server=teodoroanca/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=teodoroanca/multi-worker:$SHA