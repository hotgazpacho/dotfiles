# Selects a kubernetes namespace, with a preview showing all the resources it contains
__fzf_kubectl_namespace() {
  kubectl get namespace --output=custom-columns=NAME:.metadata.name --no-headers --sort-by=.metadata.name | fzf \
    --reverse \
    --border \
    --border-label="󱃾  Namespace" \
    --border-label-pos=2 \
    --prompt "$(kubectl config current-context | sed 's/-context$//')> " \
    --bind 'ctrl-/:change-preview-window(hidden|)' \
    --preview "kubectl get \"$(kubectl api-resources --namespaced --verbs list -o name | xargs | sed 's/ /,/g')\" --namespace {1} --server-print=false --no-headers -o name | sort | bat --style=numbers,grid" \
    --preview-window 'down' "$@"
}

# Selects and scales the selected namespace to 0.
ks0() {
  __fzf_kubectl_namespace --query "$*" \
    --bind 'enter:become:kubectl scale deployment,replicaset,replicationcontroller,statefulset --namespace {1} --all --replicas=0' \
    --preview "kubectl get deployment,replicaset,replicationcontroller,statefulset --namespace={1}"
}

# Selects and scales the selected namespace to 1.
ks1() {
 __fzf_kubectl_namespace --query "$*" \
    --bind 'enter:become:kubectl scale deployment,replicaset,replicationcontroller,statefulset --namespace {1} --all --replicas=1' \
    --preview "kubectl get deployment,replicaset,replicationcontroller,statefulset --namespace={1}"
}
