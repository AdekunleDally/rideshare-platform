# Ingress NGINX
```text
$ kubectl get pods -n ingress-nginx

NAME                                       READY   STATUS    RESTARTS   AGE
ingress-nginx-controller-6fd7d65fb-62fw9   1/1     Running   0          49d
```

# cert-manager
```text
$ kubectl get pods -n cert-manager

NAME                                       READY   STATUS    RESTARTS   AGE
cert-manager-6647996d85-nzm9v              1/1     Running   0          9d
cert-manager-cainjector-7d4f95c968-drd8t   1/1     Running   0          49d
cert-manager-webhook-5d776c5db-9dxxm       1/1     Running   0          49d
```

# External Secrets Operator
```text
$ kubectl get pods -n external-secrets

NAME                                                READY   STATUS    RESTARTS   AGE
external-secrets-6dff86d645-8vd9n                   1/1     Running   0          46d
external-secrets-cert-controller-56995d8b88-q77sx   1/1     Running   0          46d
external-secrets-webhook-65f7c96fb8-zhw5p           1/1     Running   0          46d
```

# kube-system
```text
$ kubectl get pods -n kube-system

NAME                                  READY   STATUS    RESTARTS   AGE
aws-node-hkzpm                        2/2     Running   0          49d
aws-node-klp9r                        2/2     Running   0          49d
cluster-autoscaler-6ccdccd54b-fxtvh   1/1     Running   0          45d
coredns-64ff95db9-5pxq9               1/1     Running   0          49d
coredns-64ff95db9-6pqpf               1/1     Running   0          49d
ebs-csi-controller-684d9c6d4-9s2cq    6/6     Running   0          49d
ebs-csi-controller-684d9c6d4-wxbvl    6/6     Running   0          49d
ebs-csi-node-97427                    3/3     Running   0          49d
ebs-csi-node-vsb8w                    3/3     Running   0          49d
kube-proxy-g5zzs                      1/1     Running   0          49d
kube-proxy-ph7rj                      1/1     Running   0          49d
metrics-server-7c4574785-9gw8g        1/1     Running   0          49d
metrics-server-7c4574785-kkskp        1/1     Running   0          49d
```

