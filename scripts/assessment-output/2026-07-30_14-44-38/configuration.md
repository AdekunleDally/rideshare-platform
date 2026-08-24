# ConfigMaps
```text
$ kubectl get configmap -A

NAMESPACE          NAME                                                   DATA   AGE
cert-manager       kube-root-ca.crt                                       1      49d
cnpg-system        cnpg-controller-manager-config                         0      43d
cnpg-system        cnpg-default-monitoring                                1      43d
cnpg-system        kube-root-ca.crt                                       1      43d
default            kube-root-ca.crt                                       1      49d
default            redis-redis-cluster-default                            1      42d
default            redis-redis-cluster-scripts                            2      42d
external-secrets   kube-root-ca.crt                                       1      46d
ingress-nginx      ingress-nginx-controller                               0      49d
ingress-nginx      kube-root-ca.crt                                       1      49d
kube-node-lease    kube-root-ca.crt                                       1      49d
kube-public        kube-root-ca.crt                                       1      49d
kube-system        amazon-vpc-cni                                         7      49d
kube-system        aws-auth                                               1      49d
kube-system        cluster-autoscaler-status                              1      45d
kube-system        coredns                                                1      49d
kube-system        extension-apiserver-authentication                     6      49d
kube-system        kube-apiserver-legacy-service-account-token-tracking   1      49d
kube-system        kube-proxy                                             1      49d
kube-system        kube-proxy-config                                      1      49d
kube-system        kube-root-ca.crt                                       1      49d
postgres           cnpg-default-monitoring                                1      42d
postgres           kube-root-ca.crt                                       1      42d
redis-system       kube-root-ca.crt                                       1      42d
redis              kube-root-ca.crt                                       1      42d
rideshare          driver-service-config                                  9      6d7h
rideshare          email-service-config                                   1      6d7h
rideshare          frontend-config                                        5      6d7h
rideshare          health-check-nginx                                     1      5d21h
rideshare          kube-root-ca.crt                                       1      40d
rideshare          matching-service-config                                6      6d7h
rideshare          rider-service-config                                   9      6d7h
rideshare          trip-service-config                                    2      6d7h
```

# Secrets
```text
$ kubectl get secret -A

NAMESPACE          NAME                                     TYPE                 DATA   AGE
cert-manager       cert-manager-webhook-ca                  Opaque               3      49d
cert-manager       letsencrypt-prod-key                     Opaque               1      49d
cert-manager       sh.helm.release.v1.cert-manager.v1       helm.sh/release.v1   1      49d
cnpg-system        cnpg-ca-secret                           Opaque               2      43d
cnpg-system        cnpg-webhook-cert                        kubernetes.io/tls    2      43d
cnpg-system        sh.helm.release.v1.cnpg.v1               helm.sh/release.v1   1      43d
default            frontend-secret                          Opaque               1      40d
default            postgres-secret                          Opaque               2      42d
default            redis-redis-cluster                      Opaque               1      42d
default            redis-secret                             Opaque               1      42d
default            sh.helm.release.v1.redis.v1              helm.sh/release.v1   1      42d
external-secrets   external-secrets-webhook                 Opaque               4      46d
external-secrets   sh.helm.release.v1.external-secrets.v1   helm.sh/release.v1   1      46d
external-secrets   sh.helm.release.v1.external-secrets.v2   helm.sh/release.v1   1      46d
external-secrets   sh.helm.release.v1.external-secrets.v3   helm.sh/release.v1   1      46d
ingress-nginx      ingress-nginx-admission                  Opaque               3      49d
ingress-nginx      sh.helm.release.v1.ingress-nginx.v1      helm.sh/release.v1   1      49d
postgres           postgres-secret                          Opaque               2      42d
postgres           rideshare-postgres-cluster-ca            Opaque               2      42d
postgres           rideshare-postgres-cluster-replication   kubernetes.io/tls    2      42d
postgres           rideshare-postgres-cluster-server        kubernetes.io/tls    2      42d
redis-system       sh.helm.release.v1.redis-operator.v1     helm.sh/release.v1   1      42d
redis-system       sh.helm.release.v1.redis-operator.v2     helm.sh/release.v1   1      42d
redis              redis-secret                             Opaque               1      42d
rideshare          driver-db-secret                         Opaque               1      40d
rideshare          driver-service-secret                    Opaque               1      40d
rideshare          email-service-secret                     Opaque               2      37d
rideshare          frontend-secret                          Opaque               1      40d
rideshare          lukmonadeokun-tls                        kubernetes.io/tls    2      39d
rideshare          postgres-credentials                     Opaque               2      40d
rideshare          postgresql-secret                        Opaque               2      39d
rideshare          redis-credentials                        Opaque               1      40d
rideshare          redis-secret                             Opaque               1      39d
rideshare          rider-db-secret                          Opaque               1      40d
rideshare          rider-service-secret                     Opaque               1      40d
rideshare          sh.helm.release.v1.rideshare.v1          helm.sh/release.v1   1      6d7h
rideshare          trip-db-secret                           Opaque               1      40d
rideshare          trip-service-secret                      Opaque               1      40d
```

