# EKS Clusters
```text
$ eksctl get cluster

NAME				REGION		EKSCTL CREATED
lukman-rideshare-cluster	us-east-2	True
```

# Nodegroups
```text
$ eksctl get nodegroup --cluster lukman-rideshare-cluster

CLUSTER				NODEGROUP	STATUS	CREATED			MIN SIZE	MAX SIZE	DESIRED CAPACITY	INSTANCE TYPE	IMAGE ID		ASG NAME							TYPE
lukman-rideshare-cluster	general-purpose	ACTIVE	2026-06-10T14:49:32Z	2		6		2			t3.large	AL2023_x86_64_STANDARD	eks-general-purpose-9ccf5901-42f9-eba8-225c-5021d2f8fdcc	managed
```

# IAM Service Accounts
```text
$ eksctl get iamserviceaccount --cluster lukman-rideshare-cluster

NAMESPACE	NAME			ROLE ARN
cert-manager	cert-manager		arn:aws:iam::495331822130:role/eksctl-lukman-rideshare-cluster-addon-iamserv-Role1-wVo91RJRjyLP
kube-system	cluster-autoscaler-sa	arn:aws:iam::495331822130:role/eksctl-lukman-rideshare-cluster-addon-iamserv-Role1-Vewfyzt3IUNh
```

# Describe EKS Cluster
```text
$ aws eks describe-cluster --name lukman-rideshare-cluster --region us-east-2

cluster:
  accessConfig:
    authenticationMode: API_AND_CONFIG_MAP
  arn: arn:aws:eks:us-east-2:495331822130:cluster/lukman-rideshare-cluster
  certificateAuthority:
    data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJYzhTQmlRNnRSUWN3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TmpBMk1UQXhORE0yTkRCYUZ3MHpOakEyTURjeE5EUXhOREJhTUJVeApFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLCkFvSUJBUUM0bW1LTHdkVHEyQWUrazd3U0ZyVkFhMTRGV0VKanhKY090WThzVHp2YXpEOHZGQi8wa1hZZCtyRUQKQXNpaEZkR055Tng4R2VBaGRZVGlyRWhoSWdkbTBvcDltSWdGQzU1aERKUzIxMktkL3lENWVaUXdQT2RMZ1c0SAo0VnJvcHo1Uis5NWxBT2RoYjNvaXNHRHExcll3RFlhdGNyV1U0ZHdqcUR1aEQ2ZjRQeE9GT05vc3I3cUJ6Y21WClNpbmFZWmYzZmpEVkczZkRrWEtXdnJmVy94MUxHT1BPbjdhckxuNURFcit6eEl6MHJjdm9SZVRHQ3dNU09CbUEKcXcvQ3ZvY01KaWRBTzdubE44Sks4Zlp2bStGd2lMWEFJcFMwNml4ODNaQ2JRWUZ4Nzk2ZU9jZkNPT0RsVzU1cgpiRWw0T25tUCs5UkMwQ1Y3M0JFYXB6UnhFd2dIQWdNQkFBR2pXVEJYTUE0R0ExVWREd0VCL3dRRUF3SUNwREFQCkJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJTbHNmZjdCVUxWUVhQZERqVGV1QkMvYWRrUENqQVYKQmdOVkhSRUVEakFNZ2dwcmRXSmxjbTVsZEdWek1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRQjhpSmNBcGNpQwpEWXFyMVVVTDJnNUxKcmN1QURteXVQSHBsTE1jZGtXMXZ6eDRPUDIzUnlLWllTYmIrVEdnQjYvSXp6WGJ5MzNoCmN1T015TEFmZUI1cVJNbWFIbWR3bzdXVHNDa3puNGN2eDV3eHI2VTFnYXFxR2hRR2t6d2h3dG4vZHhueFA2TlgKSytCS0kzRzdiQUtjWUtVYjhJL1RKQ01Yc2MrSVhKQ1VTYTRVaTdSaW9yeHc1OGNETmczZHpaaHVpNGNqUTl4VAp2clZzRUZWaXd4Q3krRkVzWHNlM1JqR21XKzNtbGhzSE5QWFJNVHBWVWdwSlhra2MrQ2x4a0ZkZUtlRCtqRGdjCjArOVNEK2xCU21zVnlaUmw5S2VQQU5wdUQreENJclBjeTlxb1d1d2FpOWVmLzc2dEF1bzJ3QVEzck1xMll3Q1UKdVNWZ3hmU3BXSkY0Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K
  controlPlaneScalingConfig:
    tier: standard
  createdAt: '2026-06-10T15:37:29.184000+01:00'
  deletionProtection: false
  endpoint: https://E3337844267F066CEF7C59134EDA4AA4.gr7.us-east-2.eks.amazonaws.com
  identity:
    oidc:
      issuer: https://oidc.eks.us-east-2.amazonaws.com/id/E3337844267F066CEF7C59134EDA4AA4
  kubernetesNetworkConfig:
    elasticLoadBalancing:
      enabled: false
    ipFamily: ipv4
    serviceIpv4Cidr: 10.100.0.0/16
  logging:
    clusterLogging:
    - enabled: false
      types:
      - api
      - audit
      - authenticator
      - controllerManager
      - scheduler
  name: lukman-rideshare-cluster
  platformVersion: eks.27
  resourcesVpcConfig:
    clusterSecurityGroupId: sg-0460333024618a85e
    endpointPrivateAccess: false
    endpointPublicAccess: true
    publicAccessCidrs:
    - 0.0.0.0/0
    securityGroupIds:
    - sg-0b5229dc17dfe6ae6
    subnetIds:
    - subnet-011393d89fe754ce3
    - subnet-08285daf0df812967
    - subnet-0b2a48a1a8aec86ea
    - subnet-0739923c2ef346981
    - subnet-0028bdf17dc2d52fa
    - subnet-031f5f7e7f3d5e917
    vpcId: vpc-0945eaabae33280eb
  roleArn: arn:aws:iam::495331822130:role/eksctl-lukman-rideshare-cluster-cluster-ServiceRole-ZL8HsYrM5ysD
  status: ACTIVE
  tags:
    Name: eksctl-lukman-rideshare-cluster-cluster/ControlPlane
    alpha.eksctl.io/cluster-name: lukman-rideshare-cluster
    alpha.eksctl.io/cluster-oidc-enabled: 'true'
    alpha.eksctl.io/eksctl-version: 0.226.0
    aws:cloudformation:logical-id: ControlPlane
    aws:cloudformation:stack-id: arn:aws:cloudformation:us-east-2:495331822130:stack/eksctl-lukman-rideshare-cluster-cluster/d857f580-64d9-11f1-80f6-02f4271ee21d
    aws:cloudformation:stack-name: eksctl-lukman-rideshare-cluster-cluster
    eksctl.cluster.k8s.io/v1alpha1/cluster-name: lukman-rideshare-cluster
  upgradePolicy:
    supportType: EXTENDED
  version: '1.34'
```

