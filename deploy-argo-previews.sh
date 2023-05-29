# Source: https://gist.github.com/808108069f709572f1bc372c65f6b5c0

###########
# Prepare #
###########

# Option 1:
#   Create a Kubernetes cluster
#   Install NGINX Ingress
#   Install Argo CD
#   Declare environment variable `INGRESS_HOST` with the IP of the Ingress Service

# Option 2:
#   Use minikube-argocd.sh Gist (https://gist.github.com/84324e2d6eb1e62e3569846a741cedea) to create a Minikube cluster with all the requirements

# Watch "Argo CD: Applying GitOps Principles To Manage Production Environment In Kubernetes" (https://youtu.be/vpWQeoaiRM4) if you are new to Argo CD

#open https://github.com/vfarcic/argocd-previews

# Fork it

export GH_ORG=yairaba # Replace `[...]` with the GitHub organization or the GitHub user if using a private account.

git clone https://github.com/$GH_ORG/argocd-previews.git

cd argocd-previews

cat apps.yaml \
    | sed -e "s@vfarcic@$GH_ORG@g" \
    | tee apps.yaml

git add .

git commit -m "Initial commit"

git push

######
# Do #
######

gh repo view

cat project.yaml

kubectl apply --filename project.yaml

cat apps.yaml

kubectl apply --filename apps.yaml

open http://argocd.$INGRESS_HOST.nip.io

ls -1 helm/templates

cat helm/templates/namespace.yaml

cat preview.yaml

# preview.yaml should be a file stored in the app repo
export INGRESS_HOST=192.168.40.200
export PR_ID=1

export REPO=devops-toolkit

export APP_ID=pr-$REPO-$PR_ID

export IMAGE_TAG=2.6.2

export HOSTNAME=$APP_ID.$INGRESS_HOST.nip.io

cat preview.yaml \
    | kyml tmpl -e REPO -e APP_ID -e IMAGE_TAG -e HOSTNAME \
    | tee helm/templates/$APP_ID.yaml

ls -1 helm/templates

git add .

git commit -m "$APP_ID"

git push

argocd app sync previews

kubectl get namespaces

kubectl --namespace $APP_ID \
    get pods

open http://$HOSTNAME

export PR_ID=1

export REPO=devops-paradox

export APP_ID=pr-$REPO-$PR_ID

export IMAGE_TAG=1.71

export HOSTNAME=$APP_ID.$INGRESS_HOST.nip.io

cat preview.yaml \
    | kyml tmpl -e REPO -e APP_ID -e IMAGE_TAG -e HOSTNAME \
    | tee helm/templates/$APP_ID.yaml

ls -1 helm/templates

git add .

git commit -m "$APP_ID"

git push

argocd app sync previews

kubectl --namespace $APP_ID \
    get pods
    
open http://$HOSTNAME

export PR_ID=2

export REPO=devops-toolkit

export APP_ID=pr-$REPO-$PR_ID

export IMAGE_TAG=2.9.9

export HOSTNAME=$APP_ID.$INGRESS_HOST.nip.io

cat preview.yaml \
    | kyml tmpl -e REPO -e APP_ID -e IMAGE_TAG -e HOSTNAME \
    | tee helm/templates/$APP_ID.yaml

ls -1 helm/templates

git add .

git commit -m "$APP_ID"

git push

argocd app sync previews

kubectl --namespace $APP_ID \
    get pods

kubectl get namespaces

open http://$HOSTNAME

rm -f helm/templates/$APP_ID.yaml

git add .

git commit -m "$APP_ID"

git push

argocd app sync previews

kubectl get namespaces

kubectl --namespace $APP_ID \
    get pods

kubectl delete namespace $APP_ID

###########
# Destroy #
###########

# Destroy the cluster
# If it was created through https://gist.github.com/84324e2d6eb1e62e3569846a741cedea, the instructions are at the bottom

open https://github.com/$GH_ORG/argocd-previews/settings

# Click the *Delete this repository* button and follow the instructions
