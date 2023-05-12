CURR_DIR=$(pwd);
docker run -it --rm quay.io/thanos/thanosbench:v0.2.0-rc.1 block plan -p continuous-365d-tiny > ${CURR_DIR}/block-spec.yaml

docker run -it --rm quay.io/thanos/thanosbench:v0.2.0-rc.1 block plan -p continuous-365d-tiny --labels 'cluster="eu1"' | \
    docker run -v ${CURR_DIR}/prom-eu1-replica0/data:/out -i quay.io/thanos/thanosbench:v0.2.0-rc.1 block gen --output.dir /out

docker run -it --rm quay.io/thanos/thanosbench:v0.2.0-rc.1 block plan -p continuous-365d-tiny --labels 'cluster="eu1"' | \
    docker run -v ${CURR_DIR}/prom-eu1-replica1/data:/out -i quay.io/thanos/thanosbench:v0.2.0-rc.1 block gen --output.dir /out

docker run -it --rm quay.io/thanos/thanosbench:v0.2.0-rc.1 block plan -p continuous-365d-tiny --labels 'cluster="us1"' | \
    docker run -v ${CURR_DIR}/prom-us1-replica0/data:/out -i quay.io/thanos/thanosbench:v0.2.0-rc.1 block gen --output.dir /out


