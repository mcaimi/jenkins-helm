{{- define "jenkins.pod" -}}
containers:
- image: {{ .Values.jenkins.image }}:{{ .Values.jenkins.tag }}
  imagePullPolicy: Always
  name: {{ .Values.jenkins.deployment_name }}-pod
  volumeMounts:
    - mountPath: "/tmp/casc_files"
      name: config-as-code
    - mountPath: "/var/jenkins_home"
      name: persistent-jenkins-volume
  ports:
  {{- range .Values.services }}
  - containerPort: {{ .port }}
    protocol: {{ .protocol }}
    name: {{ .name }}
  {{- end }}
  {{- with .Values.resources }}
  resources:
    {{- toYaml . | nindent 4 -}}
  {{- end }}
volumes:
  - name: config-as-code
    configMap:
      name: {{ .Values.jenkins.deployment_name }}-casc-cm
      defaultMode: 0550
{{- if .Values.jenkins.persistent }}
  - name: persistent-jenkins-volume
    persistentVolumeClaim:
      claimName: {{ .Values.jenkins.deployment_name }}-claim
{{- else }}
  - name: persistent-jenkins-volume
    emptyDir: {}
{{- end }}
dnsPolicy: ClusterFirst
restartPolicy: Always
schedulerName: default-scheduler
securityContext: {}
terminationGracePeriodSeconds: 30
{{- end }}
