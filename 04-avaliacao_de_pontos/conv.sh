#!/bin/bash

# Arkanon <arkanon@lsd.org.br>
# 2015/12/09 (Qua) 11:01:30 BRD
# 2015/11/27 (Sex) 09:18:56 BRD
# 2015/11/25 (Qua) 14:28:36 BRD
# 2015/11/25 (Wed) 01:04:28 BRS
# 2015/11/20 (Sex) 15:36:30 BRD
# 2015/11/17 (Tue) 06:42:31 BRD

# VAR f

  if [ $# = 0 ]
  then
    echo "${0##/*} <digits> [watch]"
    exit
  fi

  export dig=$1

  conv0()
  {
    local dots=$(eval printf '.%.0s' {1..$dig})
    (
      tail -n+4 $f | grep -v -- -- | sed '/^$/d' | uniq -c -s 89 -w 8
      echo
      tail -n2 $f | sed 's/^/      0 /'
    ) | cut -d\| -f1-4,6,8,9 | sed -r "s/([0-9])( +)/\1|\2/;s/(0\.36)(..)(..)($dots).+/\1 \2 \3 \4/"
  }

  conv1()
  {
    local  patt="%6d"
    local    c0=$(conv0)
    local  sums=$(head -n-3 <<< "$c0"            | cut -d\| -f1)
    local  kini=$(tail -n 4 <<< "$c0" | head -n1 | cut -d\| -f2)
    local blast=$(tail -n 2 <<< "$c0" | head -n1 | cut -d\| -f8 | cut -d\  -f4)
    local  last=$(tail -n 1 <<< "$c0"            | cut -d\| -f8 | cut -d\  -f4)
    local  more=$(( 10#$last / (10#$blast-10#$last) ))
    local  tim=$(( bc <<< "scale=1;$more*22" ))
    local  done=$(tail -n1 <<< "$sums")
    local  prev=$(( done + more ))
    local  kfin=$( printf "$patt" $(( kini + prev )) )
    local     n=$(( kfin * 10000 * 50 ))
     sums=$(
             head -n-1 <<< "$sums"
             printf " $patt\n" $prev
           )
    paste <(
             i1=0
             while read i2
             do
               printf "$patt\n" $((i2-i1))
               i1=$i2
             done < <( echo "$sums" )
             printf "\n$patt\n   ^\n   │\n FALTA" $more
           ) \
          <( echo -e "$sums\n\n$done\n    ^\n    │\n  FEITO" | cut -c3- ) \
          <( cut -d\| -f2- <<< "$c0"    | cut -c2- | sed "s/^$/\n$kfin|$n|<—— PREVISTO\n/g" ) \
    | sed -r 's/\|/   /g'
  }

  export -f conv0 conv1

  [ "$2" = watch ] && watch -n1 'bash -c "conv1 | tail -n $((LINES-3))"' || conv1

# EOF
