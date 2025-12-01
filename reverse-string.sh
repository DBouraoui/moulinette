#!/bin/bash

cd ".." || exit 1

echo "🔍 Début de la correction de l'exercice reverse-string..."
echo ""

# Liste de mots à tester (strings normaux)
WORDS=("train" "cacochyme" "bonjour" "algorithmique" "shell")


declare -i total_students=0
declare -i total_success=0

for student in */ ; do
    if [ -d "$student" ]; then
        ((total_students++))
        POINTS=0
        echo "👤 Élève : ${student%/}"

        FILE="${student}reverse-string.php"

        # 🔹 Vérification du fichier
        if [ ! -f "$FILE" ]; then
            echo "  ❌ reverse-string.php manquant → +0 pts"
            echo "🏅 Score final pour l'élève : $POINTS / 20"
            echo ""
            continue
        fi

       strrev=$(grep -i "strrev" "$FILE")

        if [ -n "$strrev" ]; then
            echo "❌ Fonction native 'strrev' trouvée → note finale 0/20"
            echo ""
            continue
        fi


        echo "  📄 reverse-string.php trouvé → +5 pts"
        POINTS=$(($POINTS + 5))
        
        all_correct_words=true
        
        # 🔹 Tests sur les mots simples
        for word in "${WORDS[@]}"; do
            expected=$(echo "$word" | rev)
            output=$(php "$FILE" "$word" 2>/dev/null)

            if [ "$output" = "$expected" ]; then
                echo "    🟢 $word → $output"
            else
                echo "    🔴 $word : attendu '$expected', obtenu '$output'"
                all_correct_words=false
            fi
        done

        if $all_correct_words; then
            echo "  ✔ Tous les tests WORDS OK → +10 pts"
            POINTS=$(($POINTS + 10))
        else
            echo "  ✖ Certains tests WORDS échouent → +0 pts"
        fi

        # Test : aucun argument
        output=$(php "$FILE" 2>/dev/null)

        if [[ "$output" == *"Aucun argument fourni."* ]]; then
            echo "    🟢 Test sans argument : erreur correctement renvoyée -> +5 pts"
            POINTS=$(($POINTS + 5))
        else
            echo "    🔴 Test sans argument : message attendu non trouvé → '$output'"
        fi

        echo "🏅 Score final pour l'élève : $POINTS / 20"
        echo ""

        [[ $POINTS -eq 20 ]] && ((total_success++))

    fi
done

echo "🎉 Correction terminée."
echo "📊 Résumé : $total_success / $total_students élèves ont 20/20"
