#!/bin/bash

# Étape 1: Télécharger la version stable de Flutter
git clone https://github.com/flutter/flutter.git --branch stable

# Étape 2: Ajouter Flutter au "chemin" pour que les commandes fonctionnent
export PATH="$PATH:`pwd`/flutter/bin"

# Étape 3: CRÉER LA CONFIGURATION WEB SUR UN PROJET "PROPRE"
# On exécute cette commande AVANT 'pub get'. C'est ça, la clé.
# Elle va créer le dossier 'web' sans écraser les dépendances qui n'ont pas encore été téléchargées.
flutter create . --platforms web

# Étape 4: TÉLÉCHARGER LES DÉPENDANCES
# Maintenant que le dossier 'web' est là, on peut télécharger les dépendances en toute sécurité.
flutter pub get

# Étape 5: Construire le projet pour le web avec les clés Supabase
flutter build web --release --dart-define=SUPABASE_URL=$SUPABASE_URL --dart-define=SUPABASE_ANON_KEY=$SUPABASE_ANON_KEY
