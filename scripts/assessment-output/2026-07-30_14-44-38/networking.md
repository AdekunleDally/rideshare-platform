# Services
```text
$ kubectl get svc -A -o wide

NAMESPACE          NAME                                          TYPE           CLUSTER-IP       EXTERNAL-IP                                                                     PORT(S)                      AGE     SELECTOR
cert-manager       cert-manager                                  ClusterIP      10.100.69.88     <none>                                                                          9402/TCP                     49d     app.kubernetes.io/component=controller,app.kubernetes.io/instance=cert-manager,app.kubernetes.io/name=cert-manager
cert-manager       cert-manager-webhook                          ClusterIP      10.100.147.104   <none>                                                                          443/TCP                      49d     app.kubernetes.io/component=webhook,app.kubernetes.io/instance=cert-manager,app.kubernetes.io/name=webhook
cnpg-system        cnpg-webhook-service                          ClusterIP      10.100.118.87    <none>                                                                          443/TCP                      43d     app.kubernetes.io/instance=cnpg,app.kubernetes.io/name=cloudnative-pg
default            kubernetes                                    ClusterIP      10.100.0.1       <none>                                                                          443/TCP                      49d     <none>
external-secrets   external-secrets-webhook                      ClusterIP      10.100.255.160   <none>                                                                          443/TCP                      46d     app.kubernetes.io/instance=external-secrets,app.kubernetes.io/name=external-secrets-webhook
ingress-nginx      ingress-nginx-controller                      LoadBalancer   10.100.109.236   af4d02018fcc84e7982beb4837cd8ba1-cf864548dc4bc09f.elb.us-east-2.amazonaws.com   80:31267/TCP,443:31513/TCP   49d     app.kubernetes.io/component=controller,app.kubernetes.io/instance=ingress-nginx,app.kubernetes.io/name=ingress-nginx
ingress-nginx      ingress-nginx-controller-admission            ClusterIP      10.100.236.20    <none>                                                                          443/TCP                      49d     app.kubernetes.io/component=controller,app.kubernetes.io/instance=ingress-nginx,app.kubernetes.io/name=ingress-nginx
kube-system        eks-extension-metrics-api                     ClusterIP      10.100.48.158    <none>                                                                          443/TCP                      49d     <none>
kube-system        kube-dns                                      ClusterIP      10.100.0.10      <none>                                                                          53/UDP,53/TCP,9153/TCP       49d     k8s-app=kube-dns
kube-system        metrics-server                                ClusterIP      10.100.198.41    <none>                                                                          443/TCP                      49d     app.kubernetes.io/instance=metrics-server,app.kubernetes.io/name=metrics-server
postgres           rideshare-postgres-cluster-r                  ClusterIP      10.100.43.10     <none>                                                                          5432/TCP                     41d     cnpg.io/cluster=rideshare-postgres-cluster,cnpg.io/podRole=instance
postgres           rideshare-postgres-cluster-ro                 ClusterIP      10.100.199.185   <none>                                                                          5432/TCP                     41d     cnpg.io/cluster=rideshare-postgres-cluster,cnpg.io/instanceRole=replica
postgres           rideshare-postgres-cluster-rw                 ClusterIP      10.100.206.114   <none>                                                                          5432/TCP                     41d     cnpg.io/cluster=rideshare-postgres-cluster,cnpg.io/instanceRole=primary
redis              rideshare-redis-cluster-follower              ClusterIP      10.100.80.77     <none>                                                                          6379/TCP                     41d     app=rideshare-redis-cluster-follower,redis_setup_type=cluster,role=follower
redis              rideshare-redis-cluster-follower-additional   ClusterIP      10.100.155.28    <none>                                                                          6379/TCP                     41d     app=rideshare-redis-cluster-follower,redis_setup_type=cluster,role=follower
redis              rideshare-redis-cluster-follower-headless     ClusterIP      None             <none>                                                                          6379/TCP                     41d     app=rideshare-redis-cluster-follower,redis_setup_type=cluster,role=follower
redis              rideshare-redis-cluster-leader                ClusterIP      10.100.49.191    <none>                                                                          6379/TCP                     41d     app=rideshare-redis-cluster-leader,redis_setup_type=cluster,role=leader
redis              rideshare-redis-cluster-leader-additional     ClusterIP      10.100.177.16    <none>                                                                          6379/TCP                     41d     app=rideshare-redis-cluster-leader,redis_setup_type=cluster,role=leader
redis              rideshare-redis-cluster-leader-headless       ClusterIP      None             <none>                                                                          6379/TCP                     41d     app=rideshare-redis-cluster-leader,redis_setup_type=cluster,role=leader
redis              rideshare-redis-cluster-master                ClusterIP      10.100.148.196   <none>                                                                          6379/TCP                     41d     cluster=rideshare-redis-cluster,redis-role=master,redis_setup_type=cluster
rideshare          driver-service                                ClusterIP      10.100.132.207   <none>                                                                          3003/TCP                     6d7h    app=driver-service
rideshare          email-service                                 ClusterIP      10.100.143.175   <none>                                                                          3002/TCP                     6d7h    app=email-service
rideshare          frontend                                      ClusterIP      10.100.7.185     <none>                                                                          3000/TCP                     6d7h    app=frontend
rideshare          health-check                                  ClusterIP      10.100.83.86     <none>                                                                          80/TCP                       5d21h   app=health-check
rideshare          matching-service                              ClusterIP      10.100.48.31     <none>                                                                          3004/TCP                     6d7h    app=matching-service
rideshare          rider-service                                 ClusterIP      10.100.62.106    <none>                                                                          3001/TCP                     6d7h    app=rider-service
rideshare          trip-service                                  ClusterIP      10.100.184.144   <none>                                                                          3005/TCP,3006/TCP            6d7h    app=trip-service
```

