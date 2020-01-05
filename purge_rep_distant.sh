#!/bin/bash
# --------------------------------------------------------------------------
# DATE :    04/01/2020
# AUT :     SJL
# DES :     Purge recurcive d'un repertoire sur une machine distante
# MAJ :     N/A
# --------------------------------------------------------------------------

#---------------------------------------------------------
# Fonction de test des codes retour de la machine locale
#---------------------------------------------------------
check_return_code_local(){
    echo " ----------------------------------- "
    echo " PHASE :  $PHASE   RETCOD =  $RETCOD "
    echo " ----------------------------------- "
    if (( $RETCOD != 0 ))
    then
        exit $RETCOD
    fi
}

#---------------------------------------------------------------------------------------------------------------------------------------------------------------
# Main Fonction sur serveur distant SSH
#-------------------------------------------------------------------------------------------------------------------------------------------------------------
fonction_serveur_distant_ssh(){

    PHASE=" fonction_serveur_distant_ssh $MACHINE  "

    ssh $MACHINE -l ${USER} -p${PORT} <<!eof1

        #---------------------------------------------------------
        # Fonction de test des codes retour SSH
        #---------------------------------------------------------
        check_return_code_ssh(){
        echo " ----------------------------------- "
        echo " SSH_PHASE : sur $MACHINE  \$SSH_PHASE   SSH_RETCOD =  \$SSH_RETCOD "
        echo " ----------------------------------- "
        if (( \$SSH_RETCOD != 0 ))
            then
                 exit \$SSH_RETCOD
        fi
        }

        #---------------------------------------------------------
        # Main dans le ssh
        #---------------------------------------------------------

        SSH_PHASE=" INIT CODE RETOUR SSH à ZERO "
        (( SSH_RETCOD = 0 ))
        check_return_code_ssh

        SSH_PHASE="deplacement dans le repertoire"
        cd ${REPERTOIRE}
        (( SSH_RETCOD = \$SSH_RETCOD + \$? ))
        check_return_code_ssh

        SSH_PHASE="suppression des fichiers"
        find ${REPERTOIRE} -type f -mtime ${NB_JOURS} -maxdepth 1 -delete
        (( SSH_RETCOD = \$SSH_RETCOD + \$? ))
        check_return_code_ssh

!eof1

}
#----------------------------------------------------------------------------------------------------------------------------------------------
# Fin fonction_serveur_distant_ssh
#---------------------------------------------------------------------------------------------------------------------------------------------


#---------------------------------------------------------
# Main : Début du shell
#---------------------------------------------------------

MACHINE=$1
USER=$2
PORT=$3
REPERTOIRE=$4
#Nombre de jours a concerver
NB_JOURS=$5

 PHASE="test si le nombre de parametre est OK"
 if [[ $# != 5 ]] ; then
   echo 'nombre de parametre invalide\n'
   echo 'machine_distant user_serveur port_ssh repertoire nombre_de_jours_a_concerver'
   echo '\n purge_rep_distant.sh machine.distant root 22 /home/test/ 7'
   exit 100
 fi

PHASE="INIT CODE RETOUR à ZERO  "
(( RETCOD = 0 ))
check_return_code_local

PHASE="fonction_serveur_distant_ssh"
fonction_serveur_distant_ssh
(( RETCOD = $RETCOD + $? ))
check_return_code_local
