# Cluster Information
```text
$ kubectl cluster-info

Kubernetes control plane is running at https://E3337844267F066CEF7C59134EDA4AA4.gr7.us-east-2.eks.amazonaws.com
CoreDNS is running at https://E3337844267F066CEF7C59134EDA4AA4.gr7.us-east-2.eks.amazonaws.com/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```

# Kubernetes Version
```text
$ kubectl version

Client Version: v1.36.1
Kustomize Version: v5.8.1
Server Version: v1.34.9-eks-8f14419
Warning: version difference between client (1.36) and server (1.34) exceeds the supported minor version skew of +/-1
```

# Current Context
```text
$ kubectl config current-context

arn:aws:eks:us-east-2:495331822130:cluster/lukman-rideshare-cluster
```

# Namespaces
```text
$ kubectl get ns

NAME               STATUS   AGE
cert-manager       Active   49d
cnpg-system        Active   43d
default            Active   49d
external-secrets   Active   46d
ingress-nginx      Active   49d
kube-node-lease    Active   49d
kube-public        Active   49d
kube-system        Active   49d
postgres           Active   41d
redis              Active   42d
redis-system       Active   42d
rideshare          Active   40d
```

# Nodes
```text
$ kubectl get nodes -o wide

NAME                                            STATUS   ROLES    AGE   VERSION               INTERNAL-IP       EXTERNAL-IP   OS-IMAGE                        KERNEL-VERSION                    CONTAINER-RUNTIME
ip-192-168-129-187.us-east-2.compute.internal   Ready    <none>   49d   v1.34.8-eks-3385e9b   192.168.129.187   <none>        Amazon Linux 2023.11.20260526   6.12.88-119.157.amzn2023.x86_64   containerd://2.2.3+unknown
ip-192-168-191-123.us-east-2.compute.internal   Ready    <none>   49d   v1.34.8-eks-3385e9b   192.168.191.123   <none>        Amazon Linux 2023.11.20260526   6.12.88-119.157.amzn2023.x86_64   containerd://2.2.3+unknown
```

