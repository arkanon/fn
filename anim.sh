#!/bin/bash

# Arkanon <arkanon@lsd.org.br>
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

  pref=$1            # início do nome dos frames e dos gifs

     n=$(ls -1 $pref* | wc -l)

     n=$((2*n-2))    # quantidade de frames
    nl=5             # quantidade de frames lentos
    nr=$((n/2-nl-1)) # quantidade de frames rápidos

    di=300           # delay no  frame  inicial (𝑛=0, centésimos de segundo)
    dl=100           # delay nos frames lentos
    dr=10            # delay nos frames rápidos
    df=500           # delay no  frame  final   (𝑛 máximo)

    fi=0             # frame inicial
    ff=$((n/2))      # frame final

   dig=3             # quantidade de dígitos da sequencia de quadros
    pt="%0${dig}g"   # padrão do printf

  # repete os quadros intermediários na ordem inversa para que a animação ocorra nos dois sentidos da variação do parâmetro da ordem de ƒₙ(𝑥)
  for a in $(seq -f $pt $((n/2-1)) -1 1)
  do
    b=$(printf $pt $((n-10#$a)))
    ( [ ! -e $pref$b.png -o -L $pref$b.png ] ) && ln -fs ${pref##*/}$a.png $pref$b.png
  done

  # monta o gif animado com os quadros, com delays variados entre eles
  a=000
  b=001
  c=$( printf $pt $(( nl      )) )
  d=$( printf $pt $(( nl +  1 )) )
  e=$( printf $pt $(( nl + nr )) )
  f=$( printf $pt $(( ff      )) )
  g=$( printf $pt $(( ff +  1 )) )
  h=$( printf $pt $(( ff + nr )) )
  i=$( printf $pt $(( n  - nl )) )
  j=$( printf $pt $(( n  -  1 )) )
  eval \
   convert \
    -delay $di $pref$a.png       \
    -delay $dl $pref{$b..$c}.png \
    -delay $dr $pref{$d..$e}.png \
    -delay $df $pref$f.png       \
    -delay $dr $pref{$g..$h}.png \
    -delay $dl $pref{$i..$j}.png \
    ${pref}ori.gif

  gifsicle -O3 -k32 -o ${pref}opt.gif ${pref}ori.gif # optimiza o gif animado

# EOF
