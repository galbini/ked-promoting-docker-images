# ked-promoting-docker-images
## Prerequise
- A cloud project on GCP 
- gcloud command
- Value for   
    * $PROJECT_ID  
    * $PROJECT_NUMBER


## Configure gcloud command
gcloud config configurations create ked-pdi  
gcloud config set account <gcloud-account>   
gcloud config set project <gcloud-project-id>  
gcloud config set run/platform managed  
gcloud config set run/region europe-west1  


## Enable gcloud services
gcloud services enable cloudbuild.googleapis.com  
gcloud services enable run.googleapis.com  
gcloud services enable secretmanager.googleapis.com  

## Config maven cache location
gsutil mb -p $PROJECT_ID -l europe-west1  gs://$($PROJECT_ID)_cloudbuild-m2repo/

## Add role Cloud Admin to Cloud Build

gcloud projects add-iam-policy-binding $PROJECT_ID \
--member serviceAccount:$(PROJECT_NUMBER)@cloudbuild.gserviceaccount.com \
--role roles/run.admin

## Add role Secret Manager Secret Accessor to Cloud Build

gcloud projects add-iam-policy-binding $PROJECT_ID \
--member serviceAccount:$(PROJECT_NUMBER)@cloudbuild.gserviceaccount.com \
--role roles/secretmanager.secretAccessor

## Add service account user to Cloud Run for service account Cloud Build

gcloud iam service-accounts add-iam-policy-binding $(PROJECT_NUMBER)-compute@developer.gserviceaccount.com  \ 
--member serviceAccount:$(PROJECT_NUMBER)@cloudbuild.gserviceaccount.com  \
--role roles/iam.serviceAccountUser

## Config ssh key for your repo and give access to GCP with secret manager
https://cloud.google.com/cloud-build/docs/access-private-github-repos  
gcloud secrets create repo-kep-pdi-id --data-file=id_github  
TIPS echo '!.git' > .gcloudignore  
