# Projet-IAC

Ce projet est réalisé dans le cadre du cours d'infrastructure as code (IaC) et utilise Terraform pour déployer une infrastructure AWS complète.

## Infrastructure AWS

![AWS Architecture](aws%20architecture.png)

### Base de données
- **RDS** : Aurora (US)

### Computing
- **Auto Scaling Group** : Groupe d'instances EC2 (min : 2-US, 1-FR)
- **Application Load Balancer**

### Application
- **Container Docker** : Wordpress
- **Lambda** : Fonction pour l'envoi d'email

## Descriptif AWS

- **Auto Scaling Group EC2**
- **RDS Aurora**
- **Lambda**

### Réseau (network.tf)
- VPC
- Subnets publics et privés
- Internet Gateway
- Tables de routage

### Sécurité (security.tf)
- Groupes de sécurité pour l’ALB, les instances et RDS

### Load Balancer (server.tf)
- Application Load Balancer (ALB)
- Target Group
- Listener HTTP

### Autoscaling (server.tf & launchtemplate.tf)
- Autoscaling Group (ASG)
- Launch Template basé sur ton AMI Packer

### Base de données (server.tf)
- RDS MySQL sécurisé dans un sous-réseau privé

### Variables & Provider (variable.tf, provider.tf)
- Gestion des régions

## Déploiement

### Initialiser Terraform

```bash
terraform init
```

### Planifier le déploiement

```bash
terraform plan
```

### Appliquer les changements

```bash
terraform apply -auto-approve
```

### CI/CD avec GitHub Actions

Le fichier deploy.yml configure une action GitHub pour automatiser le déploiement du frontend sur une instance EC2. Voici les étapes clés :

1. **Cloner le dépôt** : Récupère le code source depuis GitHub.
2. **Installer Node.js et les dépendances** : Prépare l'environnement de build.
3. **Builder le frontend** : Compile le code source avec Vite.
4. **Installer et initialiser Terraform** : Prépare l'infrastructure AWS.
5. **Appliquer Terraform** : Déploie les ressources AWS nécessaires en ssh.
6. **Copier le build sur EC2** : Transfère les fichiers compilés sur le serveur.
7. **Redémarrer Nginx** : Assure que les modifications sont prises en compte.

Ce pipeline garantit que chaque modification du code source est automatiquement déployée sur l'infrastructure AWS, assurant ainsi une intégration et un déploiement continus (CI/CD).

## Résultat Final

### API Gateway expose :

- **GET /products** → Liste des produits
- **GET /products/{id}** → Détails d’un produit
- **POST /cart** → Ajouter/Supprimer du panier
- **POST /checkout** → Simuler un paiement

- Les données sont stockées dans MySQL (RDS)
- IAM sécurise les accès aux Lambdas

## Structure du Projet

- **terraform/** : Contient les fichiers de configuration Terraform pour déployer l'infrastructure AWS.
- **astroshop-front/** : Frontend de l'application utilisant React, TypeScript et Vite.
- **astroshop-back/** : Backend de l'application avec des fonctions AWS Lambda.

## Conclusion

Nous avons choisi cette architecture pour son évolutivité et son scalabilité. L'Auto Scaling Group et l'Application Load Balancer permettent automatiquement de s'ajuster en fonction de la charge. L'utilisation de RDS pour la base de données garantit une haute disponibilité. Les fonctions Lambda permettent d'aborder du serverless pour réduire la complexité de gestion des serveurs.Cette architecture permet d'ajouter facilement des régions AWS comme en France.
