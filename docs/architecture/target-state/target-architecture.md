# Target Architecture

```mermaid
flowchart TB
    Users[RideShare Users]
    DNS[Amazon Route 53<br/>rideshare.lukmonadeokun.com]

    Users --> DNS

    subgraph USE1[Region: us-east-1]
        LB1[AWS Load Balancer]
        ING1[NGINX Ingress]
        EKS1[faahidah-rideshare-cluster]
        APP1[RideShare Microservices]

        LB1 --> ING1
        ING1 --> APP1
        EKS1 --- ING1
        EKS1 --- APP1
    end

    subgraph USE2[Region: us-east-2]
        LB2[AWS Load Balancer]
        ING2[NGINX Ingress]
        EKS2[lukman-rideshare-cluster]
        APP2[RideShare Microservices]

        LB2 --> ING2
        ING2 --> APP2
        EKS2 --- ING2
        EKS2 --- APP2
    end

    DNS --> LB1
    DNS --> LB2

    RDS[(Amazon RDS PostgreSQL)]
    REDIS[(Amazon ElastiCache Redis)]
    SM[AWS Secrets Manager]
    ECR[Amazon ECR]

    APP1 --> RDS
    APP2 --> RDS

    APP1 --> REDIS
    APP2 --> REDIS

    SM --> APP1
    SM --> APP2

    ECR --> EKS1
    ECR --> EKS2