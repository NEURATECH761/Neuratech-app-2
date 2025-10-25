#!/bin/bash

# Étape 1: Mettre à jour les dépendances Flutter
flutter pub get

# Étape 2: Construire le projet pour le web
flutter build web --release --dart-define=SUPABASE_URL=$SUPABASE_A_URL --dart-define=SUPABASE_ANON_KEY=$SUPABASE_A_ANON_KEY
