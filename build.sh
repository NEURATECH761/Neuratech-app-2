#!/bin/bash

# Étape 1: Télécharger la version stable de Flutter
git clone https://github.com/flutter/flutter.git --branch stable

# Étape 2: Ajouter Flutter au "chemin" pour que les commandes fonctionnent
export PATH="$PATH:`pwd`/flutter/bin"

# Étape 3: CRÉER LA CONFIGURATION WEB (si elle n'existe pas )
flutter create . --platforms web

# Étape 4: Nettoyer le projet (optionnel mais bonne pratique)
flutter clean

# 👇 ÉTAPE 5 : LA CORRECTION CRUCIALE - TÉLÉCHARGER LES DÉPENDANCES
# C'est cette ligne qui manquait et qui causait toutes les erreurs.
flutter pub get

# Étape 6: Construire le projet pour le web avec les clés Supabase
flutter build web --release --dart-define=SUPABASE_URL=$SUPABASE_URL --dart-define=SUPABASE_ANON_KEY=$SUPABASE_ANON_KEY
