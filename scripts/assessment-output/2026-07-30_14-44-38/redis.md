# Redis Resources
```text
$ kubectl api-resources

NAME                                SHORTNAMES   APIVERSION                                NAMESPACED   KIND
bindings                                         v1                                        true         Binding
componentstatuses                   cs           v1                                        false        ComponentStatus
configmaps                          cm           v1                                        true         ConfigMap
endpoints                           ep           v1                                        true         Endpoints
events                              ev           v1                                        true         Event
limitranges                         limits       v1                                        true         LimitRange
namespaces                          ns           v1                                        false        Namespace
nodes                               no           v1                                        false        Node
persistentvolumeclaims              pvc          v1                                        true         PersistentVolumeClaim
persistentvolumes                   pv           v1                                        false        PersistentVolume
pods                                po           v1                                        true         Pod
podtemplates                                     v1                                        true         PodTemplate
replicationcontrollers              rc           v1                                        true         ReplicationController
resourcequotas                      quota        v1                                        true         ResourceQuota
secrets                                          v1                                        true         Secret
serviceaccounts                     sa           v1                                        true         ServiceAccount
services                            svc          v1                                        true         Service
challenges                                       acme.cert-manager.io/v1                   true         Challenge
orders                                           acme.cert-manager.io/v1                   true         Order
mutatingwebhookconfigurations                    admissionregistration.k8s.io/v1           false        MutatingWebhookConfiguration
validatingadmissionpolicies                      admissionregistration.k8s.io/v1           false        ValidatingAdmissionPolicy
validatingadmissionpolicybindings                admissionregistration.k8s.io/v1           false        ValidatingAdmissionPolicyBinding
validatingwebhookconfigurations                  admissionregistration.k8s.io/v1           false        ValidatingWebhookConfiguration
customresourcedefinitions           crd,crds     apiextensions.k8s.io/v1                   false        CustomResourceDefinition
apiservices                                      apiregistration.k8s.io/v1                 false        APIService
controllerrevisions                              apps/v1                                   true         ControllerRevision
daemonsets                          ds           apps/v1                                   true         DaemonSet
deployments                         deploy       apps/v1                                   true         Deployment
replicasets                         rs           apps/v1                                   true         ReplicaSet
statefulsets                        sts          apps/v1                                   true         StatefulSet
selfsubjectreviews                               authentication.k8s.io/v1                  false        SelfSubjectReview
tokenreviews                                     authentication.k8s.io/v1                  false        TokenReview
localsubjectaccessreviews                        authorization.k8s.io/v1                   true         LocalSubjectAccessReview
selfsubjectaccessreviews                         authorization.k8s.io/v1                   false        SelfSubjectAccessReview
selfsubjectrulesreviews                          authorization.k8s.io/v1                   false        SelfSubjectRulesReview
subjectaccessreviews                             authorization.k8s.io/v1                   false        SubjectAccessReview
horizontalpodautoscalers            hpa          autoscaling/v2                            true         HorizontalPodAutoscaler
cronjobs                            cj           batch/v1                                  true         CronJob
jobs                                             batch/v1                                  true         Job
certificaterequests                 cr,crs       cert-manager.io/v1                        true         CertificateRequest
certificates                        cert,certs   cert-manager.io/v1                        true         Certificate
clusterissuers                      ciss         cert-manager.io/v1                        false        ClusterIssuer
issuers                             iss          cert-manager.io/v1                        true         Issuer
certificatesigningrequests          csr          certificates.k8s.io/v1                    false        CertificateSigningRequest
leases                                           coordination.k8s.io/v1                    true         Lease
eniconfigs                                       crd.k8s.amazonaws.com/v1alpha1            false        ENIConfig
endpointslices                                   discovery.k8s.io/v1                       true         EndpointSlice
events                              ev           events.k8s.io/v1                          true         Event
clusterexternalsecrets              ces          external-secrets.io/v1                    false        ClusterExternalSecret
clusterpushsecrets                               external-secrets.io/v1alpha1              false        ClusterPushSecret
clustersecretstores                 css          external-secrets.io/v1                    false        ClusterSecretStore
externalsecrets                     es           external-secrets.io/v1                    true         ExternalSecret
pushsecrets                         ps           external-secrets.io/v1alpha1              true         PushSecret
secretstores                        ss           external-secrets.io/v1                    true         SecretStore
flowschemas                                      flowcontrol.apiserver.k8s.io/v1           false        FlowSchema
prioritylevelconfigurations                      flowcontrol.apiserver.k8s.io/v1           false        PriorityLevelConfiguration
acraccesstokens                                  generators.external-secrets.io/v1alpha1   true         ACRAccessToken
cloudsmithaccesstokens                           generators.external-secrets.io/v1alpha1   true         CloudsmithAccessToken
clustergenerators                                generators.external-secrets.io/v1alpha1   false        ClusterGenerator
ecrauthorizationtokens                           generators.external-secrets.io/v1alpha1   true         ECRAuthorizationToken
fakes                                            generators.external-secrets.io/v1alpha1   true         Fake
gcraccesstokens                                  generators.external-secrets.io/v1alpha1   true         GCRAccessToken
generatorstates                     gs           generators.external-secrets.io/v1alpha1   true         GeneratorState
githubaccesstokens                               generators.external-secrets.io/v1alpha1   true         GithubAccessToken
grafanas                                         generators.external-secrets.io/v1alpha1   true         Grafana
mfas                                             generators.external-secrets.io/v1alpha1   true         MFA
passwords                                        generators.external-secrets.io/v1alpha1   true         Password
quayaccesstokens                                 generators.external-secrets.io/v1alpha1   true         QuayAccessToken
sshkeys                                          generators.external-secrets.io/v1alpha1   true         SSHKey
stssessiontokens                                 generators.external-secrets.io/v1alpha1   true         STSSessionToken
uuids                                            generators.external-secrets.io/v1alpha1   true         UUID
vaultdynamicsecrets                              generators.external-secrets.io/v1alpha1   true         VaultDynamicSecret
webhooks                                         generators.external-secrets.io/v1alpha1   true         Webhook
nodes                                            metrics.k8s.io/v1beta1                    false        NodeMetrics
pods                                             metrics.k8s.io/v1beta1                    true         PodMetrics
applicationnetworkpolicies          anp          networking.k8s.aws/v1alpha1               true         ApplicationNetworkPolicy
clusternetworkpolicies              cnp          networking.k8s.aws/v1alpha1               false        ClusterNetworkPolicy
clusterpolicyendpoints              cpe          networking.k8s.aws/v1alpha1               false        ClusterPolicyEndpoint
policyendpoints                                  networking.k8s.aws/v1alpha1               true         PolicyEndpoint
ingressclasses                                   networking.k8s.io/v1                      false        IngressClass
ingresses                           ing          networking.k8s.io/v1                      true         Ingress
ipaddresses                         ip           networking.k8s.io/v1                      false        IPAddress
networkpolicies                     netpol       networking.k8s.io/v1                      true         NetworkPolicy
servicecidrs                                     networking.k8s.io/v1                      false        ServiceCIDR
runtimeclasses                                   node.k8s.io/v1                            false        RuntimeClass
poddisruptionbudgets                pdb          policy/v1                                 true         PodDisruptionBudget
backups                                          postgresql.cnpg.io/v1                     true         Backup
clusterimagecatalogs                             postgresql.cnpg.io/v1                     false        ClusterImageCatalog
clusters                                         postgresql.cnpg.io/v1                     true         Cluster
databases                                        postgresql.cnpg.io/v1                     true         Database
failoverquorums                                  postgresql.cnpg.io/v1                     true         FailoverQuorum
imagecatalogs                                    postgresql.cnpg.io/v1                     true         ImageCatalog
poolers                                          postgresql.cnpg.io/v1                     true         Pooler
publications                                     postgresql.cnpg.io/v1                     true         Publication
scheduledbackups                                 postgresql.cnpg.io/v1                     true         ScheduledBackup
subscriptions                                    postgresql.cnpg.io/v1                     true         Subscription
clusterrolebindings                              rbac.authorization.k8s.io/v1              false        ClusterRoleBinding
clusterroles                                     rbac.authorization.k8s.io/v1              false        ClusterRole
rolebindings                                     rbac.authorization.k8s.io/v1              true         RoleBinding
roles                                            rbac.authorization.k8s.io/v1              true         Role
redis                                            redis.redis.opstreelabs.in/v1beta2        true         Redis
redisclusters                                    redis.redis.opstreelabs.in/v1beta2        true         RedisCluster
redisreplications                                redis.redis.opstreelabs.in/v1beta2        true         RedisReplication
redissentinels                                   redis.redis.opstreelabs.in/v1beta2        true         RedisSentinel
deviceclasses                                    resource.k8s.io/v1                        false        DeviceClass
resourceclaims                                   resource.k8s.io/v1                        true         ResourceClaim
resourceclaimtemplates                           resource.k8s.io/v1                        true         ResourceClaimTemplate
resourceslices                                   resource.k8s.io/v1                        false        ResourceSlice
priorityclasses                     pc           scheduling.k8s.io/v1                      false        PriorityClass
csidrivers                                       storage.k8s.io/v1                         false        CSIDriver
csinodes                                         storage.k8s.io/v1                         false        CSINode
csistoragecapacities                             storage.k8s.io/v1                         true         CSIStorageCapacity
storageclasses                      sc           storage.k8s.io/v1                         false        StorageClass
volumeattachments                                storage.k8s.io/v1                         false        VolumeAttachment
volumeattributesclasses             vac          storage.k8s.io/v1                         false        VolumeAttributesClass
cninodes                            cnd          vpcresources.k8s.aws/v1alpha1             false        CNINode
securitygrouppolicies               sgp          vpcresources.k8s.aws/v1beta1              true         SecurityGroupPolicy
```

# Redis Clusters
```text
$ kubectl get rediscluster -A

NAMESPACE   NAME                      CLUSTERSIZE   READYLEADERREPLICAS   READYFOLLOWERREPLICAS
redis       rideshare-redis-cluster   3             3                     3
```

