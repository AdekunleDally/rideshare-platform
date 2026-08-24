# External Secrets
```text
$ kubectl get externalsecret -A

NAMESPACE   NAME                       STORETYPE            STORE                 REFRESH INTERVAL   STATUS         READY   LAST SYNC
default     frontend-es                ClusterSecretStore   aws-secrets-manager   1h                 SecretSynced   True    22m
default     postgres-secret-es         ClusterSecretStore   aws-secrets-manager   1h                 SecretSynced   True    32m
default     redis-secret-es            ClusterSecretStore   aws-secrets-manager   1h                 SecretSynced   True    28m
postgres    postgres-secret-es         ClusterSecretStore   aws-secrets-manager   1h                 SecretSynced   True    3m4s
redis       redis-secret-es            ClusterSecretStore   aws-secrets-manager   1h                 SecretSynced   True    9m32s
rideshare   driver-db-secret-es        ClusterSecretStore   aws-secrets-manager   1h                 SecretSynced   True    9m8s
rideshare   driver-service-secret-es   ClusterSecretStore   aws-secrets-manager   1h                 SecretSynced   True    9m7s
rideshare   email-service-es           ClusterSecretStore   aws-secrets-manager   1h                 SecretSynced   True    41m
rideshare   frontend-es                ClusterSecretStore   aws-secrets-manager   1h                 SecretSynced   True    59s
rideshare   postgres-credentials-es    ClusterSecretStore   aws-secrets-manager   1h                 SecretSynced   True    9m4s
rideshare   postgresql-secret-es       ClusterSecretStore   aws-secrets-manager   1h                 SecretSynced   True    44m
rideshare   redis-credentials-es       ClusterSecretStore   aws-secrets-manager   1h                 SecretSynced   True    8m19s
rideshare   redis-secret-es            ClusterSecretStore   aws-secrets-manager   1h                 SecretSynced   True    19m
rideshare   rider-db-secret-es         ClusterSecretStore   aws-secrets-manager   1h                 SecretSynced   True    8m56s
rideshare   rider-service-secret-es    ClusterSecretStore   aws-secrets-manager   1h                 SecretSynced   True    8m57s
rideshare   trip-db-secret-es          ClusterSecretStore   aws-secrets-manager   1h                 SecretSynced   True    8m53s
rideshare   trip-service-secret-es     ClusterSecretStore   aws-secrets-manager   1h                 SecretSynced   True    8m53s
```

# Secret Stores
```text
$ kubectl get secretstore -A

No resources found
```

# Cluster Secret Stores
```text
$ kubectl get clustersecretstore

NAME                  AGE   STATUS   CAPABILITIES   READY
aws-secrets-manager   46d   Valid    ReadWrite      True
```

