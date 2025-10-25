#!/bin/bash

# Étape 1: Télécharger Flutter
git clone https://github.com/flutter/flutter.git --branch stable

# Étape 2: Ajouter Flutter au PATH (pour que les commandes soient plus courtes )
export PATH="$PATH:`pwd`/flutter/bin"

# Étape 3: Configurer le projet pour le web
flutter create . --platforms web

# Étape 4: Nettoyer et construire le projet
flutter clean
flutter build web --release --dart-define=SUPABASE_URL=$SUPABASE_URL --dart-define=SUPABASE_ANON_KEY=$SUPABASE_ANON_KEY