# Load Balancers
```text
$ aws elbv2 describe-load-balancers

LoadBalancers:
- AvailabilityZones:
  - LoadBalancerAddresses: []
    SubnetId: subnet-08285daf0df812967
    ZoneName: us-east-2c
  - LoadBalancerAddresses: []
    SubnetId: subnet-011393d89fe754ce3
    ZoneName: us-east-2a
  - LoadBalancerAddresses: []
    SubnetId: subnet-0b2a48a1a8aec86ea
    ZoneName: us-east-2b
  CanonicalHostedZoneId: ZLMOA37VPKANP
  CreatedTime: '2026-06-11T01:26:25.120000+00:00'
  DNSName: af4d02018fcc84e7982beb4837cd8ba1-cf864548dc4bc09f.elb.us-east-2.amazonaws.com
  EnablePrefixForIpv6SourceNat: off
  IpAddressType: ipv4
  LoadBalancerArn: arn:aws:elasticloadbalancing:us-east-2:495331822130:loadbalancer/net/af4d02018fcc84e7982beb4837cd8ba1/cf864548dc4bc09f
  LoadBalancerName: af4d02018fcc84e7982beb4837cd8ba1
  Scheme: internet-facing
  State:
    Code: active
  Type: network
  VpcId: vpc-0945eaabae33280eb
```

# Target Groups
```text
$ aws elbv2 describe-target-groups

TargetGroups:
- HealthCheckEnabled: true
  HealthCheckIntervalSeconds: 10
  HealthCheckPath: /healthz
  HealthCheckPort: '32247'
  HealthCheckProtocol: HTTP
  HealthCheckTimeoutSeconds: 6
  HealthyThresholdCount: 2
  IpAddressType: ipv4
  LoadBalancerArns:
  - arn:aws:elasticloadbalancing:us-east-2:495331822130:loadbalancer/net/af4d02018fcc84e7982beb4837cd8ba1/cf864548dc4bc09f
  Matcher:
    HttpCode: 200-399
  Port: 31267
  Protocol: TCP
  TargetGroupArn: arn:aws:elasticloadbalancing:us-east-2:495331822130:targetgroup/k8s-ingressn-ingressn-2b549c9c25/b38db8621d2e7462
  TargetGroupName: k8s-ingressn-ingressn-2b549c9c25
  TargetType: instance
  UnhealthyThresholdCount: 2
  VpcId: vpc-0945eaabae33280eb
- HealthCheckEnabled: true
  HealthCheckIntervalSeconds: 10
  HealthCheckPath: /healthz
  HealthCheckPort: '32247'
  HealthCheckProtocol: HTTP
  HealthCheckTimeoutSeconds: 6
  HealthyThresholdCount: 2
  IpAddressType: ipv4
  LoadBalancerArns:
  - arn:aws:elasticloadbalancing:us-east-2:495331822130:loadbalancer/net/af4d02018fcc84e7982beb4837cd8ba1/cf864548dc4bc09f
  Matcher:
    HttpCode: 200-399
  Port: 31513
  Protocol: TCP
  TargetGroupArn: arn:aws:elasticloadbalancing:us-east-2:495331822130:targetgroup/k8s-ingressn-ingressn-9885d5c28e/6ec396d3497b46c2
  TargetGroupName: k8s-ingressn-ingressn-9885d5c28e
  TargetType: instance
  UnhealthyThresholdCount: 2
  VpcId: vpc-0945eaabae33280eb
```

# Hosted Zones
```text
$ aws route53 list-hosted-zones

HostedZones:
- CallerReference: c4243e6f-15b3-4063-9c0e-56c8824fa806
  Config:
    Comment: ''
    PrivateZone: false
  Id: /hostedzone/Z0650034157IGLOIJB87E
  Name: lukmonadeokun.com.
  ResourceRecordSetCount: 5
```

