# Service Accounts
```text
$ kubectl get sa -A

NAMESPACE          NAME                                          SECRETS   AGE
cert-manager       cert-manager                                  0         49d
cert-manager       cert-manager-cainjector                       0         49d
cert-manager       cert-manager-webhook                          0         49d
cert-manager       default                                       0         49d
cnpg-system        cnpg-cloudnative-pg                           0         43d
cnpg-system        default                                       0         43d
default            default                                       0         49d
default            redis-redis-cluster                           0         42d
external-secrets   default                                       0         46d
external-secrets   external-secrets-cert-controller              0         46d
external-secrets   external-secrets-sa                           0         46d
external-secrets   external-secrets-webhook                      0         46d
ingress-nginx      default                                       0         49d
ingress-nginx      ingress-nginx                                 0         49d
kube-node-lease    default                                       0         49d
kube-public        default                                       0         49d
kube-system        attachdetach-controller                       0         49d
kube-system        aws-cloud-provider                            0         49d
kube-system        aws-node                                      0         49d
kube-system        certificate-controller                        0         49d
kube-system        cluster-autoscaler-sa                         0         45d
kube-system        clusterrole-aggregation-controller            0         49d
kube-system        coredns                                       0         49d
kube-system        cronjob-controller                            0         49d
kube-system        daemon-set-controller                         0         49d
kube-system        default                                       0         49d
kube-system        deployment-controller                         0         49d
kube-system        disruption-controller                         0         49d
kube-system        ebs-csi-controller-sa                         0         49d
kube-system        ebs-csi-node-sa                               0         49d
kube-system        endpoint-controller                           0         49d
kube-system        endpointslice-controller                      0         49d
kube-system        endpointslicemirroring-controller             0         49d
kube-system        ephemeral-volume-controller                   0         49d
kube-system        expand-controller                             0         49d
kube-system        generic-garbage-collector                     0         49d
kube-system        horizontal-pod-autoscaler                     0         49d
kube-system        job-controller                                0         49d
kube-system        kube-proxy                                    0         49d
kube-system        legacy-service-account-token-cleaner          0         49d
kube-system        metrics-server                                0         49d
kube-system        namespace-controller                          0         49d
kube-system        node-controller                               0         49d
kube-system        persistent-volume-binder                      0         49d
kube-system        pod-garbage-collector                         0         49d
kube-system        pv-protection-controller                      0         49d
kube-system        pvc-protection-controller                     0         49d
kube-system        replicaset-controller                         0         49d
kube-system        replication-controller                        0         49d
kube-system        resource-claim-controller                     0         49d
kube-system        resourcequota-controller                      0         49d
kube-system        root-ca-cert-publisher                        0         49d
kube-system        service-account-controller                    0         49d
kube-system        service-cidrs-controller                      0         49d
kube-system        service-controller                            0         49d
kube-system        statefulset-controller                        0         49d
kube-system        tagging-controller                            0         49d
kube-system        ttl-after-finished-controller                 0         49d
kube-system        ttl-controller                                0         49d
kube-system        validatingadmissionpolicy-status-controller   0         49d
kube-system        volumeattributesclass-protection-controller   0         49d
postgres           default                                       0         42d
postgres           rideshare-postgres-cluster                    0         42d
redis-system       default                                       0         42d
redis-system       redis-operator                                0         42d
redis              default                                       0         42d
rideshare          default                                       0         40d
```

