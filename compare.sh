#!/bin/bash

# Arkanon <arkanon@lsd.org.br>
# 2015/11/27 (Sex) 09:18:51 BRD
# 2015/11/25 (Qua) 13:12:17 BRD
# 2015/11/25 (Wed) 01:04:05 BRS
# 2015/11/14 (Sat) 01:37:36 BRD
# 2015/11/13 (Sex) 16:03:51 BRD
# 2015/11/13 (Sex) 10:23:00 BRD

# float usa 16 digitos apos a virgula por default (0.36792408175633207)
# mas a correção comparada com o uso de bfloat tem se mantido apenas ate 7 digitos

  reffile=$HOME/git/f/04-avaliacao_de_pontos-500dig-100000-010000-000050.log

  if (( $# < 2 ))
  then
    echo "Usage: ${0##*/} <log file> <sigfig size> [watch]"
    exit
  fi

  if [ "$3" = watch ]
  then
    watch -n1 "$0 $1 $2"
    exit
  fi

     file=$1
   sigfig=$2

    LINES=$(tput lines)

  (

    cd $HOME/git/f/

    cat $reffile | cut -d\| -f9 | cut -c-$((2+sigfig)) | sed '/^$/d' >| zreference.txt
    cat $file    | cut -d\| -f9 | cut -c-$((2+sigfig)) | sed '/^$/d' >| zcompare1.txt

    n=$(cat zcompare1.txt | wc -l)

    diff zcompare1.txt <(head -n $n zreference.txt)

    cat zcompare1.txt | sed -r 's/(0\.36)(..)(..)(...)(...)/\1 \2 \3 \4 \5/' >| zcompare2.txt

    echo -e "$n\n"
    tail -n $((LINES-5)) zcompare2.txt

  )

# EOF
