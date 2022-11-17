#$!/bin/bash

function help()
{
cat help.txt
}

function show_usage()
{
 echo " trace.sh: [-h] [-T] [-t] [-n] [-N] [-d] [-m] [-s] chemin.." 
}



afficheFile() {
echo "donnez le nom de dossier"
read fich
    echo "le nom de dossier est : $fich " > fichier_journal.txt
    ls -l $fich | grep ^- | tr -s ' ' | cut -d ' ' -f9 >> fichier_journal.txt

}


afficheDirectory() {
echo "le nom de dossier est "
read dossier
    echo "le nom de dossier est : $dossier " > dossier_journal.txt
    ls -l $dossier | grep ^d | tr -s ' ' | cut -d ' ' -f9 >>dossier_journal.txt

}

NB() {
echo "donnez le dossier"
read dossier

    echo "nombre fichier" >> count.txt  


    find $dossier -type f | wc -l >> count.txt
 

 
find $dossier -type f | wc -l >> stat.txt


    
    echo "nombre dossier" >> count.txt 






    n=$(find $dossier -type d | wc -l) 

a=1 
	s=$(($n-$a))
 echo $s >> count.txt
 echo $s >> stat.txt


}

directoryUser() {

ls -l /etc/ | tr -s ' ' | cut -d ' ' -f1-5
}

dateAcess() {
    echo "donner le nom fichier"
    read access
    stat $access | grep Access | tail -n 1 >> date_journal.txt
}


dateModif() {
    echo "donner le nom fichier"
    read modif
    stat $modif | grep Modify > modif_journal
}
plot()
{

gnuplot -persist <<-EOFMaker
     set boxwidth 0.5
     set style fill solid
      
    
	 plot "stat.txt","stat.txt" using 1:3:xtic(2) with boxes


EOFMaker

}




menu ()
{ 
action=$(yad --width 1000 --entry --title "application" \
    --image=gnome-shutdown \
--center --on-top \
   --button="gtk-ok:0" --button="gtk-close:1" \
   --text "Choose action:" \
    --entry-text \
     "show_usage" "help" "afficheFile" "afficheDirectory" "NB" "directoryUser" "dateAcess" "dateModif" "stat" "retour" )
ret=$?

[[ $ret -eq 1 ]] && exit 0


case $action in 

show_usage*)show_usage
menu;;
help*) help 
menu;;
afficheFile*)afficheFile
menu;;
afficheDirectory*)afficheDirectory
menu;;
NB*)NB
menu;;
directoryUser*)directoryUser
menu;;
dateAcess*)dateAcess
menu;;
dateModif*)dateModif
menu;;
stat*)plot
menu;;
retour*)exit;;
*) echo"donner une valeur entre 1 et 7 "
menu;;


esac 

}
menu
