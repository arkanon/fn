# Arkanon <arkanon@lsd.org.br>
# 2015/11/25 (Qua) 13:12:08 BRD
# 2015/11/25 (Wed) 01:03:47 BRS
# 2015/11/18 (Wed) 19:22:38 BRD
# 2015/11/17 (Tue) 05:57:10 BRD

  export f=04-avaliacao_de_pontos-050dig-100000-010000-000050.log

  log0()
  {
    tail -n+4 $f | tr '|' '\t' | cut -f1-4,6,8,9 | sed -r 's/\t/    /g;s/(0\.36)(..)(..)(....)(...).+/\1 \2 \3 \4 \5.../'
  }
  export -f log0
  alias  log="watch -n1 'log0 | tail -n \$((LINES-3))'"

  alias conv="watch -n1 './conv.sh 5 | tail -n15 | head -n9; for i in {5..9}; do echo -e \"\n\n\"; ./conv.sh \$i | tail -n6 | sed \"/^\t*$/d\"; done'"

  alias  off="setterm --blank force"
  alias   on="setterm --blank poke"

# EOF