# Ingresses
```text
$ kubectl get ingress -A

NAMESPACE   NAME                            CLASS   HOSTS                         ADDRESS                                                                         PORTS     AGE
rideshare   rideshare-health                nginx   *                             af4d02018fcc84e7982beb4837cd8ba1-cf864548dc4bc09f.elb.us-east-2.amazonaws.com   80        5d20h
rideshare   rideshare-ingress               nginx   rideshare.lukmonadeokun.com   af4d02018fcc84e7982beb4837cd8ba1-cf864548dc4bc09f.elb.us-east-2.amazonaws.com   80, 443   5d20h
rideshare   rideshare-ingress-matching-ws   nginx   rideshare.lukmonadeokun.com   af4d02018fcc84e7982beb4837cd8ba1-cf864548dc4bc09f.elb.us-east-2.amazonaws.com   80, 443   5d20h
```

# Ingress Details
```text
$ kubectl describe ingress -A

Name:             rideshare-health
Labels:           <none>
Namespace:        rideshare
Address:          af4d02018fcc84e7982beb4837cd8ba1-cf864548dc4bc09f.elb.us-east-2.amazonaws.com
Ingress Class:    nginx
Default backend:  <default>
Rules:
  Host        Path  Backends
  ----        ----  --------
  *           
              /application-healthz   health-check:80 (192.168.150.210:80)
Annotations:  nginx.ingress.kubernetes.io/ssl-redirect: false


Name:             rideshare-ingress
Labels:           <none>
Namespace:        rideshare
Address:          af4d02018fcc84e7982beb4837cd8ba1-cf864548dc4bc09f.elb.us-east-2.amazonaws.com
Ingress Class:    nginx
Default backend:  <default>
TLS:
  lukmonadeokun-tls terminates rideshare.lukmonadeokun.com
Rules:
  Host                         Path  Backends
  ----                         ----  --------
  rideshare.lukmonadeokun.com  
                               /api/v1/rider       rider-service:3001 ()
                               /api/v1/riders      rider-service:3001 ()
                               /api/v1/driver      driver-service:3003 (192.168.141.187:3003,192.168.166.35:3003)
                               /api/v1/drivers     driver-service:3003 (192.168.141.187:3003,192.168.166.35:3003)
                               /api/v1/trip        trip-service:3005 (192.168.164.78:3005)
                               /api/v1/trips       trip-service:3005 (192.168.164.78:3005)
                               /api/v1/matching    matching-service:3004 (192.168.177.128:3004)
                               /api/v1/matchings   matching-service:3004 (192.168.177.128:3004)
                               /api/v1/email       email-service:3002 (192.168.149.160:3002)
                               /api/v1/emails      email-service:3002 (192.168.149.160:3002)
                               /api/v1/fares       trip-service:3005 (192.168.164.78:3005)
                               /                   frontend:3000 (192.168.176.198:3000)
Annotations:                   nginx.ingress.kubernetes.io/force-ssl-redirect: true
                               nginx.ingress.kubernetes.io/proxy-http-version: 1.1
                               nginx.ingress.kubernetes.io/proxy-read-timeout: 3600
                               nginx.ingress.kubernetes.io/proxy-send-timeout: 3600
                               nginx.ingress.kubernetes.io/ssl-redirect: true


Name:             rideshare-ingress-matching-ws
Labels:           <none>
Namespace:        rideshare
Address:          af4d02018fcc84e7982beb4837cd8ba1-cf864548dc4bc09f.elb.us-east-2.amazonaws.com
Ingress Class:    nginx
Default backend:  <default>
TLS:
  lukmonadeokun-tls terminates rideshare.lukmonadeokun.com
Rules:
  Host                         Path  Backends
  ----                         ----  --------
  rideshare.lukmonadeokun.com  
                               /api/v1/matching/ws   matching-service:3004 (192.168.177.128:3004)
Annotations:                   nginx.ingress.kubernetes.io/force-ssl-redirect: true
                               nginx.ingress.kubernetes.io/proxy-http-version: 1.1
                               nginx.ingress.kubernetes.io/proxy-read-timeout: 3600
                               nginx.ingress.kubernetes.io/proxy-send-timeout: 3600
                               nginx.ingress.kubernetes.io/rewrite-target: /ws
                               nginx.ingress.kubernetes.io/ssl-redirect: true
                               nginx.ingress.kubernetes.io/use-regex: true
```

