#!/usr/bin/env bash

set +e

CLUSTER_NAME="lukman-rideshare-cluster"
REGION="us-east-2"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
OUTPUT_DIR="assessment-output/$TIMESTAMP"

mkdir -p "$OUTPUT_DIR"

echo "====================================================="
echo "RideShare Platform - Existing Cluster Assessment"
echo "Cluster : $CLUSTER_NAME"
echo "Region  : $REGION"
echo "Output  : $OUTPUT_DIR"
echo "====================================================="

run() {
    FILE=$1
    TITLE=$2
    shift 2

    echo "# $TITLE" >> "$FILE"
    echo '```text' >> "$FILE"

    echo "\$ $*" >> "$FILE"
    echo "" >> "$FILE"

    "$@" >> "$FILE" 2>&1

    echo '```' >> "$FILE"
    echo "" >> "$FILE"
}

###############################################################################
# Cluster
###############################################################################

FILE="$OUTPUT_DIR/cluster.md"

run "$FILE" "Cluster Information" kubectl cluster-info
run "$FILE" "Kubernetes Version" kubectl version
run "$FILE" "Current Context" kubectl config current-context
run "$FILE" "Namespaces" kubectl get ns
run "$FILE" "Nodes" kubectl get nodes -o wide
run "$FILE" "Node Details" kubectl describe nodes

###############################################################################
# Workloads
###############################################################################

FILE="$OUTPUT_DIR/workloads.md"

run "$FILE" "All Resources" kubectl get all -A -o wide
run "$FILE" "Deployments" kubectl get deploy -A -o wide
run "$FILE" "StatefulSets" kubectl get sts -A -o wide
run "$FILE" "DaemonSets" kubectl get ds -A -o wide
run "$FILE" "Jobs" kubectl get jobs -A
run "$FILE" "CronJobs" kubectl get cronjobs -A
run "$FILE" "Horizontal Pod Autoscalers" kubectl get hpa -A
run "$FILE" "Node Resource Usage" kubectl top nodes
run "$FILE" "Pod Resource Usage" kubectl top pods -A

###############################################################################
# Networking
###############################################################################

FILE="$OUTPUT_DIR/networking.md"

run "$FILE" "Services" kubectl get svc -A -o wide
run "$FILE" "Ingresses" kubectl get ingress -A
run "$FILE" "Ingress Details" kubectl describe ingress -A
run "$FILE" "Endpoints" kubectl get endpoints -A
run "$FILE" "Network Policies" kubectl get networkpolicy -A

###############################################################################
# Storage
###############################################################################

FILE="$OUTPUT_DIR/storage.md"

run "$FILE" "Persistent Volumes" kubectl get pv
run "$FILE" "Persistent Volume Claims" kubectl get pvc -A
run "$FILE" "Storage Classes" kubectl get storageclass

###############################################################################
# Configuration
###############################################################################

FILE="$OUTPUT_DIR/configuration.md"

run "$FILE" "ConfigMaps" kubectl get configmap -A
run "$FILE" "Secrets" kubectl get secret -A

###############################################################################
# Identity
###############################################################################

FILE="$OUTPUT_DIR/identity.md"

run "$FILE" "Service Accounts" kubectl get sa -A
run "$FILE" "Roles" kubectl get role -A
run "$FILE" "RoleBindings" kubectl get rolebinding -A
run "$FILE" "ClusterRoles" kubectl get clusterrole
run "$FILE" "ClusterRoleBindings" kubectl get clusterrolebinding

###############################################################################
# Certificates
###############################################################################

FILE="$OUTPUT_DIR/certificates.md"

run "$FILE" "Certificates" kubectl get certificate -A
run "$FILE" "Certificate Requests" kubectl get certificaterequest -A
run "$FILE" "Orders" kubectl get order -A
run "$FILE" "Challenges" kubectl get challenge -A
run "$FILE" "Issuers" kubectl get issuer -A
run "$FILE" "ClusterIssuers" kubectl get clusterissuer

###############################################################################
# External Secrets
###############################################################################

FILE="$OUTPUT_DIR/external-secrets.md"

run "$FILE" "External Secrets" kubectl get externalsecret -A
run "$FILE" "Secret Stores" kubectl get secretstore -A
run "$FILE" "Cluster Secret Stores" kubectl get clustersecretstore

###############################################################################
# CloudNativePG
###############################################################################

FILE="$OUTPUT_DIR/cloudnativepg.md"

run "$FILE" "CNPG Resources" kubectl api-resources
run "$FILE" "Clusters" kubectl get cluster.postgresql.cnpg.io -A
run "$FILE" "Backups" kubectl get backup.postgresql.cnpg.io -A
run "$FILE" "Scheduled Backups" kubectl get scheduledbackup.postgresql.cnpg.io -A

###############################################################################
# Redis
###############################################################################

FILE="$OUTPUT_DIR/redis.md"

run "$FILE" "Redis Resources" kubectl api-resources
run "$FILE" "Redis Clusters" kubectl get rediscluster -A

###############################################################################
# CRDs
###############################################################################

FILE="$OUTPUT_DIR/crds.md"

run "$FILE" "Custom Resource Definitions" kubectl get crd

###############################################################################
# Platform Components
###############################################################################

FILE="$OUTPUT_DIR/platform.md"

run "$FILE" "Ingress NGINX" kubectl get pods -n ingress-nginx
run "$FILE" "cert-manager" kubectl get pods -n cert-manager
run "$FILE" "External Secrets Operator" kubectl get pods -n external-secrets
run "$FILE" "kube-system" kubectl get pods -n kube-system

###############################################################################
# AWS
###############################################################################

FILE="$OUTPUT_DIR/aws.md"

run "$FILE" "EKS Clusters" eksctl get cluster
run "$FILE" "Nodegroups" eksctl get nodegroup --cluster "$CLUSTER_NAME"
run "$FILE" "IAM Service Accounts" eksctl get iamserviceaccount --cluster "$CLUSTER_NAME"

run "$FILE" "Describe EKS Cluster" \
aws eks describe-cluster \
--name "$CLUSTER_NAME" \
--region "$REGION"

run "$FILE" "Load Balancers" \
aws elbv2 describe-load-balancers

run "$FILE" "Target Groups" \
aws elbv2 describe-target-groups

run "$FILE" "Hosted Zones" \
aws route53 list-hosted-zones

run "$FILE" "Repositories" \
aws ecr describe-repositories

run "$FILE" "Secrets Manager" \
aws secretsmanager list-secrets

run "$FILE" "OIDC Issuer" \
aws eks describe-cluster \
--name "$CLUSTER_NAME" \
--region "$REGION" \
--query "cluster.identity.oidc.issuer"

run "$FILE" "VPC Configuration" \
aws eks describe-cluster \
--name "$CLUSTER_NAME" \
--region "$REGION" \
--query "cluster.resourcesVpcConfig"

run "$FILE" "Subnets" \
aws ec2 describe-subnets

run "$FILE" "Security Groups" \
aws ec2 describe-security-groups

echo ""
echo "Assessment completed successfully."
echo "Evidence written to:"
echo "$OUTPUT_DIR"