# Repositories
```text
$ aws ecr describe-repositories

repositories:
- createdAt: '2026-06-20T09:51:29.656000+01:00'
  encryptionConfiguration:
    encryptionType: AES256
  imageScanningConfiguration:
    scanOnPush: false
  imageTagMutability: MUTABLE
  registryId: '495331822130'
  repositoryArn: arn:aws:ecr:us-east-2:495331822130:repository/lukman-rideshare-driver-service
  repositoryName: lukman-rideshare-driver-service
  repositoryUri: 495331822130.dkr.ecr.us-east-2.amazonaws.com/lukman-rideshare-driver-service
- createdAt: '2026-06-20T09:51:48.307000+01:00'
  encryptionConfiguration:
    encryptionType: AES256
  imageScanningConfiguration:
    scanOnPush: false
  imageTagMutability: MUTABLE
  registryId: '495331822130'
  repositoryArn: arn:aws:ecr:us-east-2:495331822130:repository/lukman-rideshare-rider-service
  repositoryName: lukman-rideshare-rider-service
  repositoryUri: 495331822130.dkr.ecr.us-east-2.amazonaws.com/lukman-rideshare-rider-service
- createdAt: '2026-06-20T09:51:52.165000+01:00'
  encryptionConfiguration:
    encryptionType: AES256
  imageScanningConfiguration:
    scanOnPush: false
  imageTagMutability: MUTABLE
  registryId: '495331822130'
  repositoryArn: arn:aws:ecr:us-east-2:495331822130:repository/lukman-rideshare-trip-service
  repositoryName: lukman-rideshare-trip-service
  repositoryUri: 495331822130.dkr.ecr.us-east-2.amazonaws.com/lukman-rideshare-trip-service
- createdAt: '2026-06-20T09:51:56.466000+01:00'
  encryptionConfiguration:
    encryptionType: AES256
  imageScanningConfiguration:
    scanOnPush: false
  imageTagMutability: MUTABLE
  registryId: '495331822130'
  repositoryArn: arn:aws:ecr:us-east-2:495331822130:repository/lukman-rideshare-email-service
  repositoryName: lukman-rideshare-email-service
  repositoryUri: 495331822130.dkr.ecr.us-east-2.amazonaws.com/lukman-rideshare-email-service
- createdAt: '2026-06-20T09:52:00.427000+01:00'
  encryptionConfiguration:
    encryptionType: AES256
  imageScanningConfiguration:
    scanOnPush: false
  imageTagMutability: MUTABLE
  registryId: '495331822130'
  repositoryArn: arn:aws:ecr:us-east-2:495331822130:repository/lukman-rideshare-frontend
  repositoryName: lukman-rideshare-frontend
  repositoryUri: 495331822130.dkr.ecr.us-east-2.amazonaws.com/lukman-rideshare-frontend
- createdAt: '2026-06-20T09:52:04.544000+01:00'
  encryptionConfiguration:
    encryptionType: AES256
  imageScanningConfiguration:
    scanOnPush: false
  imageTagMutability: MUTABLE
  registryId: '495331822130'
  repositoryArn: arn:aws:ecr:us-east-2:495331822130:repository/lukman-rideshare-matching-service
  repositoryName: lukman-rideshare-matching-service
  repositoryUri: 495331822130.dkr.ecr.us-east-2.amazonaws.com/lukman-rideshare-matching-service
```

