bootstrap:
ifndef cluster
$(error "Please set the cluster variable. Example: make bootstrap cluster=dev-cluster")
endif

	@echo "Bootstrapping the repository for cluster: $(cluster)"
	helm upgrade -i argocd --repo https://argoproj.github.io/argo-helm --namespace argocd --create-namespace \
		-f ./apps/argocd/values.yaml \
		-f ./clusters/$(cluster)/argocd/values.yaml \
		argo-cd
	helm upgrade -i k8s-state-base ./charts/bootstrap --namespace argocd --set clusterName=$(cluster)
