  Arkanon <arkanon@lsd.org.br>
  2015/10/18 (Sun) 02:32:12 BRT
  2015/10/13 (Tue) 02:36:31 BRS
  2015/09/17 (Thu) 21:00:00 BRS
  2015/09/17 (Thu) 15:13:43 BRS
  2015/09/17 (Thu) 06:53:01 BRS
  2015/09/13 (Sun) 20:40:15 BRS
  2015/09/13 (Sun) 00:54:55 BRS
  2015/09/12 (Sat) 14:22:44 BRS
  2015/09/12 (Sat) 04:21:21 BRS
  2015/09/11 (Fri) 22:26:12 BRS
  2014/03/24 (Mon) 02:58:17 BRS
  2014/03/23 (Sun) 13:27:40 BRS

- wxMaxima   15.04.0-1build1             dpkg -s wxMaxima | grep Version
- wxWidgets   3.0.2+dfsg-1.2             dpkg -s $(apt-cache search libwxbase$(ldd $(which wxmaxima) | sed -rn '/libwx_baseu-/s/\t[^0-9]+([0-9.]+).so.([0-9.]+).+/\1-\2/p') | grep -v dbg | cut -d\  -f1) | grep Version
- Maxima      5.36.1                     maxima --version
- GCL         2.6.12-14                  dpkg -s gcl | grep Version
- GnuPlot     5.0.1                      gnuplot --version | sed 's/ patchlevel /./'
- LUbuntu    15.10                       grep -w VERSION /etc/os-release
- Linux       4.2.0-16-generic #19 SMP   uname -srv
- Intel Core  Duo T2450 2.00GHz 32-bit   (spiderman)   LC_MESSAGES=C lscpu | grep -e op-mode -e name
- Intel Core2 Duo T6570 2.10GHz 64-bit   (venom)

- (http://en.wikipedia.org/wiki/tetration)
- (http://pt.wikipedia.org/wiki/tetração)
- (http://en.wikipedia.org/wiki/reuben_goodstein)
- (http://en.wikipedia.org/wiki/Lambert_W_function)

- (http://maxima-online.org/?inc=r-910537206)

- (http://brilliant.org/problems/numerical-integration-of-exponential-tetration/)
- (http://euler.rene-grothmann.de/Programs/22%20-%20Maxima%20-%20More%20Details.html)
- (http://go.helms-net.de/math/tetdocs/)
- (http://math.eretrandre.org/tetrationforum/)
- (http://mathworld.wolfram.com/PowerTower.html)
- (http://mathworld.wolfram.com/SophomoresDream.html)
- (http://mizugadro.mydns.jp/t/index.php/Tetration)
- (http://rosettacode.org/wiki/Numerical_integration/Gauss-Legendre_Quadrature#Maxima)
- (http://self.gutenberg.org/articles/euler's_infinite_tetration_theorem)

- (http://math.stackexchange.com/questions/108288/infinite-tetration-convergence-radius)
- (http://math.stackexchange.com/questions/1438567/questions-concerning-the-integration-of-integer-tetration)
- (http://math.stackexchange.com/questions/1438643/how-to-calculate-generalized-puiseux-series)
- (http://math.stackexchange.com/questions/205925/definite-integral-of-tetration-between-0-and-1)
- (http://math.stackexchange.com/questions/87870/are-the-solutions-of-xxxx-cdot-cdot-cdot-2-correct)

# EOF
</sub>
