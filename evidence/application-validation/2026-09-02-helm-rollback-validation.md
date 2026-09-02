# Helm Rollback Cleanup Validation

## Frontend ReplicaSets

The following command was used to inspect the ReplicaSets associated with the frontend deployment:

```bash
kubectl get replicasets \
  --namespace rideshare \
  -l app=frontend
```

Output:

```text
NAME                  DESIRED   CURRENT   READY   AGE
frontend-55cf5b9646   0         0         0       3d4h
frontend-698dcbbf75   0         0         0       43m
frontend-6c6c584f68   1         1         1       28h
frontend-9f9c9997d    0         0         0       3d4h
```

The ReplicaSet created by the failed deployment was successfully scaled down to zero. The restored ReplicaSet, `frontend-6c6c584f68`, has one desired, current and ready replica.

## Invalid Image Verification

The following command checked whether any running pod still referenced the intentionally invalid image tag:

```bash
kubectl get pods \
  --namespace rideshare \
  -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{range .spec.containers[*]}{.image}{" "}{end}{"\n"}{end}' \
  | grep 'rollback-test-image-does-not-exist'
```

Output:

```text
No output returned.
```

The absence of output confirms that no pod in the `rideshare` namespace references the invalid rollback-test image.

## Horizontal Pod Autoscaler Status

The following command was used to verify the desired replica counts after rollback:

```bash
kubectl get hpa \
  --namespace rideshare
```

Output:

```text
NAME                   REFERENCE                     TARGETS       MINPODS   MAXPODS   REPLICAS   AGE
driver-service-hpa     Deployment/driver-service     cpu: 1%/70%   2         5         2          3d4h
email-service-hpa      Deployment/email-service      cpu: 2%/70%   1         5         1          3d4h
frontend-hpa           Deployment/frontend           cpu: 1%/70%   1         5         1          3d4h
matching-service-hpa   Deployment/matching-service   cpu: 1%/70%   1         10        1          3d4h
rider-service-hpa      Deployment/rider-service      cpu: 1%/70%   1         10        1          3d4h
trip-service-hpa       Deployment/trip-service       cpu: 3%/70%   1         10        1          3d4h
```

The HPA output confirms that:

* `driver-service` correctly maintains its minimum of two replicas.
* `email-service`, `frontend`, `matching-service`, `rider-service` and `trip-service` correctly maintain their minimum of one replica.
* The frontend’s `1/1` state is healthy and consistent with its HPA configuration.

## Validation Result

The post-rollback cleanup validation passed:

* The failed frontend ReplicaSet was scaled down to zero.
* The previous frontend ReplicaSet was restored successfully.
* No pod references the deliberately invalid image.
* All application deployments have their expected HPA-managed replica counts.

**Result: PASS**
