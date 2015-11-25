#!/bin/bash

# Arkanon <arkanon@lsd.org.br>
# 2015/11/20 (Sex) 15:36:30 BRD
# 2015/11/17 (Tue) 06:42:31 BRD

  if [ $# = 0 ]
  then
    echo "${0##/*} <digits> [watch]"
    exit
  fi

  export   f=03-avaliacao_de_pontos-050dig-40000-10000-00050.log
  export dig=$1

  conv0()
  {
    local dots=$(eval printf '.%.0s' {1..$dig})
    (
      tail -n+4 $f | grep -v -- -- | sed '/^$/d' | uniq -c -s 88 -w 8
      echo
      tail -n2 $f | sed 's/^/      0 /'
    ) | cut -d\| -f1-4,6,8,9 | sed -r "s/([0-9])( +)/\1|\2/;s/(0\.36)(..)(..)($dots).+/\1 \2 \3 \4/"
  }

  conv1()
  {
    local    c0=$(conv0)
    local  sums=$(head -n-3 <<< "$c0"            | cut -d\| -f1)
    local  kini=$(tail -n 4 <<< "$c0" | head -n1 | cut -d\| -f2)
    local blast=$(tail -n 2 <<< "$c0" | head -n1 | cut -d\| -f8 | cut -d\  -f4)
    local  last=$(tail -n 1 <<< "$c0"            | cut -d\| -f8 | cut -d\  -f4)
    local  more=$(( 10#$last / (10#$blast-10#$last) ))
    local  done=$(tail -n1 <<< "$sums")
    local  prev=$(( done + more ))
    local  kfin=$(( kini + prev ))
    local     n=$(( kfin * 10000 * 50 ))
     sums=$(
             head -n-1 <<< "$sums"
             printf "%7d\n" $prev
           )
    paste <(
             i1=0
             while read i2
             do
               printf "%6d\n" $((i2-i1))
               i1=$i2
             done < <( echo "$sums" )
             printf "\n%6d\n   ^\n   │\n FALTA" $more
           ) \
          <( echo -e "$sums\n\n$done\n    ^\n    │\n  FEITO" | cut -c3- ) \
          <( cut -d\| -f2- <<< "$c0"    | cut -c2- | sed "s/^$/\n$kfin|$n|<—— PREVISTO\n/g" ) \
    | sed -r 's/\|/   /g'
  }

  export -f conv0 conv1

  [ "$2" = watch ] && watch -n1 'bash -c "conv1 | tail -n $((LINES-3))"' || conv1

# EOF
