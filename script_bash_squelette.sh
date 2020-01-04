#!/bin/bash
# --------------------------------------------------------------------------
# DATE :20/12/2019
# AUT : SJL
# DES :
# MAJ :
# --------------------------------------------------------------------------

#---------------------------------------------------------
# Fonction de test des codes retour de la machine locale
#---------------------------------------------------------
check_return_code(){
echo " ----------------------------------- "
echo " PHASE :  $PHASE   RETCOD =  $RETCOD "
echo " ----------------------------------- "
if (( $RETCOD != 0 ))
then
         exit $RETCOD
fi
}

#---------------------------------------------------------
# Main : Début du shell
#---------------------------------------------------------

PHASE="INIT CODE RETOUR à ZERO  "
(( RETCOD = 0 ))
check_return_code

# A utiliser et adapter si des parametres sont a passer au shell (exemple ./script.sh parametre1)
# PHASE="test si le nombre de parametre est bon"
# if [[ $# != 1 ]] ; then
#    echo 'nombre de parametre invalide'
#    exit 100
# fi

PhASE="cd /"
cd /
(( RETCOD = $RETCOD + $? ))
check_return_code

exit $RETCOD
