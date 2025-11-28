#!/bin/bash

cd ".." || exit 1

echo "Début de la correction de l'exo..."
echo ""

for student in */ ; do
    if [ -d "$student" ]; then
        
        echo "👤 Élève : ${student%/}"

        FILE="${student}reverse-string.php"

        if [ ! -f "$FILE" ]; then
            echo "  ❌ reverse-string.php manquant"
            echo ""
            continue
        fi

        echo "  ✅ reverse-string.php trouvé"

        output=$(php "$FILE" train 2>/dev/null)

        if [ "$output" = "niart" ]; then
            echo "  🟢 Correct"
        else
            echo "  🔴 Incorrect : attendu 'niart', obtenu '$output'"
        fi

        echo ""
    fi
done

echo "🎉 Correction terminée."
