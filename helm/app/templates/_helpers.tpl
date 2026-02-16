{{- define "react-recoil.labels" -}}
app: react-recoil
{{- end }}

{{- define "react-host.name" -}}
lefranc.com
{{- end }}

{{- define "fast-api.labels" -}}
app: fastapi
{{- end }}

{{- define "app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}
