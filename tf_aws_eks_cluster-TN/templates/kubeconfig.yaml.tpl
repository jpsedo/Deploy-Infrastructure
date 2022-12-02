apiVersion: v1
clusters:
- cluster:
    server: ${cluster_endpoint}
    certificate-authority-data: "${cluster_cert}"
  name: ${cluster_name}
contexts:
- context:
    cluster: ${cluster_name}
    user: aws
  name: ${cluster_name}
current-context: ${cluster_name}
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      args:
      - --region
      - "${aws_region}"
      - eks
      - get-token
      - --cluster-name
      - "${cluster_name}"
      command: aws
      env:
      - name: AWS_PROFILE
        value: "${aws_profile}"