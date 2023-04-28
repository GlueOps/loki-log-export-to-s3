# loki-log-exporter-to-s3

## Overview

This loki-exporter-to-s3 uses the logcli from loki and basically runs a series of bash scripts that will query one hour at a time for the last 72 hours and upload a gzipped newline json file to s3 to keep loki logs for longterm storage.

## Development Environment

Export 5 environment variables:

```bash
## Credentials from loki-xptr-s3 credentials: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites
export AWS_ACCESS_KEY_ID=XXXXXXXXXXXXXXXXXXX
export AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXXXX
# this should be the region that your bucket is in
export AWS_DEFAULT_REGION=XXXXXXXXXXXXXXXXXXX 

## This is the domain you created through: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites
export CAPTAIN_DOMAIN="<cluster_env>.<tenant-name-goes-here>.onglueops.rocks"
## This is the primary tenant bucket name you created through https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites
export S3_BUCKET_NAME="glueops-tenant-<tenant-name-goes-here>-primary"
export LOKI_ADDR="http://localhost:8080"
```


Connect to loki service with:

```bash
kubectl port-forward svc/loki-gateway -n glueops-core-loki 8080:80
```

Build docker container with:

```bash
docker build . -t dev-loki-exporter
```

Run with:

```bash
docker run --network="host" -it -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION -e CAPTAIN_DOMAIN -e S3_BUCKET_NAME -e LOKI_ADDR dev-loki-exporter
```

_Note: the `--network="host"` allows the docker container to use the kubectl port forwarded on the host machine (localhost:3100)_
