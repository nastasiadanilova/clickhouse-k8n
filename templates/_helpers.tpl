{{- define "clickhouse.name" -}}
{{ .Release.Name }}
{{- end -}}

{{- define "clickhouse.fullname" -}}
{{ .Release.Name }}-clickhouse
{{- end -}}
