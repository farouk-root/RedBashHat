#!/bin/bash

. "les_fonctions"

if [[ $# -eq 0 ]]	# Check if there is no options input
then
	show_usage
	exit 1               
fi


while getopts "hgvm" option 
do
	case $option in
		h)
		    display_help
			;;

		g)
			echo "option g"
./graphique.sh
			;;

		v)
			echo "option v"
auteurs
			;;


		m)

			echo "option m"
text_menu

			;;

		*)	# Trigger when an unknown option is unput or when an argument is missing
			echo -e "Error: Unknown option"
			show_usage
			;;
			
	esac
done

exit 0
