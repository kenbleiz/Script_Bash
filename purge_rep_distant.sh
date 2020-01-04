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

    ssh $MACHINE -l root <<!eof1

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
REPERTOIRE=$3
#Nombre de jours a concerver
NB_JOURS=$4

 PHASE="test si le nombre de parametre est OK"
 if [[ $# != 4 ]] ; then
   echo 'nombre de parametre invalide'
   exit 100
 fi

PHASE="INIT CODE RETOUR à ZERO  "
(( RETCOD = 0 ))
check_return_code_local

PHASE="fonction_serveur_distant_ssh"
fonction_serveur_distant_ssh
(( RETCOD = $RETCOD + $? ))
check_return_code_local

exit $RETCOD
#!/bin/bash
# --------------------------------------------------------------------------
# DATE :
# AUT :
# DES :
# MAJ :
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

    ssh $MACHINE -l ${USER} <<!eof1

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



        SSH_PHASE="actions "
        #Actions
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

MACHINE=nom_serveur

# A utiliser et adapter si des parametres sont a passer au shell (exemple .\script.sh parametre1)
# PHASE="test si le nombre de parametre est OK"
# if [[ $# != 1 ]] ; then
#   echo 'nombre de parametre invalide'
#   exit 100
# fi

PHASE="INIT CODE RETOUR à ZERO  "
(( RETCOD = 0 ))
check_return_code_local

PHASE="fonction_serveur_distant_ssh"
fonction_serveur_distant_ssh
(( RETCOD = $RETCOD + $? ))
check_return_code_local

exit $RETCOD
