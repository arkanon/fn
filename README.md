Função Exponencial Múltipla
===========================

Análise da (por mim nomeada) Função Exponencial Múltipla de Ordem 𝑛 – 𝑓ₙ(𝑥) – para 𝑛∊[0,401]⊂ℕ e 𝑥∊[0,1]⊂ℝ, conhecida oficialmente por Função de [Tetração](http://pt.wikipedia.org/wiki/Tetração)

--

Em 1993, na época em que cursava Matemática na UFRGS e prestava o serviço militar no CPOR de Porto Alegre, comecei um belo dia a pensar na função y=xˣ. Fiz isso durante uma das limpezas no fuzil, no quartel :-p

Não tem como olhar para xˣ e não pensar na extrapolação
x elevado na x elevado na x elevado na x elevado na x...
n vezes.

Enquanto desmontava e montava o FAL, fui mentalmente avaliando o provável comportamento da função.
Evidentemente para x>1 ela cresce estupidamente rápido, não tem nem porque perder muito tempo ali.
Para x<1, temos raízes de números negativos, ou seja, a coisa descamba para o conjunto dos números complexos.
Não, se houvesse algo interessante na função, finito e pertencente aos reais, provavelmente seria entre 0 e 1, pelo menos para um cara pé no chão como eu :-p

Em x=0 a função não tem valor definido: se temos x elevado na x (2 vezes o x), ele tende a y=1. Se temos x elevado na x elevado na x (3 vezes o x), ela tende a y=0.
Isso foi fácil de "ver" na época, hoje não lembro mais suficientemente das aulas de cálculo para fazê-lo mentalmente :-p.

Em x=1, ela vale y=1, não importa quantas vezes x seja elevado na x.

E entre 0 e 1? Eu já tinha visto o gráfico de xˣ uma vez, acho que no livro de Cálculo. Tinha uma "barriga" para baixo, nessa região.
Mas e a função x na x na x? Se o limite dela em 0 é 0 e em 1 ela vale 1, diferentemente da x na x, ela precisaria obrigatoriamente subir, possivelmente por um caminho monótono (sem descer nunca).
Ela ficaria abaixo da barriga de x na x, ou a ultrapassaria em algum momento, nesse intervalo de x entre 0 e 1?

E x na x na x na x (4 vezes)? Tende a y=1, em x=0. Ela aumentaria a barriga de x na x (2 vezes), ou diminuiria? Em outras palavras: x na x na x na x fica acima ou abaixo de x na x?
E a função com 5 x's?
E a com 6?

Isso tudo eu ia pensando enquando desmontava, limpava e remontava o fuzil, totalmente alheiro a zona a mina volta... :-p

De repente um raio abriu minha cabeça: números (positivos) menores que 1 elevados a um expoente maior que 1 resultam em um número menor eles mesmos:

```
x<1 -> x=1/n, n>1
                   ___
 x    /1\1/n   n  | 1       1
x  = | - |   =  \ | -  = n ---
      \n/        \| n     \|n
```

Se n>1, a raiz n-ésima de n é menor que n, portanto, o inverso dela é maior que o inverso de n.
Mas o inverso de n é x, então x^x>x, para x<1

MAS, elevados a um expoente MENOR que 1, resultam em um número MAIOR que eles mesmos.

(continua...)
