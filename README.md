# Terraform Cloud Lab

## Step 1: Set Up Terraform Cloud Account
1. Sign up or log in to [Terraform Cloud](https://app.terraform.io/).
2. Create a new organization in Terraform Cloud.

## Step 2: Create Multiple Workspaces
### Option 1: Using the Terraform Cloud UI
1. Navigate to **Workspaces** > **Create a new workspace**.
2. Choose **CLI-driven** workflow.
3. Repeat for additional workspaces (e.g., `dev`, `staging`, `prod`).

### Option 2: Using the Terraform CLI
Run the following commands to initialize and create workspaces:
```sh
terraform init 

terraform workspace new dev
terraform workspace select dev
terraform apply

terraform workspace new staging
terraform workspace select staging
terraform apply

terraform workspace new prod
terraform workspace select prod
terraform apply
```

## Step 3: Push to GitHub
1. Initialize Git and connect to GitHub:
   ```sh
   git init
   git remote add origin https://github.com/your-username/terraform-cloud-lab.git
   ```
2. Create a `.gitignore` file:
   ```sh
   echo ".terraform/" >> .gitignore
   echo "*.tfstate" >> .gitignore
   echo "*.tfstate.backup" >> .gitignore
   echo "terraform.tfvars" >> .gitignore
   ```
3. Commit and push your changes:
   ```sh
   git add .
   git commit -m "Initial commit - Terraform Cloud Lab"
   git branch -M main
   git push -u origin main
   ```
