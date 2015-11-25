#!/bin/bash

# Arkanon <paulo.bagatini@softplan.com.br>
# 2015/11/20 (Fri) 20:45:00 BRD
# 2015/11/19 (Qui) 14:57:36 BRD

  f=03-avaliacao_de_pontos-050dig-40000-10000-00050.log

  for i in {99..78}
  do
    l=$(grep 0.3678$i $f | grep -v -- -- | cut -d\| -f5 | cut -d. -f1)
    n=$(wc   -l  <<< "$l")
    b=$(head -n1 <<< "$l")
    e=$(tail -n1 <<< "$l")
    s=$((e-b))
    printf '%i - %5i - %d %02d:%02d:%02d\n' $i $n $((s/60/60/24)) $((s%(60*60*24)/60/60)) $((s%(60*60)/60)) $((s%60))
  done

# EOF