# Roles
```text
$ kubectl get role -A

NAMESPACE          NAME                                             CREATED AT
cert-manager       cert-manager-webhook:dynamic-serving             2026-06-11T09:35:03Z
external-secrets   external-secrets-leaderelection                  2026-06-13T16:53:05Z
ingress-nginx      ingress-nginx                                    2026-06-10T19:15:40Z
kube-public        system:controller:bootstrap-signer               2026-06-10T14:42:59Z
kube-system        cert-manager-cainjector:leaderelection           2026-06-11T09:35:03Z
kube-system        cert-manager:leaderelection                      2026-06-11T09:35:03Z
kube-system        cluster-autoscaler                               2026-06-14T16:33:16Z
kube-system        ebs-csi-leases-role                              2026-06-10T17:12:11Z
kube-system        eks-vpc-resource-controller-role                 2026-06-10T14:43:03Z
kube-system        eks:addon-manager                                2026-06-10T14:43:01Z
kube-system        eks:authenticator                                2026-06-10T14:43:00Z
kube-system        eks:az-poller                                    2026-06-10T14:43:00Z
kube-system        eks:coredns-autoscaler                           2026-06-10T14:43:00Z
kube-system        eks:fargate-manager                              2026-06-10T14:43:01Z
kube-system        eks:network-policy-controller                    2026-06-10T14:43:03Z
kube-system        eks:node-manager                                 2026-06-10T14:43:01Z
kube-system        eks:service-operations-configmaps                2026-06-10T14:43:00Z
kube-system        extension-apiserver-authentication-reader        2026-06-10T14:42:59Z
kube-system        system::leader-locking-kube-controller-manager   2026-06-10T14:42:59Z
kube-system        system::leader-locking-kube-scheduler            2026-06-10T14:42:59Z
kube-system        system:controller:bootstrap-signer               2026-06-10T14:42:59Z
kube-system        system:controller:cloud-provider                 2026-06-10T14:42:59Z
kube-system        system:controller:token-cleaner                  2026-06-10T14:42:59Z
postgres           rideshare-postgres-cluster                       2026-06-18T13:47:09Z
```

# RoleBindings
```text
$ kubectl get rolebinding -A

NAMESPACE          NAME                                                ROLE                                                  AGE
cert-manager       cert-manager-webhook:dynamic-serving                Role/cert-manager-webhook:dynamic-serving             49d
external-secrets   external-secrets-leaderelection                     Role/external-secrets-leaderelection                  46d
ingress-nginx      ingress-nginx                                       Role/ingress-nginx                                    49d
kube-public        system:controller:bootstrap-signer                  Role/system:controller:bootstrap-signer               49d
kube-system        cert-manager-cainjector:leaderelection              Role/cert-manager-cainjector:leaderelection           49d
kube-system        cert-manager:leaderelection                         Role/cert-manager:leaderelection                      49d
kube-system        cluster-autoscaler                                  Role/cluster-autoscaler                               45d
kube-system        ebs-csi-leases-rolebinding                          Role/ebs-csi-leases-role                              49d
kube-system        eks-vpc-resource-controller-rolebinding             Role/eks-vpc-resource-controller-role                 49d
kube-system        eks:addon-manager                                   Role/eks:addon-manager                                49d
kube-system        eks:authenticator                                   Role/eks:authenticator                                49d
kube-system        eks:az-poller                                       Role/eks:az-poller                                    49d
kube-system        eks:coredns-autoscaler                              Role/eks:coredns-autoscaler                           49d
kube-system        eks:fargate-manager                                 Role/eks:fargate-manager                              49d
kube-system        eks:network-policy-controller                       Role/eks:network-policy-controller                    49d
kube-system        eks:node-manager                                    Role/eks:node-manager                                 49d
kube-system        eks:service-operations                              Role/eks:service-operations-configmaps                49d
kube-system        metrics-server-auth-reader                          Role/extension-apiserver-authentication-reader        49d
kube-system        system::extension-apiserver-authentication-reader   Role/extension-apiserver-authentication-reader        49d
kube-system        system::leader-locking-kube-controller-manager      Role/system::leader-locking-kube-controller-manager   49d
kube-system        system::leader-locking-kube-scheduler               Role/system::leader-locking-kube-scheduler            49d
kube-system        system:controller:bootstrap-signer                  Role/system:controller:bootstrap-signer               49d
kube-system        system:controller:cloud-provider                    Role/system:controller:cloud-provider                 49d
kube-system        system:controller:token-cleaner                     Role/system:controller:token-cleaner                  49d
postgres           rideshare-postgres-cluster                          Role/rideshare-postgres-cluster                       42d
```

