## Standalone (single server)

helm install neo4j https://github.com/neo4j-contrib/neo4j-helm/releases/download/4.1.3-1/neo4j-4.1.3-1.tgz --set core.standalone=true --set acceptLicenseAgreement=yes --set neo4jPassword=mySecretPassword


## Casual Cluster (3 core, 0 read replicas)

helm install neo4j https://github.com/neo4j-contrib/neo4j-helm/releases/download/4.1.3-1/neo4j-4.1.3-1.tgz --set acceptLicenseAgreement=yes --set neo4jPassword=mySecretPassword


### Uninstall

``` helm uninstall neo4j ```