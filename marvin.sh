cd "../marvin" 

if [ ! -f algo.php ]; then
    echo "❌ algo.php manquant dans le repo"
    exit 1
fi

echo "✅ algo.php trouvé"