# Secrets Manager
```text
$ aws secretsmanager list-secrets

SecretList:
- ARN: arn:aws:secretsmanager:us-east-2:495331822130:secret:lukman-rideshare-prod-no9OH1
  CreatedDate: '2026-06-13T17:28:28.851000+01:00'
  LastChangedDate: '2026-07-18T19:55:53.040000+01:00'
  Name: lukman-rideshare-prod
  PrimaryRegion: us-east-2
  SecretVersionsToStages:
    cd980f70-3993-44eb-80c2-f62495f0032c:
    - AWSCURRENT
- ARN: arn:aws:secretsmanager:us-east-2:495331822130:secret:postgres-secret-jK9m8O
  CreatedDate: '2026-06-16T06:54:50.580000+01:00'
  Description: Access to postgres database
  LastAccessedDate: '2026-07-30T01:00:00+01:00'
  LastChangedDate: '2026-07-18T19:54:54.636000+01:00'
  Name: postgres-secret
  PrimaryRegion: us-east-2
  SecretVersionsToStages:
    0434399c-35c5-41ad-95b8-2eb19605fccb:
    - AWSPREVIOUS
    d71550a1-52b1-42af-a5e8-719ff2c06de2:
    - AWSCURRENT
  Tags: []
- ARN: arn:aws:secretsmanager:us-east-2:495331822130:secret:redis-secret-IWIMyQ
  CreatedDate: '2026-06-18T09:01:01.444000+01:00'
  Description: My redis secret
  LastAccessedDate: '2026-07-30T01:00:00+01:00'
  LastChangedDate: '2026-07-18T19:54:28.757000+01:00'
  Name: redis-secret
  PrimaryRegion: us-east-2
  SecretVersionsToStages:
    2c1d99a0-052e-492d-ad27-31f082d28b82:
    - AWSCURRENT
  Tags: []
- ARN: arn:aws:secretsmanager:us-east-2:495331822130:secret:rideshare/driver-db-secret-XGDajE
  CreatedDate: '2026-06-18T17:33:25.447000+01:00'
  LastAccessedDate: '2026-07-30T01:00:00+01:00'
  LastChangedDate: '2026-07-18T19:53:59.753000+01:00'
  Name: rideshare/driver-db-secret
  PrimaryRegion: us-east-2
  SecretVersionsToStages:
    3e0237e1-2909-4e67-92d7-28336c3ec984:
    - AWSPREVIOUS
    9276062a-e8ff-4e78-81a4-1edbfdea9e27:
    - AWSCURRENT
  Tags: []
- ARN: arn:aws:secretsmanager:us-east-2:495331822130:secret:rideshare/redis-secret-p17ifk
  CreatedDate: '2026-06-18T17:37:00.778000+01:00'
  LastAccessedDate: '2026-07-30T01:00:00+01:00'
  LastChangedDate: '2026-07-18T19:53:26.359000+01:00'
  Name: rideshare/redis-secret
  PrimaryRegion: us-east-2
  SecretVersionsToStages:
    7a9d94ec-99db-473e-bb1b-2d54512edca2:
    - AWSCURRENT
    c8973873-3c56-4b83-928f-b270e5296183:
    - AWSPREVIOUS
  Tags: []
- ARN: arn:aws:secretsmanager:us-east-2:495331822130:secret:rideshare/driver-service-secret-kJEbYh
  CreatedDate: '2026-06-18T17:54:03.235000+01:00'
  LastAccessedDate: '2026-07-30T01:00:00+01:00'
  LastChangedDate: '2026-07-18T19:52:57.587000+01:00'
  Name: rideshare/driver-service-secret
  PrimaryRegion: us-east-2
  SecretVersionsToStages:
    b88a85ef-2bba-4509-ac93-4ab81feea6a1:
    - AWSCURRENT
  Tags: []
- ARN: arn:aws:secretsmanager:us-east-2:495331822130:secret:rideshare/email-service-secret-IrDsHU
  CreatedDate: '2026-06-18T17:58:11.811000+01:00'
  LastAccessedDate: '2026-07-30T01:00:00+01:00'
  LastChangedDate: '2026-07-18T19:52:14.928000+01:00'
  Name: rideshare/email-service-secret
  PrimaryRegion: us-east-2
  SecretVersionsToStages:
    3dd32dad-cdeb-4450-ad3d-1b18d80fe687:
    - AWSPREVIOUS
    b348fe65-a61f-47f2-9e8b-9bf323f7873c:
    - AWSCURRENT
  Tags: []
- ARN: arn:aws:secretsmanager:us-east-2:495331822130:secret:rideshare/frontend-secret-QEh7kM
  CreatedDate: '2026-06-18T18:39:18.178000+01:00'
  LastAccessedDate: '2026-07-30T01:00:00+01:00'
  LastChangedDate: '2026-07-18T19:51:48.566000+01:00'
  Name: rideshare/frontend-secret
  PrimaryRegion: us-east-2
  SecretVersionsToStages:
    7d8e9437-cd5c-41c0-b1fc-7d339424e4de:
    - AWSCURRENT
  Tags: []
- ARN: arn:aws:secretsmanager:us-east-2:495331822130:secret:rideshare/postgresql-secret-tNJHQO
  CreatedDate: '2026-06-18T18:46:18.682000+01:00'
  LastAccessedDate: '2026-07-30T01:00:00+01:00'
  LastChangedDate: '2026-07-18T19:51:20.845000+01:00'
  Name: rideshare/postgresql-secret
  PrimaryRegion: us-east-2
  SecretVersionsToStages:
    56860252-c42b-4d4f-905d-416f4493f959:
    - AWSCURRENT
  Tags: []
- ARN: arn:aws:secretsmanager:us-east-2:495331822130:secret:rideshare/rider-service-secret-G8fduK
  CreatedDate: '2026-06-18T21:14:37.233000+01:00'
  LastAccessedDate: '2026-07-30T01:00:00+01:00'
  LastChangedDate: '2026-07-18T19:50:45.479000+01:00'
  Name: rideshare/rider-service-secret
  PrimaryRegion: us-east-2
  SecretVersionsToStages:
    64f5d1ba-8e78-473f-a590-ef9bcb3730a5:
    - AWSCURRENT
  Tags: []
- ARN: arn:aws:secretsmanager:us-east-2:495331822130:secret:rideshare/rider-db-secret-juzXXJ
  CreatedDate: '2026-06-18T21:16:24.684000+01:00'
  LastAccessedDate: '2026-07-30T01:00:00+01:00'
  LastChangedDate: '2026-07-18T19:50:07.580000+01:00'
  Name: rideshare/rider-db-secret
  PrimaryRegion: us-east-2
  SecretVersionsToStages:
    5ce30884-461a-4952-997f-d2405fd8cd87:
    - AWSPREVIOUS
    f64a612b-a5eb-4e94-984b-9ff2110fcb5a:
    - AWSCURRENT
  Tags: []
- ARN: arn:aws:secretsmanager:us-east-2:495331822130:secret:rideshare/trip-db-secret-YUr8w9
  CreatedDate: '2026-06-18T21:19:33+01:00'
  LastAccessedDate: '2026-07-30T01:00:00+01:00'
  LastChangedDate: '2026-07-18T19:49:19.729000+01:00'
  Name: rideshare/trip-db-secret
  PrimaryRegion: us-east-2
  SecretVersionsToStages:
    3c736656-6353-4478-88d0-b1d68b468d8f:
    - AWSCURRENT
    a5389c55-df20-48be-a175-cab2dd29c6da:
    - AWSPREVIOUS
  Tags: []
- ARN: arn:aws:secretsmanager:us-east-2:495331822130:secret:rideshare/trip-service-secret-SrNCfp
  CreatedDate: '2026-06-18T21:29:21.140000+01:00'
  LastAccessedDate: '2026-07-30T01:00:00+01:00'
  LastChangedDate: '2026-07-18T19:48:51.915000+01:00'
  Name: rideshare/trip-service-secret
  PrimaryRegion: us-east-2
  SecretVersionsToStages:
    41157197-d823-4d8c-986b-99a24cea797f:
    - AWSCURRENT
  Tags: []
- ARN: arn:aws:secretsmanager:us-east-2:495331822130:secret:rideshare/postgres-credentials-y83EE5
  CreatedDate: '2026-06-20T08:36:36.731000+01:00'
  LastAccessedDate: '2026-07-30T01:00:00+01:00'
  LastChangedDate: '2026-07-18T19:48:20.396000+01:00'
  Name: rideshare/postgres-credentials
  PrimaryRegion: us-east-2
  SecretVersionsToStages:
    0a26cbc3-9d0a-4739-841e-925ab6c30954:
    - AWSCURRENT
  Tags: []
- ARN: arn:aws:secretsmanager:us-east-2:495331822130:secret:rideshare/redis-credentials-P9NT7D
  CreatedDate: '2026-06-20T08:38:57.503000+01:00'
  LastAccessedDate: '2026-07-30T01:00:00+01:00'
  LastChangedDate: '2026-07-18T19:47:28.513000+01:00'
  Name: rideshare/redis-credentials
  PrimaryRegion: us-east-2
  SecretVersionsToStages:
    833b7fdc-1498-4eac-8558-f458b9d82565:
    - AWSCURRENT
  Tags: []
- ARN: arn:aws:secretsmanager:us-east-2:495331822130:secret:azure-email-creds-x8HeND
  CreatedDate: '2026-06-22T11:05:33.414000+01:00'
  LastAccessedDate: '2026-06-22T01:00:00+01:00'
  LastChangedDate: '2026-07-18T19:44:52.290000+01:00'
  Name: azure-email-creds
  PrimaryRegion: us-east-2
  SecretVersionsToStages:
    7d14bbe2-cd63-4a5c-95fe-ffc147c6c00b:
    - AWSCURRENT
  Tags: []
```

# OIDC Issuer
```text
$ aws eks describe-cluster --name lukman-rideshare-cluster --region us-east-2 --query cluster.identity.oidc.issuer

"https://oidc.eks.us-east-2.amazonaws.com/id/E3337844267F066CEF7C59134EDA4AA4"
```

