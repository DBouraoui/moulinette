#!/bin/bash

cd ".." || exit 1

echo "🔍 Début de la correction de l'exercice reverse-string..."
echo ""

# Liste de mots à tester (strings normaux)
WORDS=("train" "cacochyme" "bonjour" "algorithmique" "shell")

# Valeurs numériques pour tester sensibilité au type
NUMBERS=(42 2025 1001)

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

        # 🔹 Tests sensibilité au type (DOIT renvoyer un message d'erreur attendu)
        numeric_ok=true

        for num in "${NUMBERS[@]}"; do
            output=$(php "$FILE" "$num" 2>/dev/null)

            if [[ "$output" == *"Le type attendu est incorrect"* ]]; then
                echo "    🟢 Numérique $num rejeté correctement"
            else
                echo "    🔴 Numérique $num : Mauvaise gestion du type → '$output'"
                numeric_ok=false
            fi
        done

        if $numeric_ok; then
            echo "  ✔ Tests numériques respectés → +5 pts"
            POINTS=$(($POINTS + 5))
        else
            echo "  ✖ Erreur dans la gestion des nombres → +0 pts"
        fi

        echo "🏅 Score final pour l'élève : $POINTS / 20"
        echo ""

        [[ $POINTS -eq 20 ]] && ((total_success++))

    fi
done

echo "🎉 Correction terminée."
echo "📊 Résumé : $total_success / $total_students élèves ont 20/20"
