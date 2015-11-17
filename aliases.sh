# Arkanon <arkanon@lsd.org.br>
# 2015/11/17 (Tue) 05:57:10 BRD

  export f=03-avaliacao_de_pontos-050dig-40000-10000-00050.log

  log0()
  {
    tail -n+4 $f | tr '|' '\t' | cut -f1-4,6,8,9 | sed -r 's/\t/    /g;s/(0\.36)(..)(..)(....)(...).+/\1 \2 \3 \4 \5.../'
  }
  export -f log0
  alias  log="watch -n1 'log0 | tail -n \$((LINES-3))'"

  alias conv="watch -n1 'for i in {4..8}; do ./conv.sh \$i | tail -n9; echo -e \"\n\n\"; done'"

  alias  off="setterm --blank force"
  alias   on="setterm --blank poke"

# EOF
