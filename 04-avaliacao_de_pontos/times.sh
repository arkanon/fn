#!/bin/bash

# Arkanon <paulo.bagatini@softplan.com.br>
# 2015/12/09 (Qua) 11:01:47 BRD
# 2015/11/28 (Sat) 04:16:49 BRD
# 2015/11/27 (Sex) 12:27:59 BRD
# 2015/11/25 (Qua) 13:12:47 BRD
# 2015/11/25 (Wed) 01:05:12 BRS
# 2015/11/20 (Fri) 20:45:00 BRD
# 2015/11/19 (Qui) 14:57:36 BRD

# VAR f

  for i in {99..79}
  do
    l=$(grep -F 0.3678$i $f | grep -v -- -- | cut -d\| -f5 | cut -d. -f1)
    n=$(wc   -l  <<< "$l")
    b=$(head -n1 <<< "$l")
    e=$(tail -n1 <<< "$l")
    s=$((e-b))
    printf '%i - %5i - %d %02d:%02d:%02d\n' $i $n $((s/60/60/24)) $((s%(60*60*24)/60/60)) $((s%(60*60)/60)) $((s%60))
  done

# EOF
