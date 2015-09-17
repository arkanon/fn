#!/bin/bash

# Arkanon <arkanon@lsd.org.br>
# 2015/09/17 (Qui) 15:11:28 BRS
# 2015/09/17 (Qui) 03:16:59 BRS
# 2014/03/23 (Sun) 12:43:47 BRS
# 2014/03/22 (Sat) 17:04:40 BRS
# 2014/03/22 (Sat) 05:13:07 BRS
#
#   Geração automatizada de GIF animado com as curvas da Função Exponencial Múltipla de Ordem 𝑛 – ƒₙ(𝑥) – para 𝑛∊[0,$n]⊂ℕ e 𝑥∊(0,1]⊂ℝ

if [ $# = 0 ]
then
  echo "Usage: ${0##*/} <prefix>"
  exit
fi

pref=$1            # início do nome dos frames e dos gifs

   n=$(ls -1 $pref* | wc -l)
   n=$((2*n-2))    # #frames (2x-2 a quantidade de gráficos)
 dig=3             # #digitos da sequencia de quadros
  nl=5             # #frames lentos
  i0=0             # frame inicial
  de=300           # delay dos frames extremos (centésimos de segundo)
  dl=100           # delay dos frames lentos
  dr=10            # delay dos frames rápidos

  pt="%0${dig}g"   # padrão do printf
  i1=$((n/2))      # frame final
  nr=$((n/2-nl-1)) # #frames rápidos

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
f=$( printf $pt $(( i1      )) )
g=$( printf $pt $(( i1 +  1 )) )
h=$( printf $pt $(( i1 + nr )) )
i=$( printf $pt $(( n  - nl )) )
j=$( printf $pt $(( n  -  1 )) )
eval \
 convert \
  -delay $de $pref$a.png       \
  -delay $dl $pref{$b..$c}.png \
  -delay $dr $pref{$d..$e}.png \
  -delay $de $pref$f.png       \
  -delay $dr $pref{$g..$h}.png \
  -delay $dl $pref{$i..$j}.png \
  ${pref}ori.gif

gifsicle -O3 -k32 -o ${pref}opt.gif ${pref}ori.gif # optimiza o gif animado

# EOF
