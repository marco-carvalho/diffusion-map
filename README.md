# Redução de dimensionalidade por meio da técnica Diffusion Maps

## Resumo

Em diversas áreas das ciências, existem informações apresentadas em inúmeros formatos e diferentes escalas.
A primeira vista, alguns desses dados podem ser interpretados de forma confusa.
Felizmente, é possível representar conhecimentos dispostos em alta dimensão para representações em baixa dimensão.
Dessa forma, essas mesmas informações podem ser dispostas de forma organizada.
Nesse projeto de pesquisa, o método utilizado para exemplificar essa situação se chama Diffusion Map.
Conceitos como distância euclidiana, normalização de dados, matrizes diagonais e transpostas serão abordados.
Ademais, autovalores e autovetores, k-means e medidas da teoria da informação, como pureza e informação mútua, serão necessários para uma compreensão apurada da origem do projeto até o resultado final.
Ao fim da implementação do algoritmo, a avaliação de agrupamento NMI (normalized mutual information) foi operada com a finalidade de ser responsável pela validação dos resultados.
A partir dessa avaliação, foi concluído que o resultado do projeto possui níveis satisfatórios de aceitação.

Palavras chaves: diffusion map, redução de dimensionalidade, k-means, NMI.

## Sumário

1. [Introdução](#introdução)
2. [Objetivo](#objetivo)
3. [Material e Métodos](#material-e-métodos)
    1. [Decisões do Projeto](#decisões-do-projeto)
    2. [Elaboração da Solução](#elaboração-da-solução)
4. [Considerações Parciais](#considerações-parciais)
    1. [Diffusion Map](#diffusion-map)
    2. [K-means e NMI](#k-means-e-nmi)
5. [Conclusões](#conclusões)

## Introdução

O Diffusion Map pode ser descrito como um framework de redução de dimensionalidade ou de extração de funcionalidade \cite{coifman2006diffusion}, e é usado para a organização geométrica estrutural multi-escala de gráficos e subconjuntos do $\rm I\!R^{n}$\cite{coifman2005geometric}.
O primeiro é o processo de reduzir um número de variáveis aleatórias em um dataset.
Pode ser aplicado para facilidade na visualização de dados, otimização do desempenho em alguns modelos de aprendizagem de máquina e, consequentemente, deixa de ser uma necessidade possuir grandes espaços de armazenamento.
O segundo pode ser explicado como a criação de valores com propósitos informativos, a partir de um dataset, e utilizados para interpretações apuradas.
De certa forma, envolve em reduzir a quantidade de recursos necessários para se ter uma completa descrição de uma massa de dados, ainda mantendo a precisão necessária.

## Objetivo

O projeto de pesquisa tem como objetivo testar o efeito da redução de dimensionalidade sobre agrupamentos, em termos de qualidade e de tempo.

## Material e Métodos

A linguagem de programação utilizada para o projeto foi R\cite{R}.
Ela foi escolhida devido aos diversos métodos e pacotes nativos da linguagem.
Para facilitar o desenvolvimento na linguagem, o RStudio Desktop, ambiente integrado de desenvolvimento (IDE) mais popular da linguagem, foi escolhido para se gerar os resultados.

Para realizar a implementação do algoritmo Diffusion Map, é necessário descrever conceitos relativos ao framework e seguir alguns passos.

### Diffusion Map

Utilizando uma matriz X gerada aleatoriamente, com 4 propriedades e 20 amostras, deve-se:

1. Normalizar cada coluna da matriz $X$ em uma matriz temporária $T1$.
2. Calcular a distância euclidiana da matriz temporária $T1$ em uma outra matriz temporária $T2$.

    A expressão para o cálculo da mesma pode ser intepretada como $d_{ij}=x_{i}-x_{j}$, onde $T2$ é simétrica ($x_{ij}=x_{ji}$).

3. Computar a matriz diagonal $D$.
4. Normalizar a matriz resultante $X$ utilizando o parâmetro $a$ com um valor experimental de $0.5$.
5. Determinar a matriz normalizada $M$.

    Utilizando a transposta da matriz $M$, deve-se inferir os autovalores e autovetores, sendo o último utilizado como as coordenadas para os dados.
    O Diffusion Map pode ser definido através da seguinte expressão:

### K-means e NMI

Para que os resultados sejam validados, é necessário utilizar o método de quantização vetorial k-means para extrair os agrupamentos das coordenadas de dimensão $n$, bem como definir o número $k$ de agrupamentos.

Após isso, é preciso definir a informação mútua $I$ e a entropia $H$.
A primeira mede a quantidade de informação que a presença/ausência de um termo contribui para a decisão correta de classificação,
A segunda usa um conjunto de dados como entrada e calcula a entropia de acordo com o método de estimador de entropia.
Utilizando ambos, deve-se calcular o NMI através da expressão a seguir:

Para validar a implementação e eficácia do método utilizado, o NMI deve ser comparado com o valor de pureza.
Os agrupamentos defeituosos têm valores de pureza próximos de 0, enquanto que um agrupamento perfeito tem uma pureza de 1.

## Discussões e Resultados

O dataset multivariante de flores Iris\cite{fisher1936use} foi utilizado como objeto de entrada para esse método.
Adicionalmente, foi utilizado um dataset formado por características de corpos celestes, como coordenadas e informações relacionadas ao brilho.

Utilizando os datasets supracitados durante a implementação, os autovetores gerados foram utilizados para plotagem (ver Figura 1 e Figura 2).

* {range} e \textit{diff} para normalização das colunas da matriz;
* {colSums} e \textit{diag} para a matriz ser computada diagonalmente;
* {\%*\%} para multiplicação das matrizes;
* {solve} para o cálculo da matriz inversa;
* {t} para descobrir a matriz transposta;
* {eigen} para identificação da lista dos autovalores e autovetores

## Conclusões

Com as medidas relativas a teoria da informação apontando para níveis satisfatórios, é possível afirmar que o projeto de pesquisa obteve resultados satisfatórios.
É encorajado a utilização em outros datasets e matrizes para descoberta de novos resultados.
Deve-se também verificar a utilização do método hungaro, para resolução de problemas de otimização.