# ClusterRoles
```text
$ kubectl get clusterrole

NAME                                                                   CREATED AT
admin                                                                  2026-06-10T14:42:58Z
aws-node                                                               2026-06-10T14:46:20Z
cert-manager-cainjector                                                2026-06-11T09:35:02Z
cert-manager-cluster-view                                              2026-06-11T09:35:02Z
cert-manager-controller-approve:cert-manager-io                        2026-06-11T09:35:02Z
cert-manager-controller-certificates                                   2026-06-11T09:35:02Z
cert-manager-controller-certificatesigningrequests                     2026-06-11T09:35:02Z
cert-manager-controller-challenges                                     2026-06-11T09:35:02Z
cert-manager-controller-clusterissuers                                 2026-06-11T09:35:02Z
cert-manager-controller-ingress-shim                                   2026-06-11T09:35:02Z
cert-manager-controller-issuers                                        2026-06-11T09:35:02Z
cert-manager-controller-orders                                         2026-06-11T09:35:02Z
cert-manager-edit                                                      2026-06-11T09:35:02Z
cert-manager-view                                                      2026-06-11T09:35:02Z
cert-manager-webhook:subjectaccessreviews                              2026-06-11T09:35:02Z
cluster-admin                                                          2026-06-10T14:42:58Z
cluster-autoscaler                                                     2026-06-14T16:33:15Z
cnpg-cloudnative-pg                                                    2026-06-17T13:44:40Z
cnpg-cloudnative-pg-edit                                               2026-06-17T13:44:40Z
cnpg-cloudnative-pg-view                                               2026-06-17T13:44:40Z
ebs-csi-node-role                                                      2026-06-10T17:12:09Z
ebs-external-attacher-role                                             2026-06-10T17:12:09Z
ebs-external-provisioner-role                                          2026-06-10T17:12:10Z
ebs-external-resizer-role                                              2026-06-10T17:12:10Z
ebs-external-snapshotter-role                                          2026-06-10T17:12:10Z
edit                                                                   2026-06-10T14:42:58Z
eks:addon-manager                                                      2026-06-10T14:43:01Z
eks:az-poller                                                          2026-06-10T14:43:00Z
eks:cluster-event-watcher                                              2026-06-10T14:43:00Z
eks:coredns-autoscaler                                                 2026-06-10T14:43:00Z
eks:fargate-manager                                                    2026-06-10T14:43:01Z
eks:fargate-scheduler                                                  2026-06-10T14:43:00Z
eks:kms-storage-migrator                                               2026-06-10T14:43:00Z
eks:network-policy-controller                                          2026-06-10T14:43:03Z
eks:network-webhooks                                                   2026-06-10T14:43:00Z
eks:node-bootstrapper                                                  2026-06-10T14:43:01Z
eks:node-manager                                                       2026-06-10T14:43:00Z
eks:nodewatcher                                                        2026-06-10T14:43:00Z
eks:pod-identity-mutating-webhook                                      2026-06-10T14:43:00Z
eks:service-operations                                                 2026-06-10T14:43:00Z
eks:tagging-controller                                                 2026-06-10T14:43:00Z
external-secrets-cert-controller                                       2026-06-13T16:53:04Z
external-secrets-controller                                            2026-06-13T16:53:04Z
external-secrets-edit                                                  2026-06-13T16:53:04Z
external-secrets-servicebindings                                       2026-06-13T16:53:04Z
external-secrets-view                                                  2026-06-13T16:53:04Z
ingress-nginx                                                          2026-06-10T19:15:39Z
redis-operator                                                         2026-06-18T07:58:33Z
system:aggregate-to-admin                                              2026-06-10T14:42:58Z
system:aggregate-to-edit                                               2026-06-10T14:42:58Z
system:aggregate-to-view                                               2026-06-10T14:42:58Z
system:auth-delegator                                                  2026-06-10T14:42:58Z
system:basic-user                                                      2026-06-10T14:42:58Z
system:certificates.k8s.io:certificatesigningrequests:nodeclient       2026-06-10T14:42:58Z
system:certificates.k8s.io:certificatesigningrequests:selfnodeclient   2026-06-10T14:42:58Z
system:certificates.k8s.io:kube-apiserver-client-approver              2026-06-10T14:42:58Z
system:certificates.k8s.io:kube-apiserver-client-kubelet-approver      2026-06-10T14:42:58Z
system:certificates.k8s.io:kubelet-serving-approver                    2026-06-10T14:42:58Z
system:certificates.k8s.io:legacy-unknown-approver                     2026-06-10T14:42:58Z
system:controller:attachdetach-controller                              2026-06-10T14:42:58Z
system:controller:certificate-controller                               2026-06-10T14:42:58Z
system:controller:clusterrole-aggregation-controller                   2026-06-10T14:42:58Z
system:controller:cronjob-controller                                   2026-06-10T14:42:58Z
system:controller:daemon-set-controller                                2026-06-10T14:42:58Z
system:controller:deployment-controller                                2026-06-10T14:42:58Z
system:controller:disruption-controller                                2026-06-10T14:42:58Z
system:controller:endpoint-controller                                  2026-06-10T14:42:58Z
system:controller:endpointslice-controller                             2026-06-10T14:42:58Z
system:controller:endpointslicemirroring-controller                    2026-06-10T14:42:58Z
system:controller:ephemeral-volume-controller                          2026-06-10T14:42:58Z
system:controller:expand-controller                                    2026-06-10T14:42:58Z
system:controller:generic-garbage-collector                            2026-06-10T14:42:58Z
system:controller:horizontal-pod-autoscaler                            2026-06-10T14:42:58Z
system:controller:job-controller                                       2026-06-10T14:42:58Z
system:controller:legacy-service-account-token-cleaner                 2026-06-10T14:42:58Z
system:controller:namespace-controller                                 2026-06-10T14:42:58Z
system:controller:node-controller                                      2026-06-10T14:42:58Z
system:controller:persistent-volume-binder                             2026-06-10T14:42:58Z
system:controller:pod-garbage-collector                                2026-06-10T14:42:58Z
system:controller:pv-protection-controller                             2026-06-10T14:42:58Z
system:controller:pvc-protection-controller                            2026-06-10T14:42:58Z
system:controller:replicaset-controller                                2026-06-10T14:42:58Z
system:controller:replication-controller                               2026-06-10T14:42:58Z
system:controller:resource-claim-controller                            2026-06-10T14:42:58Z
system:controller:resourcequota-controller                             2026-06-10T14:42:58Z
system:controller:root-ca-cert-publisher                               2026-06-10T14:42:58Z
system:controller:route-controller                                     2026-06-10T14:42:58Z
system:controller:selinux-warning-controller                           2026-06-10T14:42:58Z
system:controller:service-account-controller                           2026-06-10T14:42:58Z
system:controller:service-cidrs-controller                             2026-06-10T14:42:58Z
system:controller:service-controller                                   2026-06-10T14:42:58Z
system:controller:statefulset-controller                               2026-06-10T14:42:58Z
system:controller:ttl-after-finished-controller                        2026-06-10T14:42:58Z
system:controller:ttl-controller                                       2026-06-10T14:42:58Z
system:controller:validatingadmissionpolicy-status-controller          2026-06-10T14:42:58Z
system:controller:volumeattributesclass-protection-controller          2026-06-10T14:42:58Z
system:coredns                                                         2026-06-10T14:46:24Z
system:discovery                                                       2026-06-10T14:42:58Z
system:heapster                                                        2026-06-10T14:42:58Z
system:kube-aggregator                                                 2026-06-10T14:42:58Z
system:kube-controller-manager                                         2026-06-10T14:42:58Z
system:kube-dns                                                        2026-06-10T14:42:58Z
system:kube-scheduler                                                  2026-06-10T14:42:58Z
system:kubelet-api-admin                                               2026-06-10T14:42:58Z
system:metrics-server                                                  2026-06-10T14:54:03Z
system:metrics-server-aggregated-reader                                2026-06-10T14:54:03Z
system:monitoring                                                      2026-06-10T14:42:58Z
system:node                                                            2026-06-10T14:42:58Z
system:node-bootstrapper                                               2026-06-10T14:42:58Z
system:node-problem-detector                                           2026-06-10T14:42:58Z
system:node-proxier                                                    2026-06-10T14:42:58Z
system:persistent-volume-provisioner                                   2026-06-10T14:42:58Z
system:public-info-viewer                                              2026-06-10T14:42:58Z
system:service-account-issuer-discovery                                2026-06-10T14:42:58Z
system:volume-scheduler                                                2026-06-10T14:42:58Z
view                                                                   2026-06-10T14:42:58Z
vpc-resource-controller-role                                           2026-06-10T14:43:03Z
```

