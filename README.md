# Jenkins Helm Chart

Automated Jenkins deployment that uses Configuration-as-Code plugin to manage jenkins settings.
The referenced compatible container image is maintained [here](https://github.com/mcaimi/jenkins)

## Installation

Just run helm on either Openshift/Kubernetes:

```
  $ oc new-app jenkins-helm
  $ helm install -f <values.file> -n jenkins-helm jenkins-helm jenkins/
```

