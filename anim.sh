#!/bin/bash

# Arkanon <arkanon@lsd.org.br>
# 2015/10/21 (Wed) 23:20:06 BRST
# 2015/09/23 (Qua) 01:41:44 BRS
# 2015/09/18 (Sex) 01:24:14 BRS
# 2015/09/17 (Qui) 15:11:28 BRS
# 2015/09/17 (Qui) 03:16:59 BRS
# 2014/03/23 (Sun) 12:43:47 BRS
# 2014/03/22 (Sat) 17:04:40 BRS
# 2014/03/22 (Sat) 05:13:07 BRS
#
# Geração automatizada de GIF animado com as curvas da Função Exponencial Múltipla de Ordem 𝑛 – ƒₙ(𝑥) – para 𝑛∊[0,$n]⊂ ℕ e 𝑥∊(0,1]⊂ ℝ

  if [ $# = 0 ]
  then
    echo "Usage: ${0##*/} <prefix>"
    exit
  fi

  pref=$1          # início do nome dos frames e dos gifs

     n=$(find ${pref%/*} -type f -name "${pref##*/}*.png" | wc -l)
                   # quantidade de frames diferentes (metade da animação)
    nl=5           # quantidade de frames lentos
    nr=$((n-nl-1)) # quantidade de frames rápidos

    di=300         # delay no  frame  inicial (𝑛=0, centésimos de segundo)
    dl=100         # delay nos frames lentos
    dr=5           # delay nos frames rápidos
    df=500         # delay no  frame  final   (𝑛 máximo)

   dig=4           # quantidade de dígitos da sequencia de quadros
    pt="%0${dig}g" # padrão do printf

  # agrupa os quadros de acordo com os delays
  a=0000                           # frame extremo inicial
  b=0002                           # primeiro frame lento
  c=$(printf $pt $((2*(nl     )))) # ultimo frame lento
  d=$(printf $pt $((2*(nl+1   )))) # primeiro frame rápido
  e=$(printf $pt $((2*(nl+nr-1)))) #
  f=$(printf $pt $((2*( n-1   )))) # frame extremo final (meio da animação)

  echo "
delay $di $pref$a.png
delay $dl $pref{$b..$c..2}.png
delay $dr $pref{$d..$e..2}.png
delay $df $pref$f.png
delay $dr $pref{$e..$d..-2}.png
delay $dl $pref{$c..$b..-2}.png
"

read -p "ENTER para continuar, CTRL-C para cancelar. "

  # usa os quadros na ordem e na ordem inversa para que a animação ocorra nos dois sentidos da variação do parâmetro da ordem de ƒₙ(𝑥)
  export TIMEFORMAT="%lR"
  time eval \
   convert \
    -delay $di $pref$a.png           \
    -delay $dl $pref{$b..$c..2}.png  \
    -delay $dr $pref{$d..$e..2}.png  \
    -delay $df $pref$f.png           \
    -delay $dr $pref{$e..$d..-2}.png \
    -delay $dl $pref{$c..$b..-2}.png \
    ${pref}ori.gif

  gifsicle -O3 -k32 -o ${pref}opt.gif ${pref}ori.gif # optimiza o gif animado

# EOF
