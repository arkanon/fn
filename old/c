fpprec  :  72$
n       :  10$
size    : 900$
i0      :   0$
i1      : n/2$

f(n,x)  := if     ( x<=0 and remainder(n,2) = 1         ) then 0
           elseif ( x<=0 and remainder(n,2) = 0 or n<=0 ) then 1
                                                          else x^f(n-1,x)$

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
    x2  : find_root(d1,x,0.01,1),
    y2  : ev(f1,x=x2),
    min : append(min,[[x2,y2]]),
    cor : append(cor,[black]),
    i   : i+2
  ),
  [min,cor]
)$

set     : minset(n)$
minimos : set[1]$
cores   : set[2]$

i : i0$
while (i<=i1) do
(
  if (i< 10) then z1 : 0 else z1 : "",
  if (i<100) then z2 : 0 else z2 : "",
  plot2d
  (
    [ f(2*i,x), f(2*i+1,x), [ discrete, minimos ] ],
    [ x, 0, 1 ],
    [ legend, concat("f",2*i,"(x)"), concat("f",2*i+1,"(x)"), "Min Set" ],
    cores,
    [ style, lines, lines, dots ],
    [ box,              false ],
    [ plot_format,      gnuplot ],
    [ gnuplot_preamble, "set size ratio 1" ],
    [ gnuplot_term,     concat( "pngcairo enhanced size ",size,",",size  ) ],
    [ gnuplot_out_file, concat( "frame-",n,"-",size,"px-",z2,z1,i,".png" ) ]
  ),
  i : i+1
)$

