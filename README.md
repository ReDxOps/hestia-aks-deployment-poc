# Hestia Loyalty - Azure Cloud-Native POC

## Description
Proof of Concept pour la migration Cloud-Native de l'application Hestia Loyalty vers l'écosystème Microsoft Azure. Ce projet démontre la mise en œuvre d'une architecture résiliente, optimisée pour les coûts (FinOps) et automatisée de bout en bout via Infrastructure as Code.

## Stack Technique
- **Orchestration de Conteneurs :** Azure Kubernetes Service (AKS)
- **Stockage des Artéfacts :** Azure Container Registry (ACR)
- **Infrastructure as Code (IaC) :** Terraform / Bicep
- **Intégration et Déploiement Continu (CI/CD) :** Azure DevOps Pipelines

## Architecture & Stratégie
- **FinOps :** Provisionnement éphémère du cluster de développement pour minimiser les coûts d'infrastructure hors heures ouvrées.
- **Zero-Downtime :** Déploiement progressif de l'application (Rolling Updates) géré nativement par les contrôleurs Kubernetes.
- **Security-First :** Gestion stricte des identités et isolation réseau des composants critiques.

## Structure du Référentiel
- `/infrastructure` : Code déclaratif (Terraform/Bicep) provisionnant le socle réseau, l'ACR et le cluster AKS.
- `/kubernetes` : Manifestes YAML (Deployment, Service, ConfigMap) définissant l'état désiré de l'application.
- `/.azure-devops` : Pipelines YAML d'intégration et de déploiement continus.

## Prérequis Système
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Terraform](https://developer.hashicorp.com/terraform/downloads) (ou environnement Bicep)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/)
- Souscription Azure valide

## Initialisation (Environnement Local)

1. Authentification au locataire Azure :
```bash
az login
az account set --subscription "<SUBSCRIPTION_ID>"
```

2. Provisionnement du socle d'infrastructure :
```bash
cd infrastructure/
terraform init
terraform plan
terraform apply
```

3. Récupération du contexte Kubernetes :
```bash
az aks get-credentials --resource-group <RESOURCE_GROUP_NAME> --name <CLUSTER_NAME>
```

## Déploiement CI/CD
Le cycle de vie de l'application est automatisé via Azure DevOps.
1. **CI :** Tout commit sur la branche principale déclenche la construction de l'image Docker Next.js et son envoi vers l'ACR.
2. **CD :** Le pipeline applique automatiquement les nouveaux manifestes Kubernetes sur le cluster AKS provisionné.