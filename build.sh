#!/bin/bash

# Étape 1: Télécharger la version stable de Flutter
git clone https://github.com/flutter/flutter.git --branch stable

# Étape 2: Ajouter Flutter au "chemin" pour que les commandes fonctionnent
export PATH="$PATH:`pwd`/flutter/bin"

# Étape 3: Nettoyer le projet (bonne pratique )
flutter clean

# Étape 4: TÉLÉCHARGER VOS DÉPENDANCES (la correction est ici)
# On fait cette étape AVANT de toucher à la configuration web.
flutter pub get

# Étape 5: S'assurer que la configuration web existe, SANS écraser le projet
# La commande "flutter create" est dangereuse. On la remplace par "flutter config".
flutter config --enable-web

# Étape 6: Construire le projet pour le web avec les clés Supabase
flutter build web --release --dart-define=SUPABASE_URL=$SUPABASE_URL --dart-define=SUPABASE_ANON_KEY=$SUPABASE_ANON_KEY
