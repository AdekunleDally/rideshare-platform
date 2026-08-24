# Certificates
```text
$ kubectl get certificate -A

NAMESPACE   NAME                 READY   SECRET              AGE
rideshare   lukmonadeokun-cert   True    lukmonadeokun-tls   9d
```

# Certificate Requests
```text
$ kubectl get certificaterequest -A

No resources found
```

# Orders
```text
$ kubectl get order -A

No resources found
```

# Challenges
```text
$ kubectl get challenge -A

No resources found
```

# Issuers
```text
$ kubectl get issuer -A

No resources found
```

# ClusterIssuers
```text
$ kubectl get clusterissuer

NAME               READY   AGE
letsencrypt-prod   True    9d
```