# VPC Configuration
```text
$ aws eks describe-cluster --name lukman-rideshare-cluster --region us-east-2 --query cluster.resourcesVpcConfig

clusterSecurityGroupId: sg-0460333024618a85e
endpointPrivateAccess: false
endpointPublicAccess: true
publicAccessCidrs:
- 0.0.0.0/0
securityGroupIds:
- sg-0b5229dc17dfe6ae6
subnetIds:
- subnet-011393d89fe754ce3
- subnet-08285daf0df812967
- subnet-0b2a48a1a8aec86ea
- subnet-0739923c2ef346981
- subnet-0028bdf17dc2d52fa
- subnet-031f5f7e7f3d5e917
vpcId: vpc-0945eaabae33280eb
```

# Subnets
```text
$ aws ec2 describe-subnets

Subnets:
- AssignIpv6AddressOnCreation: false
  AvailabilityZone: us-east-2c
  AvailabilityZoneId: use2-az3
  AvailableIpAddressCount: 8150
  BlockPublicAccessStates:
    InternetGatewayBlockMode: off
  CidrBlock: 192.168.160.0/19
  DefaultForAz: false
  EnableDns64: false
  Ipv6CidrBlockAssociationSet: []
  Ipv6Native: false
  MapCustomerOwnedIpOnLaunch: false
  MapPublicIpOnLaunch: false
  OwnerId: '495331822130'
  PrivateDnsNameOptionsOnLaunch:
    EnableResourceNameDnsAAAARecord: false
    EnableResourceNameDnsARecord: false
    HostnameType: ip-name
  State: available
  SubnetArn: arn:aws:ec2:us-east-2:495331822130:subnet/subnet-031f5f7e7f3d5e917
  SubnetId: subnet-031f5f7e7f3d5e917
  Tags:
  - Key: alpha.eksctl.io/cluster-oidc-enabled
    Value: 'true'
  - Key: aws:cloudformation:stack-name
    Value: eksctl-lukman-rideshare-cluster-cluster
  - Key: aws:cloudformation:stack-id
    Value: arn:aws:cloudformation:us-east-2:495331822130:stack/eksctl-lukman-rideshare-cluster-cluster/d857f580-64d9-11f1-80f6-02f4271ee21d
  - Key: alpha.eksctl.io/cluster-name
    Value: lukman-rideshare-cluster
  - Key: alpha.eksctl.io/eksctl-version
    Value: 0.226.0
  - Key: kubernetes.io/role/internal-elb
    Value: '1'
  - Key: Name
    Value: eksctl-lukman-rideshare-cluster-cluster/SubnetPrivateUSEAST2C
  - Key: aws:cloudformation:logical-id
    Value: SubnetPrivateUSEAST2C
  - Key: eksctl.cluster.k8s.io/v1alpha1/cluster-name
    Value: lukman-rideshare-cluster
  VpcId: vpc-0945eaabae33280eb
- AssignIpv6AddressOnCreation: false
  AvailabilityZone: us-east-2a
  AvailabilityZoneId: use2-az1
  AvailableIpAddressCount: 4091
  BlockPublicAccessStates:
    InternetGatewayBlockMode: off
  CidrBlock: 172.31.0.0/20
  DefaultForAz: true
  EnableDns64: false
  Ipv6CidrBlockAssociationSet: []
  Ipv6Native: false
  MapCustomerOwnedIpOnLaunch: false
  MapPublicIpOnLaunch: true
  OwnerId: '495331822130'
  PrivateDnsNameOptionsOnLaunch:
    EnableResourceNameDnsAAAARecord: false
    EnableResourceNameDnsARecord: false
    HostnameType: ip-name
  State: available
  SubnetArn: arn:aws:ec2:us-east-2:495331822130:subnet/subnet-0d3191f39f94b6f2a
  SubnetId: subnet-0d3191f39f94b6f2a
  VpcId: vpc-0b8bb753cea5f9c47
- AssignIpv6AddressOnCreation: false
  AvailabilityZone: us-east-2c
  AvailabilityZoneId: use2-az3
  AvailableIpAddressCount: 4091
  BlockPublicAccessStates:
    InternetGatewayBlockMode: off
  CidrBlock: 172.31.32.0/20
  DefaultForAz: true
  EnableDns64: false
  Ipv6CidrBlockAssociationSet: []
  Ipv6Native: false
  MapCustomerOwnedIpOnLaunch: false
  MapPublicIpOnLaunch: true
  OwnerId: '495331822130'
  PrivateDnsNameOptionsOnLaunch:
    EnableResourceNameDnsAAAARecord: false
    EnableResourceNameDnsARecord: false
    HostnameType: ip-name
  State: available
  SubnetArn: arn:aws:ec2:us-east-2:495331822130:subnet/subnet-0ad9d3b1c2bd754c3
  SubnetId: subnet-0ad9d3b1c2bd754c3
  VpcId: vpc-0b8bb753cea5f9c47
- AssignIpv6AddressOnCreation: false
  AvailabilityZone: us-east-2a
  AvailabilityZoneId: use2-az1
  AvailableIpAddressCount: 8150
  BlockPublicAccessStates:
    InternetGatewayBlockMode: off
  CidrBlock: 192.168.128.0/19
  DefaultForAz: false
  EnableDns64: false
  Ipv6CidrBlockAssociationSet: []
  Ipv6Native: false
  MapCustomerOwnedIpOnLaunch: false
  MapPublicIpOnLaunch: false
  OwnerId: '495331822130'
  PrivateDnsNameOptionsOnLaunch:
    EnableResourceNameDnsAAAARecord: false
    EnableResourceNameDnsARecord: false
    HostnameType: ip-name
  State: available
  SubnetArn: arn:aws:ec2:us-east-2:495331822130:subnet/subnet-0028bdf17dc2d52fa
  SubnetId: subnet-0028bdf17dc2d52fa
  Tags:
  - Key: aws:cloudformation:stack-name
    Value: eksctl-lukman-rideshare-cluster-cluster
  - Key: Name
    Value: eksctl-lukman-rideshare-cluster-cluster/SubnetPrivateUSEAST2A
  - Key: alpha.eksctl.io/eksctl-version
    Value: 0.226.0
  - Key: eksctl.cluster.k8s.io/v1alpha1/cluster-name
    Value: lukman-rideshare-cluster
  - Key: alpha.eksctl.io/cluster-name
    Value: lukman-rideshare-cluster
  - Key: kubernetes.io/role/internal-elb
    Value: '1'
  - Key: aws:cloudformation:logical-id
    Value: SubnetPrivateUSEAST2A
  - Key: aws:cloudformation:stack-id
    Value: arn:aws:cloudformation:us-east-2:495331822130:stack/eksctl-lukman-rideshare-cluster-cluster/d857f580-64d9-11f1-80f6-02f4271ee21d
  - Key: alpha.eksctl.io/cluster-oidc-enabled
    Value: 'true'
  VpcId: vpc-0945eaabae33280eb
- AssignIpv6AddressOnCreation: false
  AvailabilityZone: us-east-2c
  AvailabilityZoneId: use2-az3
  AvailableIpAddressCount: 8186
  BlockPublicAccessStates:
    InternetGatewayBlockMode: off
  CidrBlock: 192.168.64.0/19
  DefaultForAz: false
  EnableDns64: false
  Ipv6CidrBlockAssociationSet: []
  Ipv6Native: false
  MapCustomerOwnedIpOnLaunch: false
  MapPublicIpOnLaunch: true
  OwnerId: '495331822130'
  PrivateDnsNameOptionsOnLaunch:
    EnableResourceNameDnsAAAARecord: false
    EnableResourceNameDnsARecord: false
    HostnameType: ip-name
  State: available
  SubnetArn: arn:aws:ec2:us-east-2:495331822130:subnet/subnet-08285daf0df812967
  SubnetId: subnet-08285daf0df812967
  Tags:
  - Key: kubernetes.io/role/elb
    Value: '1'
  - Key: aws:cloudformation:logical-id
    Value: SubnetPublicUSEAST2C
  - Key: aws:cloudformation:stack-id
    Value: arn:aws:cloudformation:us-east-2:495331822130:stack/eksctl-lukman-rideshare-cluster-cluster/d857f580-64d9-11f1-80f6-02f4271ee21d
  - Key: alpha.eksctl.io/cluster-oidc-enabled
    Value: 'true'
  - Key: Name
    Value: eksctl-lukman-rideshare-cluster-cluster/SubnetPublicUSEAST2C
  - Key: alpha.eksctl.io/eksctl-version
    Value: 0.226.0
  - Key: eksctl.cluster.k8s.io/v1alpha1/cluster-name
    Value: lukman-rideshare-cluster
  - Key: aws:cloudformation:stack-name
    Value: eksctl-lukman-rideshare-cluster-cluster
  - Key: alpha.eksctl.io/cluster-name
    Value: lukman-rideshare-cluster
  VpcId: vpc-0945eaabae33280eb
- AssignIpv6AddressOnCreation: false
  AvailabilityZone: us-east-2b
  AvailabilityZoneId: use2-az2
  AvailableIpAddressCount: 4091
  BlockPublicAccessStates:
    InternetGatewayBlockMode: off
  CidrBlock: 172.31.16.0/20
  DefaultForAz: true
  EnableDns64: false
  Ipv6CidrBlockAssociationSet: []
  Ipv6Native: false
  MapCustomerOwnedIpOnLaunch: false
  MapPublicIpOnLaunch: true
  OwnerId: '495331822130'
  PrivateDnsNameOptionsOnLaunch:
    EnableResourceNameDnsAAAARecord: false
    EnableResourceNameDnsARecord: false
    HostnameType: ip-name
  State: available
  SubnetArn: arn:aws:ec2:us-east-2:495331822130:subnet/subnet-0edc59e6c44c053c0
  SubnetId: subnet-0edc59e6c44c053c0
  VpcId: vpc-0b8bb753cea5f9c47
- AssignIpv6AddressOnCreation: false
  AvailabilityZone: us-east-2a
  AvailabilityZoneId: use2-az1
  AvailableIpAddressCount: 8186
  BlockPublicAccessStates:
    InternetGatewayBlockMode: off
  CidrBlock: 192.168.32.0/19
  DefaultForAz: false
  EnableDns64: false
  Ipv6CidrBlockAssociationSet: []
  Ipv6Native: false
  MapCustomerOwnedIpOnLaunch: false
  MapPublicIpOnLaunch: true
  OwnerId: '495331822130'
  PrivateDnsNameOptionsOnLaunch:
    EnableResourceNameDnsAAAARecord: false
    EnableResourceNameDnsARecord: false
    HostnameType: ip-name
  State: available
  SubnetArn: arn:aws:ec2:us-east-2:495331822130:subnet/subnet-011393d89fe754ce3
  SubnetId: subnet-011393d89fe754ce3
  Tags:
  - Key: alpha.eksctl.io/cluster-oidc-enabled
    Value: 'true'
  - Key: aws:cloudformation:stack-name
    Value: eksctl-lukman-rideshare-cluster-cluster
  - Key: eksctl.cluster.k8s.io/v1alpha1/cluster-name
    Value: lukman-rideshare-cluster
  - Key: alpha.eksctl.io/cluster-name
    Value: lukman-rideshare-cluster
  - Key: aws:cloudformation:logical-id
    Value: SubnetPublicUSEAST2A
  - Key: alpha.eksctl.io/eksctl-version
    Value: 0.226.0
  - Key: Name
    Value: eksctl-lukman-rideshare-cluster-cluster/SubnetPublicUSEAST2A
  - Key: kubernetes.io/role/elb
    Value: '1'
  - Key: aws:cloudformation:stack-id
    Value: arn:aws:cloudformation:us-east-2:495331822130:stack/eksctl-lukman-rideshare-cluster-cluster/d857f580-64d9-11f1-80f6-02f4271ee21d
  VpcId: vpc-0945eaabae33280eb
- AssignIpv6AddressOnCreation: false
  AvailabilityZone: us-east-2b
  AvailabilityZoneId: use2-az2
  AvailableIpAddressCount: 8187
  BlockPublicAccessStates:
    InternetGatewayBlockMode: off
  CidrBlock: 192.168.96.0/19
  DefaultForAz: false
  EnableDns64: false
  Ipv6CidrBlockAssociationSet: []
  Ipv6Native: false
  MapCustomerOwnedIpOnLaunch: false
  MapPublicIpOnLaunch: false
  OwnerId: '495331822130'
  PrivateDnsNameOptionsOnLaunch:
    EnableResourceNameDnsAAAARecord: false
    EnableResourceNameDnsARecord: false
    HostnameType: ip-name
  State: available
  SubnetArn: arn:aws:ec2:us-east-2:495331822130:subnet/subnet-0739923c2ef346981
  SubnetId: subnet-0739923c2ef346981
  Tags:
  - Key: alpha.eksctl.io/eksctl-version
    Value: 0.226.0
  - Key: eksctl.cluster.k8s.io/v1alpha1/cluster-name
    Value: lukman-rideshare-cluster
  - Key: aws:cloudformation:stack-id
    Value: arn:aws:cloudformation:us-east-2:495331822130:stack/eksctl-lukman-rideshare-cluster-cluster/d857f580-64d9-11f1-80f6-02f4271ee21d
  - Key: aws:cloudformation:logical-id
    Value: SubnetPrivateUSEAST2B
  - Key: kubernetes.io/role/internal-elb
    Value: '1'
  - Key: aws:cloudformation:stack-name
    Value: eksctl-lukman-rideshare-cluster-cluster
  - Key: alpha.eksctl.io/cluster-oidc-enabled
    Value: 'true'
  - Key: Name
    Value: eksctl-lukman-rideshare-cluster-cluster/SubnetPrivateUSEAST2B
  - Key: alpha.eksctl.io/cluster-name
    Value: lukman-rideshare-cluster
  VpcId: vpc-0945eaabae33280eb
- AssignIpv6AddressOnCreation: false
  AvailabilityZone: us-east-2b
  AvailabilityZoneId: use2-az2
  AvailableIpAddressCount: 8185
  BlockPublicAccessStates:
    InternetGatewayBlockMode: off
  CidrBlock: 192.168.0.0/19
  DefaultForAz: false
  EnableDns64: false
  Ipv6CidrBlockAssociationSet: []
  Ipv6Native: false
  MapCustomerOwnedIpOnLaunch: false
  MapPublicIpOnLaunch: true
  OwnerId: '495331822130'
  PrivateDnsNameOptionsOnLaunch:
    EnableResourceNameDnsAAAARecord: false
    EnableResourceNameDnsARecord: false
    HostnameType: ip-name
  State: available
  SubnetArn: arn:aws:ec2:us-east-2:495331822130:subnet/subnet-0b2a48a1a8aec86ea
  SubnetId: subnet-0b2a48a1a8aec86ea
  Tags:
  - Key: alpha.eksctl.io/cluster-oidc-enabled
    Value: 'true'
  - Key: aws:cloudformation:stack-id
    Value: arn:aws:cloudformation:us-east-2:495331822130:stack/eksctl-lukman-rideshare-cluster-cluster/d857f580-64d9-11f1-80f6-02f4271ee21d
  - Key: Name
    Value: eksctl-lukman-rideshare-cluster-cluster/SubnetPublicUSEAST2B
  - Key: aws:cloudformation:logical-id
    Value: SubnetPublicUSEAST2B
  - Key: kubernetes.io/role/elb
    Value: '1'
  - Key: eksctl.cluster.k8s.io/v1alpha1/cluster-name
    Value: lukman-rideshare-cluster
  - Key: alpha.eksctl.io/eksctl-version
    Value: 0.226.0
  - Key: aws:cloudformation:stack-name
    Value: eksctl-lukman-rideshare-cluster-cluster
  - Key: alpha.eksctl.io/cluster-name
    Value: lukman-rideshare-cluster
  VpcId: vpc-0945eaabae33280eb
```

