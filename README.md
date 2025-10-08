# Wallpapers Rotation Fedora KDE

Ce script Bash permet de faire tourner automatiquement les fonds d'écran (wallpapers) sur un environnement de bureau KDE sous Fedora.  
Ce script gère uniquement la rotation entre deux fonds d'écran : un pour le jour et un pour la nuit.

## Fonctionnalités
- Change automatiquement le fond d'écran à intervalles réguliers
- Compatible avec l'environnement KDE Plasma
- Facile à configurer et à utiliser

## Utilisation

1. **Render le script exécutable :**
   ```bash
   chmod +x wallper-rotation.sh
   ```  
   
2. **Lancer le script d'installation :**
   ```bash
   ./wallper-rotation.sh
   ```

   Cela installe automatiquement le service et le timer systemd utilisateur, qui assurent la rotation automatique du fond d'écran à chaque démarrage de session et toutes les heures.

3. **Tester le script :**  
  
    Une fois le script installé sous le nom wallpaper-rotation dans /usr/local/bin, tu peux le lancer manuellement en lui passant une heure en argument pour simuler le comportement à ce moment-là.  

    Exemple pour simuler le fond qui serait appliqué à 22H00 :  
    ```bash
   ./usr/local/bin/wallper-rotation.sh 22
   ```

4. **Désinstallation :**
   ```bash
   ./usr/local/bin/wallper-rotation.sh --uninstall
   ```
   Cela supprime le service, le timer et le script associé.

## Prérequis
- Fedora (testé sur Fedora 38+)
- Environnement de bureau KDE Plasma
- Bash

## Personnalisation
- Modifiez le chemin du dossier contenant vos images dans le script.
- Ajustez l'intervalle de rotation selon vos préférences.

## Auteurs
- Fabe59

## Licence
Ce projet est open source
