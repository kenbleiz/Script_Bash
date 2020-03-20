#!/bin/bash
# --------------------------------------------------------------------------
# DATE :    04/01/2020
# AUT :     SJL
# DES :     Purge non recurcive d'un repertoire
# MAJ :     N/A
# --------------------------------------------------------------------------

#---------------------------------------------------------
# Fonction de test des codes retour de la machine locale
#---------------------------------------------------------
check_return_code_local(){
    echo " ----------------------------------- "
    echo " PHASE :  $PHASE   RETCOD =  $RETCOD "
    echo " ----------------------------------- "
    if (( $RETCOD != 0 )); then
        exit $RETCOD
    fi
}

#---------------------------------------------------------
# Main : Début du shell
#---------------------------------------------------------

REPERTOIRE=$1
#Nombre de jours a concerver
NB_JOURS="+$2"

PHASE="INIT CODE RETOUR à ZERO  "
(( RETCOD = 0 ))
check_return_code_local

PHASE="test si le nombre de parametre est OK"
if [[ $# != 2 ]] ; then
    echo 'nombre de parametres invalide'
    exit 100
fi

PHASE="suppression des fichiers"
find ${REPERTOIRE} -maxdepth 1 -type f -mtime ${NB_JOURS} -delete
(( RETCOD = RETCOD + $? ))
check_return_code_local
