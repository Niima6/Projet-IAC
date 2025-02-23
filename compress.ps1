# Créer un dossier lambdas s'il n'existe pas
$LambdaRoot = ".\lambdas"
if (!(Test-Path -Path $LambdaRoot)) {
    New-Item -ItemType Directory -Path $LambdaRoot
}

# Fonction pour zipper chaque Lambda
function Compress-Lambda {
    param (
        [string]$LambdaName,
        [string]$HandlerFile
    )

    # Vérifier si le fichier handler et node_modules existent
    if ((Test-Path ".\astroshop-back\$HandlerFile") -and (Test-Path ".\astroshop-back\node_modules")) {
        # Zipper le fichier handler et les dépendances node_modules directement
        $FilesToCompress = @(".\astroshop-back\$HandlerFile", ".\astroshop-back\node_modules")
        Compress-Archive -Path $FilesToCompress -DestinationPath "$LambdaRoot\$LambdaName.zip" -Force

        Write-Host "✅ $LambdaName a été zippé avec succès !" -ForegroundColor Green
    }
    else {
        Write-Host "❌ Impossible de trouver les fichiers pour $LambdaName" -ForegroundColor Red
    }
}

# Zipper toutes les Lambdas
Compress-Lambda -LambdaName "get_products" -HandlerFile "getProducts.ts"
Compress-Lambda -LambdaName "get_product_by_id" -HandlerFile "getProductById.ts"
Compress-Lambda -LambdaName "cart" -HandlerFile "cart.ts"
Compress-Lambda -LambdaName "checkout" -HandlerFile "checkout.ts"