# ClusterRoleBindings
```text
$ kubectl get clusterrolebinding

NAME                                                            ROLE                                                                        AGE
aws-node                                                        ClusterRole/aws-node                                                        49d
cert-manager-cainjector                                         ClusterRole/cert-manager-cainjector                                         49d
cert-manager-controller-approve:cert-manager-io                 ClusterRole/cert-manager-controller-approve:cert-manager-io                 49d
cert-manager-controller-certificates                            ClusterRole/cert-manager-controller-certificates                            49d
cert-manager-controller-certificatesigningrequests              ClusterRole/cert-manager-controller-certificatesigningrequests              49d
cert-manager-controller-challenges                              ClusterRole/cert-manager-controller-challenges                              49d
cert-manager-controller-clusterissuers                          ClusterRole/cert-manager-controller-clusterissuers                          49d
cert-manager-controller-ingress-shim                            ClusterRole/cert-manager-controller-ingress-shim                            49d
cert-manager-controller-issuers                                 ClusterRole/cert-manager-controller-issuers                                 49d
cert-manager-controller-orders                                  ClusterRole/cert-manager-controller-orders                                  49d
cert-manager-webhook:subjectaccessreviews                       ClusterRole/cert-manager-webhook:subjectaccessreviews                       49d
cluster-admin                                                   ClusterRole/cluster-admin                                                   49d
cluster-autoscaler                                              ClusterRole/cluster-autoscaler                                              45d
cnpg-cloudnative-pg                                             ClusterRole/cnpg-cloudnative-pg                                             43d
ebs-csi-attacher-binding                                        ClusterRole/ebs-external-attacher-role                                      49d
ebs-csi-node-getter-binding                                     ClusterRole/ebs-csi-node-role                                               49d
ebs-csi-provisioner-binding                                     ClusterRole/ebs-external-provisioner-role                                   49d
ebs-csi-resizer-binding                                         ClusterRole/ebs-external-resizer-role                                       49d
ebs-csi-snapshotter-binding                                     ClusterRole/ebs-external-snapshotter-role                                   49d
eks:addon-cluster-admin                                         ClusterRole/cluster-admin                                                   49d
eks:addon-manager                                               ClusterRole/eks:addon-manager                                               49d
eks:az-poller                                                   ClusterRole/eks:az-poller                                                   49d
eks:cluster-event-watcher                                       ClusterRole/eks:cluster-event-watcher                                       49d
eks:coredns-autoscaler                                          ClusterRole/eks:coredns-autoscaler                                          49d
eks:fargate-manager                                             ClusterRole/eks:fargate-manager                                             49d
eks:fargate-scheduler                                           ClusterRole/eks:fargate-scheduler                                           49d
eks:kms-storage-migrator                                        ClusterRole/eks:kms-storage-migrator                                        49d
eks:kube-proxy                                                  ClusterRole/system:node-proxier                                             49d
eks:kube-proxy-fargate                                          ClusterRole/system:node-proxier                                             49d
eks:kube-proxy-windows                                          ClusterRole/system:node-proxier                                             49d
eks:network-policy-controller                                   ClusterRole/eks:network-policy-controller                                   49d
eks:network-webhooks                                            ClusterRole/eks:network-webhooks                                            49d
eks:node-bootstrapper                                           ClusterRole/eks:node-bootstrapper                                           49d
eks:node-manager                                                ClusterRole/eks:node-manager                                                49d
eks:nodewatcher                                                 ClusterRole/eks:nodewatcher                                                 49d
eks:pod-identity-mutating-webhook                               ClusterRole/eks:pod-identity-mutating-webhook                               49d
eks:service-operations                                          ClusterRole/eks:service-operations                                          49d
eks:tagging-controller                                          ClusterRole/eks:tagging-controller                                          49d
external-secrets-cert-controller                                ClusterRole/external-secrets-cert-controller                                46d
external-secrets-controller                                     ClusterRole/external-secrets-controller                                     46d
ingress-nginx                                                   ClusterRole/ingress-nginx                                                   49d
metrics-server:system:auth-delegator                            ClusterRole/system:auth-delegator                                           49d
redis-operator                                                  ClusterRole/redis-operator                                                  42d
system:basic-user                                               ClusterRole/system:basic-user                                               49d
system:controller:attachdetach-controller                       ClusterRole/system:controller:attachdetach-controller                       49d
system:controller:certificate-controller                        ClusterRole/system:controller:certificate-controller                        49d
system:controller:clusterrole-aggregation-controller            ClusterRole/system:controller:clusterrole-aggregation-controller            49d
system:controller:cronjob-controller                            ClusterRole/system:controller:cronjob-controller                            49d
system:controller:daemon-set-controller                         ClusterRole/system:controller:daemon-set-controller                         49d
system:controller:deployment-controller                         ClusterRole/system:controller:deployment-controller                         49d
system:controller:disruption-controller                         ClusterRole/system:controller:disruption-controller                         49d
system:controller:endpoint-controller                           ClusterRole/system:controller:endpoint-controller                           49d
system:controller:endpointslice-controller                      ClusterRole/system:controller:endpointslice-controller                      49d
system:controller:endpointslicemirroring-controller             ClusterRole/system:controller:endpointslicemirroring-controller             49d
system:controller:ephemeral-volume-controller                   ClusterRole/system:controller:ephemeral-volume-controller                   49d
system:controller:expand-controller                             ClusterRole/system:controller:expand-controller                             49d
system:controller:generic-garbage-collector                     ClusterRole/system:controller:generic-garbage-collector                     49d
system:controller:horizontal-pod-autoscaler                     ClusterRole/system:controller:horizontal-pod-autoscaler                     49d
system:controller:job-controller                                ClusterRole/system:controller:job-controller                                49d
system:controller:legacy-service-account-token-cleaner          ClusterRole/system:controller:legacy-service-account-token-cleaner          49d
system:controller:namespace-controller                          ClusterRole/system:controller:namespace-controller                          49d
system:controller:node-controller                               ClusterRole/system:controller:node-controller                               49d
system:controller:persistent-volume-binder                      ClusterRole/system:controller:persistent-volume-binder                      49d
system:controller:pod-garbage-collector                         ClusterRole/system:controller:pod-garbage-collector                         49d
system:controller:pv-protection-controller                      ClusterRole/system:controller:pv-protection-controller                      49d
system:controller:pvc-protection-controller                     ClusterRole/system:controller:pvc-protection-controller                     49d
system:controller:replicaset-controller                         ClusterRole/system:controller:replicaset-controller                         49d
system:controller:replication-controller                        ClusterRole/system:controller:replication-controller                        49d
system:controller:resource-claim-controller                     ClusterRole/system:controller:resource-claim-controller                     49d
system:controller:resourcequota-controller                      ClusterRole/system:controller:resourcequota-controller                      49d
system:controller:root-ca-cert-publisher                        ClusterRole/system:controller:root-ca-cert-publisher                        49d
system:controller:route-controller                              ClusterRole/system:controller:route-controller                              49d
system:controller:selinux-warning-controller                    ClusterRole/system:controller:selinux-warning-controller                    49d
system:controller:service-account-controller                    ClusterRole/system:controller:service-account-controller                    49d
system:controller:service-cidrs-controller                      ClusterRole/system:controller:service-cidrs-controller                      49d
system:controller:service-controller                            ClusterRole/system:controller:service-controller                            49d
system:controller:statefulset-controller                        ClusterRole/system:controller:statefulset-controller                        49d
system:controller:ttl-after-finished-controller                 ClusterRole/system:controller:ttl-after-finished-controller                 49d
system:controller:ttl-controller                                ClusterRole/system:controller:ttl-controller                                49d
system:controller:validatingadmissionpolicy-status-controller   ClusterRole/system:controller:validatingadmissionpolicy-status-controller   49d
system:controller:volumeattributesclass-protection-controller   ClusterRole/system:controller:volumeattributesclass-protection-controller   49d
system:coredns                                                  ClusterRole/system:coredns                                                  49d
system:discovery                                                ClusterRole/system:discovery                                                49d
system:kube-controller-manager                                  ClusterRole/system:kube-controller-manager                                  49d
system:kube-dns                                                 ClusterRole/system:kube-dns                                                 49d
system:kube-scheduler                                           ClusterRole/system:kube-scheduler                                           49d
system:metrics-server                                           ClusterRole/system:metrics-server                                           49d
system:monitoring                                               ClusterRole/system:monitoring                                               49d
system:node                                                     ClusterRole/system:node                                                     49d
system:node-proxier                                             ClusterRole/system:node-proxier                                             49d
system:public-info-viewer                                       ClusterRole/system:public-info-viewer                                       49d
system:service-account-issuer-discovery                         ClusterRole/system:service-account-issuer-discovery                         49d
system:volume-scheduler                                         ClusterRole/system:volume-scheduler                                         49d
vpc-resource-controller-rolebinding                             ClusterRole/vpc-resource-controller-role                                    49d
```

