$env:USE_CERTBUND = "false"
$REGISTRY = "skizo16"
$TAG = "cyberdrill16"

Write-Host "Building all images..."
docker compose build
if ($LASTEXITCODE -ne 0) { Write-Error "Build failed"; exit 1 }

$images = @(
    "intelmq",
    "intelmq-fody",
    "intelmq-fody-backend",
    "intelmq-database",
    "intelmq-mailgen",
    "intelmq-dsmtpd",
    "intelmq-webinput-csv-spa",
    "intelmq-webinput-csv-backend"
)

foreach ($img in $images) {
    $remote = "$REGISTRY/${img}:$TAG"
    Write-Host "Tagging $img -> $remote"
    docker tag $img $remote
    if ($LASTEXITCODE -ne 0) { Write-Error "Tag failed for $img"; exit 1 }

    Write-Host "Pushing $remote"
    docker push $remote
    if ($LASTEXITCODE -ne 0) { Write-Error "Push failed for $remote"; exit 1 }
}

Write-Host "All images pushed to Docker Hub under $REGISTRY/*:$TAG"
