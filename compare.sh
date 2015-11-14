#!/bin/bash

# Arkanon <arkanon@lsd.org.br>
# 2015/11/14 (Sat) 00:20:55 BRS
# 2015/11/13 (Sex) 16:03:51 BRD
# 2015/11/13 (Sex) 10:23:00 BRD

# float usa 16 digitos apos a virgula por default (0.36792408175633207)
# mas a correção comparada com o uso de bfloat tem se mantido apenas ate 7 digitos

  if (( $# < 2 ))
  then
    echo "Usage: ${0##*/} <log file> <sigfig size>"
    exit
  fi

     file=$1
   sigfig=$2

  reffile=03-avaliacao_de_pontos-500dig-10000-10000-00050.log
    LINES=$(tput lines)

  cat $reffile | cut -d\| -f9 | cut -c-$((2+sigfig)) | sed '/^$/d' >| zreference.txt
  cat $file    | cut -d\| -f9 | cut -c-$((2+sigfig)) | sed '/^$/d' >| zcompare1.txt

  n=$(cat zcompare1.txt | wc -l)

  diff zcompare1.txt <(head -n $n zreference.txt)

  cat zcompare1.txt | sed -r "s/(0\.36)(..)(..)(.)/\1 \2 \3 \4/" >| zcompare2.txt

  echo -e "\n$n\n"
  tail -n $((LINES-5)) zcompare2.txt
  echo

# EOF