# Node Details
```text
$ kubectl describe nodes

Name:               ip-192-168-129-187.us-east-2.compute.internal
Roles:              <none>
Labels:             alpha.eksctl.io/cluster-name=lukman-rideshare-cluster
                    alpha.eksctl.io/nodegroup-name=general-purpose
                    beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/instance-type=t3.large
                    beta.kubernetes.io/os=linux
                    eks.amazonaws.com/capacityType=ON_DEMAND
                    eks.amazonaws.com/nodegroup=general-purpose
                    eks.amazonaws.com/nodegroup-image=ami-07ad00aa10fc48bc1
                    eks.amazonaws.com/sourceLaunchTemplateId=lt-09e921d614b3da32f
                    eks.amazonaws.com/sourceLaunchTemplateVersion=1
                    failure-domain.beta.kubernetes.io/region=us-east-2
                    failure-domain.beta.kubernetes.io/zone=us-east-2a
                    k8s.io/cloud-provider-aws=9ba9d5b73bf024adf97f4e930251e70a
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=ip-192-168-129-187.us-east-2.compute.internal
                    kubernetes.io/os=linux
                    node.kubernetes.io/instance-type=t3.large
                    role=general
                    topology.ebs.csi.aws.com/zone=us-east-2a
                    topology.k8s.aws/zone-id=use2-az1
                    topology.kubernetes.io/region=us-east-2
                    topology.kubernetes.io/zone=us-east-2a
Annotations:        alpha.kubernetes.io/provided-node-ip: 192.168.129.187
                    csi.volume.kubernetes.io/nodeid: {"ebs.csi.aws.com":"i-0ae3eaaa7c97cb4d6"}
                    node.alpha.kubernetes.io/ttl: 0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Wed, 10 Jun 2026 15:50:45 +0100
Taints:             <none>
Unschedulable:      false
Lease:
  HolderIdentity:  ip-192-168-129-187.us-east-2.compute.internal
  AcquireTime:     <unset>
  RenewTime:       Thu, 30 Jul 2026 14:44:59 +0100
Conditions:
  Type             Status  LastHeartbeatTime                 LastTransitionTime                Reason                       Message
  ----             ------  -----------------                 ------------------                ------                       -------
  MemoryPressure   False   Thu, 30 Jul 2026 14:44:46 +0100   Wed, 10 Jun 2026 15:50:42 +0100   KubeletHasSufficientMemory   kubelet has sufficient memory available
  DiskPressure     False   Thu, 30 Jul 2026 14:44:46 +0100   Wed, 10 Jun 2026 15:50:42 +0100   KubeletHasNoDiskPressure     kubelet has no disk pressure
  PIDPressure      False   Thu, 30 Jul 2026 14:44:46 +0100   Wed, 10 Jun 2026 15:50:42 +0100   KubeletHasSufficientPID      kubelet has sufficient PID available
  Ready            True    Thu, 30 Jul 2026 14:44:46 +0100   Wed, 10 Jun 2026 15:50:57 +0100   KubeletReady                 kubelet is posting ready status
Addresses:
  InternalIP:   192.168.129.187
  InternalDNS:  ip-192-168-129-187.us-east-2.compute.internal
  Hostname:     ip-192-168-129-187.us-east-2.compute.internal
Capacity:
  cpu:                2
  ephemeral-storage:  52350956Ki
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             8006060Ki
  pods:               35
Allocatable:
  cpu:                1930m
  ephemeral-storage:  47172899146
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             7248300Ki
  pods:               35
System Info:
  Machine ID:                 ec234386826a52b50a608b9be663d816
  System UUID:                ec234386-826a-52b5-0a60-8b9be663d816
  Boot ID:                    26aa7b17-9995-4dfb-96e7-32ac65ba1c0e
  Kernel Version:             6.12.88-119.157.amzn2023.x86_64
  OS Image:                   Amazon Linux 2023.11.20260526
  Operating System:           linux
  Architecture:               amd64
  Container Runtime Version:  containerd://2.2.3+unknown
  Kubelet Version:            v1.34.8-eks-3385e9b
ProviderID:                   aws:///us-east-2a/i-0ae3eaaa7c97cb4d6
Non-terminated Pods:          (18 in total)
  Namespace                   Name                                         CPU Requests  CPU Limits  Memory Requests  Memory Limits  Age
  ---------                   ----                                         ------------  ----------  ---------------  -------------  ---
  cert-manager                cert-manager-6647996d85-nzm9v                0 (0%)        0 (0%)      0 (0%)           0 (0%)         9d
  cert-manager                cert-manager-cainjector-7d4f95c968-drd8t     0 (0%)        0 (0%)      0 (0%)           0 (0%)         49d
  external-secrets            external-secrets-6dff86d645-8vd9n            0 (0%)        0 (0%)      0 (0%)           0 (0%)         46d
  external-secrets            external-secrets-webhook-65f7c96fb8-zhw5p    0 (0%)        0 (0%)      0 (0%)           0 (0%)         46d
  ingress-nginx               ingress-nginx-controller-6fd7d65fb-62fw9     100m (5%)     0 (0%)      90Mi (1%)        0 (0%)         49d
  kube-system                 aws-node-hkzpm                               50m (2%)      0 (0%)      0 (0%)           0 (0%)         49d
  kube-system                 ebs-csi-controller-684d9c6d4-wxbvl           60m (3%)      0 (0%)      232Mi (3%)       1312Mi (18%)   49d
  kube-system                 ebs-csi-node-vsb8w                           30m (1%)      0 (0%)      104Mi (1%)       320Mi (4%)     49d
  kube-system                 kube-proxy-g5zzs                             100m (5%)     0 (0%)      0 (0%)           0 (0%)         49d
  kube-system                 metrics-server-7c4574785-9gw8g               100m (5%)     0 (0%)      200Mi (2%)       400Mi (5%)     49d
  postgres                    rideshare-postgres-cluster-2                 0 (0%)        0 (0%)      0 (0%)           0 (0%)         41d
  redis-system                redis-operator-76695dcfbd-rks9g              500m (25%)    500m (25%)  500Mi (7%)       500Mi (7%)     42d
  redis                       rideshare-redis-cluster-follower-1           0 (0%)        0 (0%)      0 (0%)           0 (0%)         41d
  redis                       rideshare-redis-cluster-leader-1             0 (0%)        0 (0%)      0 (0%)           0 (0%)         41d
  rideshare                   driver-service-6477687469-qbqqx              100m (5%)     500m (25%)  256Mi (3%)       512Mi (7%)     6d7h
  rideshare                   email-service-54c86f5597-rw6g4               100m (5%)     500m (25%)  256Mi (3%)       512Mi (7%)     6d7h
  rideshare                   health-check-f5b7d485b-ffbw2                 0 (0%)        0 (0%)      0 (0%)           0 (0%)         5d20h
  rideshare                   rider-service-58d494f4f9-6mlvf               100m (5%)     500m (25%)  256Mi (3%)       512Mi (7%)     2d19h
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests      Limits
  --------           --------      ------
  cpu                1240m (64%)   2 (103%)
  memory             1894Mi (26%)  4068Mi (57%)
  ephemeral-storage  0 (0%)        0 (0%)
  hugepages-1Gi      0 (0%)        0 (0%)
  hugepages-2Mi      0 (0%)        0 (0%)


Name:               ip-192-168-191-123.us-east-2.compute.internal
Roles:              <none>
Labels:             alpha.eksctl.io/cluster-name=lukman-rideshare-cluster
                    alpha.eksctl.io/nodegroup-name=general-purpose
                    beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/instance-type=t3.large
                    beta.kubernetes.io/os=linux
                    eks.amazonaws.com/capacityType=ON_DEMAND
                    eks.amazonaws.com/nodegroup=general-purpose
                    eks.amazonaws.com/nodegroup-image=ami-07ad00aa10fc48bc1
                    eks.amazonaws.com/sourceLaunchTemplateId=lt-09e921d614b3da32f
                    eks.amazonaws.com/sourceLaunchTemplateVersion=1
                    failure-domain.beta.kubernetes.io/region=us-east-2
                    failure-domain.beta.kubernetes.io/zone=us-east-2c
                    k8s.io/cloud-provider-aws=9ba9d5b73bf024adf97f4e930251e70a
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=ip-192-168-191-123.us-east-2.compute.internal
                    kubernetes.io/os=linux
                    node.kubernetes.io/instance-type=t3.large
                    role=general
                    topology.ebs.csi.aws.com/zone=us-east-2c
                    topology.k8s.aws/zone-id=use2-az3
                    topology.kubernetes.io/region=us-east-2
                    topology.kubernetes.io/zone=us-east-2c
Annotations:        alpha.kubernetes.io/provided-node-ip: 192.168.191.123
                    csi.volume.kubernetes.io/nodeid: {"ebs.csi.aws.com":"i-013d1dd1592bc5332"}
                    node.alpha.kubernetes.io/ttl: 0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Wed, 10 Jun 2026 15:50:43 +0100
Taints:             <none>
Unschedulable:      false
Lease:
  HolderIdentity:  ip-192-168-191-123.us-east-2.compute.internal
  AcquireTime:     <unset>
  RenewTime:       Thu, 30 Jul 2026 14:44:55 +0100
Conditions:
  Type             Status  LastHeartbeatTime                 LastTransitionTime                Reason                       Message
  ----             ------  -----------------                 ------------------                ------                       -------
  MemoryPressure   False   Thu, 30 Jul 2026 14:43:55 +0100   Wed, 10 Jun 2026 15:50:39 +0100   KubeletHasSufficientMemory   kubelet has sufficient memory available
  DiskPressure     False   Thu, 30 Jul 2026 14:43:55 +0100   Wed, 10 Jun 2026 15:50:39 +0100   KubeletHasNoDiskPressure     kubelet has no disk pressure
  PIDPressure      False   Thu, 30 Jul 2026 14:43:55 +0100   Wed, 10 Jun 2026 15:50:39 +0100   KubeletHasSufficientPID      kubelet has sufficient PID available
  Ready            True    Thu, 30 Jul 2026 14:43:55 +0100   Wed, 10 Jun 2026 15:50:55 +0100   KubeletReady                 kubelet is posting ready status
Addresses:
  InternalIP:   192.168.191.123
  InternalDNS:  ip-192-168-191-123.us-east-2.compute.internal
  Hostname:     ip-192-168-191-123.us-east-2.compute.internal
Capacity:
  cpu:                2
  ephemeral-storage:  52350956Ki
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             8006068Ki
  pods:               35
Allocatable:
  cpu:                1930m
  ephemeral-storage:  47172899146
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             7248308Ki
  pods:               35
System Info:
  Machine ID:                 ec271e0be62587fbd6185f4144b8f65b
  System UUID:                ec271e0b-e625-87fb-d618-5f4144b8f65b
  Boot ID:                    8c7b0cfc-870a-44ae-bc31-b4e9b1328125
  Kernel Version:             6.12.88-119.157.amzn2023.x86_64
  OS Image:                   Amazon Linux 2023.11.20260526
  Operating System:           linux
  Architecture:               amd64
  Container Runtime Version:  containerd://2.2.3+unknown
  Kubelet Version:            v1.34.8-eks-3385e9b
ProviderID:                   aws:///us-east-2c/i-013d1dd1592bc5332
Non-terminated Pods:          (21 in total)
  Namespace                   Name                                                 CPU Requests  CPU Limits  Memory Requests  Memory Limits  Age
  ---------                   ----                                                 ------------  ----------  ---------------  -------------  ---
  cert-manager                cert-manager-webhook-5d776c5db-9dxxm                 0 (0%)        0 (0%)      0 (0%)           0 (0%)         49d
  cnpg-system                 cnpg-cloudnative-pg-59c97c679-tdk52                  0 (0%)        0 (0%)      0 (0%)           0 (0%)         43d
  external-secrets            external-secrets-cert-controller-56995d8b88-q77sx    0 (0%)        0 (0%)      0 (0%)           0 (0%)         46d
  kube-system                 aws-node-klp9r                                       50m (2%)      0 (0%)      0 (0%)           0 (0%)         49d
  kube-system                 cluster-autoscaler-6ccdccd54b-fxtvh                  100m (5%)     100m (5%)   600Mi (8%)       600Mi (8%)     45d
  kube-system                 coredns-64ff95db9-5pxq9                              100m (5%)     0 (0%)      70Mi (0%)        170Mi (2%)     49d
  kube-system                 coredns-64ff95db9-6pqpf                              100m (5%)     0 (0%)      70Mi (0%)        170Mi (2%)     49d
  kube-system                 ebs-csi-controller-684d9c6d4-9s2cq                   60m (3%)      0 (0%)      232Mi (3%)       1312Mi (18%)   49d
  kube-system                 ebs-csi-node-97427                                   30m (1%)      0 (0%)      104Mi (1%)       320Mi (4%)     49d
  kube-system                 kube-proxy-ph7rj                                     100m (5%)     0 (0%)      0 (0%)           0 (0%)         49d
  kube-system                 metrics-server-7c4574785-kkskp                       100m (5%)     0 (0%)      200Mi (2%)       400Mi (5%)     49d
  postgres                    rideshare-postgres-cluster-1                         0 (0%)        0 (0%)      0 (0%)           0 (0%)         41d
  postgres                    rideshare-postgres-cluster-3                         0 (0%)        0 (0%)      0 (0%)           0 (0%)         41d
  redis                       rideshare-redis-cluster-follower-0                   0 (0%)        0 (0%)      0 (0%)           0 (0%)         41d
  redis                       rideshare-redis-cluster-follower-2                   0 (0%)        0 (0%)      0 (0%)           0 (0%)         41d
  redis                       rideshare-redis-cluster-leader-0                     0 (0%)        0 (0%)      0 (0%)           0 (0%)         41d
  redis                       rideshare-redis-cluster-leader-2                     0 (0%)        0 (0%)      0 (0%)           0 (0%)         41d
  rideshare                   driver-service-6477687469-pwctn                      100m (5%)     500m (25%)  256Mi (3%)       512Mi (7%)     6d7h
  rideshare                   frontend-694857c677-th7k8                            100m (5%)     500m (25%)  256Mi (3%)       512Mi (7%)     3d6h
  rideshare                   matching-service-59f548c68-kf9ns                     100m (5%)     500m (25%)  256Mi (3%)       512Mi (7%)     6d7h
  rideshare                   trip-service-84566b556d-gr8dg                        100m (5%)     500m (25%)  256Mi (3%)       512Mi (7%)     6d7h
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests      Limits
  --------           --------      ------
  cpu                1040m (53%)   2100m (108%)
  memory             2300Mi (32%)  5020Mi (70%)
  ephemeral-storage  0 (0%)        0 (0%)
  hugepages-1Gi      0 (0%)        0 (0%)
  hugepages-2Mi      0 (0%)        0 (0%)
```

