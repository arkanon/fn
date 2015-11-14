alias log="watch \"cat 03-avaliacao_de_pontos-050dig-10000-10000-00050.log | tail -n+4 | tr '|' '\t' | cut -f1-4,6,8,9 | sed -r 's/\t/    /g;s/(0\.36)(..)(..)(...)(...).+/\1 \2 \3 \4 \5.../' | tail -n $((LINES-3))\""
alias off="setterm --blank force"
alias  on="setterm --blank poke"
