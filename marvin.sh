cd "../marvin" || exit 1

if [ ! -f algo.php ]; then
    echo "❌ algo.php manquant dans le repo"
    exit 1
fi

echo "✅ algo.php trouvé"

output=$(php algo.php train)

if [ "$output" = "niart" ]; then
    echo "✅ Correct"
    exit 0
else
    echo "❌ Incorrect : attendu 'niart' mais obtenu '$output'"
    exit 1
fi
