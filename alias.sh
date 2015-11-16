
  f=03-avaliacao_de_pontos-050dig-10000-10000-00050.log
  alias conv="watch -n1 \"( cat $f | sed '/^$/d' | uniq -c -s 87 -w 8; echo; tail -n2 $f | sed 's/^/      /' ) | cut -c-107 | cut -d\| -f1-4,6,8,9 | sed -r 's/\|/   /g;s/(0\.36)(..)(..)(....)/\1 \2 \3 \4/' | tail -n $((LINES-3))\""
# alias conv="watch -n1 \"cat 03-avaliacao_de_pontos-padrao_de_convergencia.log   | sed '/^$/d' | uniq -c -s103 -w10 | cut -c-125 | tail -n $((LINES-3))\""

  alias  log="watch -n1 \"cat $f | tail -n+4 | tr '|' '\t' | cut -f1-4,6,8,9 | sed -r 's/\t/    /g;s/(0\.36)(..)(..)(....)(...).+/\1 \2 \3 \4 \5.../' | tail -n $((LINES-3))\""


  alias  off="setterm --blank force"
  alias   on="setterm --blank poke"

