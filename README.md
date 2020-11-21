# ked-promoting-docker-images
### / prerequise
gcloud command

value for 
$PROJECT_ID
$PROJECT_NUMBER

### / create gcloud project on cloud console

### / configure gcloud command
gcloud config configurations create ked-pdi
gcloud config set account <gcloud-account> 
gcloud config set project <gcloud-project-id>
gcloud config set run/platform managed
gcloud config set run/region europe-west1


### / enable gcloud services
gcloud services enable cloudbuild.googleapis.com
gcloud services enable run.googleapis.com
gcloud services enable secretmanager.googleapis.com

### / config maven cache
gsutil mb -p $PROJECT_ID -l europe-west1  gs://$($PROJECT_ID)_cloudbuild-m2repo/

### / add role cloud admin to cloud build

gcloud projects add-iam-policy-binding $PROJECT_ID \
--member serviceAccount:$(PROJECT_NUMBER)@cloudbuild.gserviceaccount.com \
--role roles/run.admin

### / add role Secret Manager Secret Accessor to cloud build

gcloud projects add-iam-policy-binding $PROJECT_ID \
--member serviceAccount:$(PROJECT_NUMBER)@cloudbuild.gserviceaccount.com \
--role roles/secretmanager.secretAccessor

### / add service account user to cloudrun for service account cloudbuild

gcloud iam service-accounts add-iam-policy-binding $(PROJECT_NUMBER)-compute@developer.gserviceaccount.com  \ 
--member serviceAccount:$(PROJECT_NUMBER)@cloudbuild.gserviceaccount.com  \
--role roles/iam.serviceAccountUser


### / config ssh key for your repo and give access to GCP with secret manager
https://cloud.google.com/cloud-build/docs/access-private-github-repos
gcloud secrets create repo-kep-pdi-id --data-file=id_github

