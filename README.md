# rsyslog-server
Simple docker image providing a cluster global rsyslog server

# sample Kubernetes deployment

The following deployment creates a `syslog` service to a Kubernets cluster.

The config map provides logging and logrotate options, feel free to use the `etc/logrotate.d/all.conf` and
`etc/rsyslog.d/all.conf` files as templates.

```yaml
kind: Deployment
apiVersion: apps/v1
metadata:
  name: syslog
  labels:
    app: syslog
spec:
  replicas: 1
  selector:
    matchLabels:
      app: syslog
  template:
    metadata:
      labels:
        app: syslog
    spec:
      containers:
      - image: kodgruvan/rsyslog-server:latest
        name: syslog
        env:
          - name: DO_LOG_ALL
            value: "false"
          - name: DO_DUMP_TO_STDOUT
            value: "false"
        ports:
          - name: syslog
            containerPort: 514
        volumeMounts:
          - name: var
            mountPath: /var/log
          - name: config
            mountPath: /etc/rsyslog.d/my-syslog.conf
            subPath: my-syslog.conf
          - name: config
            mountPath: /etc/logrotate.d/my-logrotate.conf
            subPath: my-logrotate.conf
      volumes:
        - name: var
          persistentVolumeClaim:
            claimName: syslogs
        - name: config
          configMap:
            name: my-syslog

---

kind: Service
apiVersion: v1
metadata:
  name: syslog
spec:
  selector:
    app: syslog
  ports:
    - port: 514


---

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: syslogs
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
```