# Endpoints
```text
$ kubectl get endpoints -A

Warning: v1 Endpoints is deprecated in v1.33+; use discovery.k8s.io/v1 EndpointSlice
NAMESPACE          NAME                                          ENDPOINTS                                                           AGE
cert-manager       cert-manager                                  192.168.150.16:9402                                                 49d
cert-manager       cert-manager-webhook                          192.168.173.206:10250                                               49d
cnpg-system        cnpg-webhook-service                          192.168.176.22:9443                                                 43d
default            kubernetes                                    192.168.129.203:443,192.168.161.145:443                             49d
external-secrets   external-secrets-webhook                      192.168.141.170:10250                                               46d
ingress-nginx      ingress-nginx-controller                      192.168.137.34:443,192.168.137.34:80                                49d
ingress-nginx      ingress-nginx-controller-admission            192.168.137.34:8443                                                 49d
kube-system        eks-extension-metrics-api                     172.0.32.0:10443                                                    49d
kube-system        kube-dns                                      192.168.171.74:53,192.168.184.93:53,192.168.171.74:53 + 3 more...   49d
kube-system        metrics-server                                192.168.140.41:10251,192.168.162.147:10251                          49d
postgres           rideshare-postgres-cluster-r                  192.168.131.1:5432,192.168.172.5:5432,192.168.175.41:5432           41d
postgres           rideshare-postgres-cluster-ro                 192.168.131.1:5432,192.168.175.41:5432                              41d
postgres           rideshare-postgres-cluster-rw                 192.168.172.5:5432                                                  41d
redis              rideshare-redis-cluster-follower              192.168.128.25:6379,192.168.178.149:6379,192.168.182.237:6379       41d
redis              rideshare-redis-cluster-follower-additional   192.168.128.25:6379,192.168.178.149:6379,192.168.182.237:6379       41d
redis              rideshare-redis-cluster-follower-headless     192.168.128.25:6379,192.168.178.149:6379,192.168.182.237:6379       41d
redis              rideshare-redis-cluster-leader                192.168.136.239:6379,192.168.175.165:6379,192.168.182.30:6379       41d
redis              rideshare-redis-cluster-leader-additional     192.168.136.239:6379,192.168.175.165:6379,192.168.182.30:6379       41d
redis              rideshare-redis-cluster-leader-headless       192.168.136.239:6379,192.168.175.165:6379,192.168.182.30:6379       41d
redis              rideshare-redis-cluster-master                192.168.136.239:6379,192.168.175.165:6379,192.168.182.30:6379       41d
rideshare          driver-service                                192.168.141.187:3003,192.168.166.35:3003                            6d7h
rideshare          email-service                                 192.168.149.160:3002                                                6d7h
rideshare          frontend                                      192.168.176.198:3000                                                6d7h
rideshare          health-check                                  192.168.150.210:80                                                  5d21h
rideshare          matching-service                              192.168.177.128:3004                                                6d7h
rideshare          rider-service                                                                                                     6d7h
rideshare          trip-service                                  192.168.164.78:3005,192.168.164.78:3006                             6d7h
```

# Network Policies
```text
$ kubectl get networkpolicy -A

NAMESPACE   NAME                  POD-SELECTOR                                                            AGE
default     redis-redis-cluster   app.kubernetes.io/instance=redis,app.kubernetes.io/name=redis-cluster   42d
```

