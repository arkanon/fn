#!/bin/bash

# Arkanon <arkanon@lsd.org.br>
# 2014/03/22 (Sat) 17:04:40 (BRS)
# 2014/03/22 (Sat) 05:13:07 (BRS)
#
#   Geracao automatizada de GIF animado com as curvas da Função Exponencial Múltipla de Ordem 𝑛 – 𝑓ₙ(𝑥) – para 𝑛∊[0,$n]⊂ℕ e 𝑥∊[0,1]⊂ℝ
#
#   n=500, size=900, com bfloat: 04:15:53.00
#   n=500, size=900, sem bfloat: 00:27:17.59
#   n=500, size=300, sem bfloat: 00:25:30.32



### PARAMETROS ###

  if [ $(uname -p) = x86_64 ]
  then
           # limite recursao com bfloat 2x:
           #   32 bit -  118
           #   64 bit - 1979
     n=200 # #graficos (limitada pela #recursoes maxima), plotados 2 a 2
           # a #frames diferentes sera a metade + 1, mas com a repeticao inversa no final da animacao, a #frames total sera $n
    nl=20  # #frames lentos (os primeiros/ultimos $nl)
  else
     n=40
    nl=10
  fi

     dig=3   # quandidade de digitos da sequencia de quadros
    size=900 # tamanho da imagem quadrada (pixels)
#   size=300
      i0=0   # frame inicial
      de=400 # delay dos frames extremos (centesimos de segundo)
      dl=150 # delay dos frames lentos
      dr=1   # delay dos frames rapidos

# bfloat='bfloat'     # se descomentado, string sera comando bfloat para o maxima
  fpprec='fpprec:72$' # precisao das operacoes em ponto flutuante big float para o maxima

  legend='concat("f",2*i,"(x)"), concat("f",2*i+1,"(x)"), "Min Set"'
# legend='false'

  prefix=image/frames-$n-${size}px/frame-$n-${size}px # caminho e prefixo do nome dos quadros gif
  anigif=image/fn-$n-${size}px                        # caminho e nome do arquivo do gif animado

### FIM PARAMETROS ###



sudo apt-get install maxima imagemagick gifsicle

pt="%0${dig}g"   # padrao do printf
i1=$((n/2))      # frame final
nr=$((n/2-nl-1)) # #frames rapidos

mkdir -p $(dirname $prefix)
mkdir -p $(dirname $anigif)



# gera os quadros da animacao
#
# acompanhar com
#   watch -cbn1 "ls -laFGr --color --time-style=+%T"

cat << EOT | maxima -q

$fpprec

n    : $n$
size : $size$
i0   : $i0$
i1   : $i1$

f(n,x) := if     ( x<=0 and remainder(n,2) = 1         ) then 0
          elseif ( x<=0 and remainder(n,2) = 0 or n<=0 ) then 1
                                                         else $bfloat(x^$bfloat(f(n-1,x)))$

minset(n) := block
(
  [
    f1  : 1,
    i   : 2,
    x2  : 0,
    y2  : 0,
    min : [],
    cor : [color,blue,red]
  ],
  while (i<=n) do
  (
    f0  : x^f1,
    f1  : x^f0,
    d1  : diff(f1,x),
    x2  : $bfloat(find_root(d1,x,0.01,1)),
    y2  : $bfloat(ev(f1,x=x2)),
    min : append(min,[[x2,y2]]),
    cor : append(cor,[black]),
    i   : i+2
  ),
  [min,cor]
)$

set     : minset(n)$
minimos : set[1]$
cores   : set[2]$

/*
minimos[1];
last(minimos);
length(minimos);
*/

i : i0$
while (i<=i1) do
(
  if (i< 10) then z1 : 0 else z1 : "",
  if (i<100) then z2 : 0 else z2 : "",
  plot2d
  (
    [ f(2*i,x), f(2*i+1,x), [ discrete, minimos ] ],
    [ x, 0, 1 ],
    [ legend, $legend ],
    cores,
    [ style, lines, lines, dots ],
    [ box,              false ],
    [ plot_format,      gnuplot ],
    [ gnuplot_preamble, "set size ratio 1" ],
    [ gnuplot_term,     concat("pngcairo enhanced size ",size,",",size) ],
    [ gnuplot_out_file, concat("$prefix-",z2,z1,i,".png") ]
  ),
  i : i+1
)$

EOT



# repete os quadros intermediarios na ordem inversa para que a animacao ocorra nos dois sentidos da variacao do parametro da ordem de 𝑓ₙ(𝑥)
for a in $(seq -f $pt $((n/2-1)) -1 1)
do
  b=$(printf $pt $((n-10#$a)))
  ln -fs $(basename $prefix)-$a.png $prefix-$b.png
done

# 04:14:48.00   @hercules   7.506.016 B



# monta um gif animado com os quadros, com delays variados entre eles
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

echo
echo "n=$n, nl=$nl, nr=$nr, i1=$i1"
echo "$a $b $c $d $e $f $g $h $i $j"

eval \
 convert \
  -delay $de $prefix-$a.png       \
  -delay $dl $prefix-{$b..$c}.png \
  -delay $dr $prefix-{$d..$e}.png \
  -delay $de $prefix-$f.png       \
  -delay $dr $prefix-{$g..$h}.png \
  -delay $dl $prefix-{$i..$j}.png \
  $anigif.gif
# 00:01:42.17   @hercules   5.559.522 B



# optimiza o gif animado
gifsicle -O3 -k32 -o $anigif-opt.gif $anigif.gif
#   0   00:00:31.21   @hercules    v1.62   256 cores   2.027.835 B   2.74
#   -----------------------------------------------------------------------------------
#                                                      5.559.522 B
#   1   00:00:48.00   @spiderman   v1.67     n cores   2.931.251 B   1.89   2.628.271 B
#   2   00:01:10.69   @spiderman   v1.67   256 cores   2.000.754 B   2.77     930.497 B
#   3   00:01:14.40   @spiderman   v1.67   128 cores   1.679.325 B   3.31     321.429 B
#   4   00:01:12.38   @spiderman   v1.67    64 cores   1.422.927 B   3.90     256.398 B
#   5   00:01:06.44   @spiderman   v1.67    32 cores   1.225.896 B   4.53     197.031 B   <---
#   6   00:01:08.26   @spiderman   v1.67    16 cores   1.092.214 B   5.09     133.682 B



# EOF
