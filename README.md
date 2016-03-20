# PL1516
Repositório para os trabalhos práticos de Processamento de Linguagens

## Requisitos para a compilação do relatório
  
  1. Python 2.6 ou superior (na linha de comandos $ python --version)
  2. Pygments instalado, de uma das seguintes formas:
  * $ sudo apt-get install python-pygments
  * $ sudo easy_install Pygments
  * $ pip install Pygments (caso for necessário $ sudo apt-get install pip).
  3. Ter o pacote mint instalado (usualmente já está na instalação do TeX). Se
     não estiver instalado:
  * $ sudo apt-get install texlive-latex-extra



**TODO** Para não esquecer de corrigir grupo na expressão regular do autor
**TODO** Adicionar código para tabela de hash e trie
**TODO** Adicionar resolução de caracteres de escape, bem como **tratamento de
maísculas nos títulos e nomes**



### Tabela de caracteres de escape

|Comando LaTeX  | Exemplo   |     Descrição
|---            |---        |---                                                                     |
|\`{o}          |   ò       |      grave accent                                                      |     
|\'{o}          |   ó       |      acute accent                                                      |        
|\^{o}          |   ô       |      circumflex                                                        |      
|\"{o}          |   ö       |      umlaut, trema or dieresis                                         |     
|\H{o}          |   ő       |      long Hungarian umlaut (double acute)                              |     
|\~{o}          |   õ       |      tilde                                                             |        
|\c{c}          |   ç       |      cedilla                                                           |   
|\k{a}          |   ą       |      ogonek                                                            | 
|\l{}           |   ł       |      barred l (l with stroke)                                          |  
|\={o}          |   ō       |      macron accent (a bar over the letter)                             |      
|\b{o}          |   o       |      bar under the letter                                              |    
|\.{o}          |   ȯ       |      dot over the letter                                               |  
|\d{u}          |   ụ       |      dot under the letter                                              | 
|\r{a}          |   å       |      ring over the letter (for å there is also the special command \aa)|  
|\u{o}          |   ŏ       |      breve over the letter                                             |  
|\v{s}          |   š       |      caron/háček ("v") over the letter                                 | 
|\t{oo}         |  o͡o       |     "tie" (inverted u) over the two letters                            |     
|\o             |   ø       |      slashed o (o with stroke)                                         |  
|---            |---        | ---                                                                      

To place a diacritic on top of an i or a j, its dot has to be removed. The dotless version of these letters is accomplished by typing \i and \j. For example:

    \^{\i} should be used for i circumflex 'î';
    \"{\i} should be used for i umlaut 'ï'.

### Caracteres concretizados 
  {á}{{\'a}}1 
  {é}{{\'e}}1 
  {í}{{\'i}}1 
  {ó}{{\'o}}1 
  {ú}{{\'u}}1
  {Á}{{\'A}}1 
  {É}{{\'E}}1 
  {Í}{{\'I}}1 
  {Ó}{{\'O}}1 
  {Ú}{{\'U}}1
  {à}{{\`a}}1 
  {è}{{\`e}}1 
  {ì}{{\`i}}1 
  {ò}{{\`o}}1 
  {ù}{{\`u}}1
  {À}{{\`A}}1 
  {È}{{\'E}}1 
  {Ì}{{\`I}}1 
  {Ò}{{\`O}}1 
  {Ù}{{\`U}}1
  {ä}{{\"a}}1 
  {ë}{{\"e}}1 
  {ï}{{\"i}}1 
  {ö}{{\"o}}1 
  {ü}{{\"u}}1
  {Ä}{{\"A}}1 
  {Ë}{{\"E}}1 
  {Ï}{{\"I}}1 
  {Ö}{{\"O}}1 
  {Ü}{{\"U}}1
  {â}{{\^a}}1 
  {ê}{{\^e}}1 
  {î}{{\^i}}1 
  {ô}{{\^o}}1 
  {û}{{\^u}}1
  {Â}{{\^A}}1 
  {Ê}{{\^E}}1 
  {Î}{{\^I}}1 
  {Ô}{{\^O}}1 
  {Û}{{\^U}}1
  {œ}{{\oe}}1 
  {Œ}{{\OE}}1 
  {æ}{{\ae}}1 
  {Æ}{{\AE}}1 
  {ß}{{\ss}}1
  {ű}{{\H{u}}}1 
  {Ű}{{\H{U}}}1 
  {ő}{{\H{o}}}1 
  {Ő}{{\H{O}}}1
  {ç}{{\c c}}1 
  {Ç}{{\c C}}1 
  {ø}{{\o}}1 
  {å}{{\r a}}1 
  {Å}{{\r A}}1
  {€}{{\EUR}}1 
  {£}{{\pounds}}1
