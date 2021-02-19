Kustomize features:

* **base** - simple configuration
* **stage** - define namespace, add a resource, inherit from base
* **test-legacy** - change image's tag
* **test-cascade-prefix** - add prefix, inherit from test-legacy
* **stage-probes** - strategic merge
* **prod** - remote base, configMapGenerator