# Persistent Volumes
```text
$ kubectl get pv

NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                                                                       STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE
pvc-3b484b04-f939-468d-bf01-02f3befafae6   1Gi        RWO            Delete           Bound    redis/node-conf-rideshare-redis-cluster-leader-2                            gp2            <unset>                          41d
pvc-4a09068d-1632-4d77-9fd8-e9d354abb9f8   20Gi       RWO            Delete           Bound    redis/rideshare-redis-cluster-follower-rideshare-redis-cluster-follower-2   gp2            <unset>                          41d
pvc-7687fe33-e25c-485d-85c3-1cf80dd6ca75   20Gi       RWO            Delete           Bound    redis/rideshare-redis-cluster-leader-rideshare-redis-cluster-leader-0       gp2            <unset>                          41d
pvc-7b42623f-0d48-4ead-9371-05a5df18e273   20Gi       RWO            Delete           Bound    redis/rideshare-redis-cluster-leader-rideshare-redis-cluster-leader-2       gp2            <unset>                          41d
pvc-85bbf8de-9583-4f90-a0d6-52e87bc5bd8d   20Gi       RWO            Delete           Bound    redis/rideshare-redis-cluster-leader-rideshare-redis-cluster-leader-1       gp2            <unset>                          41d
pvc-983bd762-044e-4d23-afaf-f38bf09fe952   1Gi        RWO            Delete           Bound    redis/node-conf-rideshare-redis-cluster-leader-0                            gp2            <unset>                          41d
pvc-a78313a0-c378-4a1c-b02c-b888711aae91   20Gi       RWO            Delete           Bound    postgres/rideshare-postgres-cluster-1                                       gp2            <unset>                          41d
pvc-b101c750-eacb-44e9-bdb3-535d9657caa3   1Gi        RWO            Delete           Bound    redis/node-conf-rideshare-redis-cluster-leader-1                            gp2            <unset>                          41d
pvc-d1bfd30e-2789-46b9-a90f-07c7594eec45   20Gi       RWO            Delete           Bound    postgres/rideshare-postgres-cluster-3                                       gp2            <unset>                          41d
pvc-db403aad-f6dd-4d5a-8d08-69ce627859a8   20Gi       RWO            Delete           Bound    redis/rideshare-redis-cluster-follower-rideshare-redis-cluster-follower-1   gp2            <unset>                          41d
pvc-dbd74475-f0ad-4139-9103-fbe36b5ba494   1Gi        RWO            Delete           Bound    redis/node-conf-rideshare-redis-cluster-follower-1                          gp2            <unset>                          41d
pvc-dea82789-0045-485f-ad5c-1e76668d5209   20Gi       RWO            Delete           Bound    postgres/rideshare-postgres-cluster-2                                       gp2            <unset>                          41d
pvc-e0d06cdd-ba3d-4bd8-bdcb-944a6b4997ed   1Gi        RWO            Delete           Bound    redis/node-conf-rideshare-redis-cluster-follower-0                          gp2            <unset>                          41d
pvc-f61c87eb-8d5c-4705-863e-7286e9091b95   1Gi        RWO            Delete           Bound    redis/node-conf-rideshare-redis-cluster-follower-2                          gp2            <unset>                          41d
pvc-fa656579-7b97-4309-ac4d-a749ef1a0c7f   20Gi       RWO            Delete           Bound    redis/rideshare-redis-cluster-follower-rideshare-redis-cluster-follower-0   gp2            <unset>                          41d
```

# Persistent Volume Claims
```text
$ kubectl get pvc -A

NAMESPACE   NAME                                                                  STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
postgres    rideshare-postgres-cluster-1                                          Bound    pvc-a78313a0-c378-4a1c-b02c-b888711aae91   20Gi       RWO            gp2            <unset>                 42d
postgres    rideshare-postgres-cluster-2                                          Bound    pvc-dea82789-0045-485f-ad5c-1e76668d5209   20Gi       RWO            gp2            <unset>                 41d
postgres    rideshare-postgres-cluster-3                                          Bound    pvc-d1bfd30e-2789-46b9-a90f-07c7594eec45   20Gi       RWO            gp2            <unset>                 41d
redis       node-conf-rideshare-redis-cluster-follower-0                          Bound    pvc-e0d06cdd-ba3d-4bd8-bdcb-944a6b4997ed   1Gi        RWO            gp2            <unset>                 41d
redis       node-conf-rideshare-redis-cluster-follower-1                          Bound    pvc-dbd74475-f0ad-4139-9103-fbe36b5ba494   1Gi        RWO            gp2            <unset>                 41d
redis       node-conf-rideshare-redis-cluster-follower-2                          Bound    pvc-f61c87eb-8d5c-4705-863e-7286e9091b95   1Gi        RWO            gp2            <unset>                 41d
redis       node-conf-rideshare-redis-cluster-leader-0                            Bound    pvc-983bd762-044e-4d23-afaf-f38bf09fe952   1Gi        RWO            gp2            <unset>                 41d
redis       node-conf-rideshare-redis-cluster-leader-1                            Bound    pvc-b101c750-eacb-44e9-bdb3-535d9657caa3   1Gi        RWO            gp2            <unset>                 41d
redis       node-conf-rideshare-redis-cluster-leader-2                            Bound    pvc-3b484b04-f939-468d-bf01-02f3befafae6   1Gi        RWO            gp2            <unset>                 41d
redis       rideshare-redis-cluster-follower-rideshare-redis-cluster-follower-0   Bound    pvc-fa656579-7b97-4309-ac4d-a749ef1a0c7f   20Gi       RWO            gp2            <unset>                 41d
redis       rideshare-redis-cluster-follower-rideshare-redis-cluster-follower-1   Bound    pvc-db403aad-f6dd-4d5a-8d08-69ce627859a8   20Gi       RWO            gp2            <unset>                 41d
redis       rideshare-redis-cluster-follower-rideshare-redis-cluster-follower-2   Bound    pvc-4a09068d-1632-4d77-9fd8-e9d354abb9f8   20Gi       RWO            gp2            <unset>                 41d
redis       rideshare-redis-cluster-leader-rideshare-redis-cluster-leader-0       Bound    pvc-7687fe33-e25c-485d-85c3-1cf80dd6ca75   20Gi       RWO            gp2            <unset>                 41d
redis       rideshare-redis-cluster-leader-rideshare-redis-cluster-leader-1       Bound    pvc-85bbf8de-9583-4f90-a0d6-52e87bc5bd8d   20Gi       RWO            gp2            <unset>                 41d
redis       rideshare-redis-cluster-leader-rideshare-redis-cluster-leader-2       Bound    pvc-7b42623f-0d48-4ead-9371-05a5df18e273   20Gi       RWO            gp2            <unset>                 41d
```

# Storage Classes
```text
$ kubectl get storageclass

NAME   PROVISIONER             RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
gp2    kubernetes.io/aws-ebs   Delete          WaitForFirstConsumer   false                  49d
```