# Security Groups
```text
$ aws ec2 describe-security-groups

SecurityGroups:
- Description: Communication between all nodes in the cluster
  GroupId: sg-042b731158aef27da
  GroupName: eksctl-lukman-rideshare-cluster-cluster-ClusterSharedNodeSecurityGroup-d7XZ3Q3BSsi2
  IpPermissions:
  - IpProtocol: '-1'
    IpRanges: []
    Ipv6Ranges: []
    PrefixListIds: []
    UserIdGroupPairs:
    - Description: Allow nodes to communicate with each other (all ports)
      GroupId: sg-042b731158aef27da
      UserId: '495331822130'
    - Description: Allow managed and unmanaged nodes to communicate with each other
        (all ports)
      GroupId: sg-0460333024618a85e
      UserId: '495331822130'
  IpPermissionsEgress:
  - IpProtocol: '-1'
    IpRanges:
    - CidrIp: 0.0.0.0/0
    Ipv6Ranges: []
    PrefixListIds: []
    UserIdGroupPairs: []
  OwnerId: '495331822130'
  SecurityGroupArn: arn:aws:ec2:us-east-2:495331822130:security-group/sg-042b731158aef27da
  Tags:
  - Key: eksctl.cluster.k8s.io/v1alpha1/cluster-name
    Value: lukman-rideshare-cluster
  - Key: alpha.eksctl.io/cluster-name
    Value: lukman-rideshare-cluster
  - Key: Name
    Value: eksctl-lukman-rideshare-cluster-cluster/ClusterSharedNodeSecurityGroup
  - Key: aws:cloudformation:logical-id
    Value: ClusterSharedNodeSecurityGroup
  - Key: aws:cloudformation:stack-name
    Value: eksctl-lukman-rideshare-cluster-cluster
  - Key: alpha.eksctl.io/cluster-oidc-enabled
    Value: 'true'
  - Key: aws:cloudformation:stack-id
    Value: arn:aws:cloudformation:us-east-2:495331822130:stack/eksctl-lukman-rideshare-cluster-cluster/d857f580-64d9-11f1-80f6-02f4271ee21d
  - Key: alpha.eksctl.io/eksctl-version
    Value: 0.226.0
  VpcId: vpc-0945eaabae33280eb
- Description: default VPC security group
  GroupId: sg-02be06bd9cbf15b62
  GroupName: default
  IpPermissions:
  - IpProtocol: '-1'
    IpRanges: []
    Ipv6Ranges: []
    PrefixListIds: []
    UserIdGroupPairs:
    - GroupId: sg-02be06bd9cbf15b62
      UserId: '495331822130'
  IpPermissionsEgress:
  - IpProtocol: '-1'
    IpRanges:
    - CidrIp: 0.0.0.0/0
    Ipv6Ranges: []
    PrefixListIds: []
    UserIdGroupPairs: []
  OwnerId: '495331822130'
  SecurityGroupArn: arn:aws:ec2:us-east-2:495331822130:security-group/sg-02be06bd9cbf15b62
  VpcId: vpc-0945eaabae33280eb
- Description: EKS created security group applied to ENI that is attached to EKS Control
    Plane master nodes, as well as any managed workloads.
  GroupId: sg-0460333024618a85e
  GroupName: eks-cluster-sg-lukman-rideshare-cluster-1775783009
  IpPermissions:
  - IpProtocol: '-1'
    IpRanges: []
    Ipv6Ranges: []
    PrefixListIds: []
    UserIdGroupPairs:
    - Description: Allows EFA traffic, which is not matched by CIDR rules.
      GroupId: sg-0460333024618a85e
      UserId: '495331822130'
    - Description: Allow unmanaged nodes to communicate with control plane (all ports)
      GroupId: sg-042b731158aef27da
      UserId: '495331822130'
  - FromPort: 31267
    IpProtocol: tcp
    IpRanges:
    - CidrIp: 0.0.0.0/0
      Description: kubernetes.io/rule/nlb/client=af4d02018fcc84e7982beb4837cd8ba1
    Ipv6Ranges: []
    PrefixListIds: []
    ToPort: 31267
    UserIdGroupPairs: []
  - FromPort: 3
    IpProtocol: icmp
    IpRanges:
    - CidrIp: 0.0.0.0/0
      Description: kubernetes.io/rule/nlb/mtu
    Ipv6Ranges: []
    PrefixListIds: []
    ToPort: 4
    UserIdGroupPairs: []
  - FromPort: 32247
    IpProtocol: tcp
    IpRanges:
    - CidrIp: 192.168.32.0/19
      Description: kubernetes.io/rule/nlb/health=af4d02018fcc84e7982beb4837cd8ba1
    - CidrIp: 192.168.0.0/19
      Description: kubernetes.io/rule/nlb/health=af4d02018fcc84e7982beb4837cd8ba1
    - CidrIp: 192.168.64.0/19
      Description: kubernetes.io/rule/nlb/health=af4d02018fcc84e7982beb4837cd8ba1
    Ipv6Ranges: []
    PrefixListIds: []
    ToPort: 32247
    UserIdGroupPairs: []
  - FromPort: 31513
    IpProtocol: tcp
    IpRanges:
    - CidrIp: 0.0.0.0/0
      Description: kubernetes.io/rule/nlb/client=af4d02018fcc84e7982beb4837cd8ba1
    Ipv6Ranges: []
    PrefixListIds: []
    ToPort: 31513
    UserIdGroupPairs: []
  IpPermissionsEgress:
  - IpProtocol: '-1'
    IpRanges:
    - CidrIp: 0.0.0.0/0
    Ipv6Ranges: []
    PrefixListIds: []
    UserIdGroupPairs:
    - Description: Allows EFA traffic, which is not matched by CIDR rules.
      GroupId: sg-0460333024618a85e
      UserId: '495331822130'
  OwnerId: '495331822130'
  SecurityGroupArn: arn:aws:ec2:us-east-2:495331822130:security-group/sg-0460333024618a85e
  Tags:
  - Key: aws:eks:cluster-name
    Value: lukman-rideshare-cluster
  - Key: Name
    Value: eks-cluster-sg-lukman-rideshare-cluster-1775783009
  - Key: kubernetes.io/cluster/lukman-rideshare-cluster
    Value: owned
  VpcId: vpc-0945eaabae33280eb
- Description: Communication between the control plane and worker nodegroups
  GroupId: sg-0b5229dc17dfe6ae6
  GroupName: eksctl-lukman-rideshare-cluster-cluster-ControlPlaneSecurityGroup-pTk6Whbkt1xs
  IpPermissions: []
  IpPermissionsEgress:
  - IpProtocol: '-1'
    IpRanges:
    - CidrIp: 0.0.0.0/0
    Ipv6Ranges: []
    PrefixListIds: []
    UserIdGroupPairs: []
  OwnerId: '495331822130'
  SecurityGroupArn: arn:aws:ec2:us-east-2:495331822130:security-group/sg-0b5229dc17dfe6ae6
  Tags:
  - Key: aws:cloudformation:stack-name
    Value: eksctl-lukman-rideshare-cluster-cluster
  - Key: alpha.eksctl.io/cluster-oidc-enabled
    Value: 'true'
  - Key: aws:cloudformation:logical-id
    Value: ControlPlaneSecurityGroup
  - Key: aws:cloudformation:stack-id
    Value: arn:aws:cloudformation:us-east-2:495331822130:stack/eksctl-lukman-rideshare-cluster-cluster/d857f580-64d9-11f1-80f6-02f4271ee21d
  - Key: eksctl.cluster.k8s.io/v1alpha1/cluster-name
    Value: lukman-rideshare-cluster
  - Key: alpha.eksctl.io/cluster-name
    Value: lukman-rideshare-cluster
  - Key: alpha.eksctl.io/eksctl-version
    Value: 0.226.0
  - Key: Name
    Value: eksctl-lukman-rideshare-cluster-cluster/ControlPlaneSecurityGroup
  VpcId: vpc-0945eaabae33280eb
- Description: default VPC security group
  GroupId: sg-0dbe57307038214f6
  GroupName: default
  IpPermissions:
  - IpProtocol: '-1'
    IpRanges: []
    Ipv6Ranges: []
    PrefixListIds: []
    UserIdGroupPairs:
    - GroupId: sg-0dbe57307038214f6
      UserId: '495331822130'
  IpPermissionsEgress:
  - IpProtocol: '-1'
    IpRanges:
    - CidrIp: 0.0.0.0/0
    Ipv6Ranges: []
    PrefixListIds: []
    UserIdGroupPairs: []
  OwnerId: '495331822130'
  SecurityGroupArn: arn:aws:ec2:us-east-2:495331822130:security-group/sg-0dbe57307038214f6
  VpcId: vpc-0b8bb753cea5f9c47
```

