# PL1516
Repositório para os trabalhos práticos de Processamento de Linguagens

MiEI::PL15::TP1::72628BrunoPereira

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
maísculas nos títulos e nomes, bem como em \\~{} e \\.**



### Tabela de caracteres de escape

|Comando LaTeX  | Exemplo   |     Descrição
|---            |---        |---                                                                     |
|\\`{o}          |   ò       |      grave accent                                                      |     
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
|\\.{o}          |   ȯ       |      dot over the letter                                               |  
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

  á | \\'a     
  é | \\'e     
  í | \\'i     
  ó | \\'o     
  ú | \\'u    
  Á | \\'A     
  É | \\'E     
  Í | \\'I     
  Ó | \\'O     
  Ú | \\'U    
  à | \\\`a     
  è | \\\`e     
  ì | \\\`i     
  ò | \\\`o     
  ù |\\\`u    
  À | \\\`A     
  È | \'E     
  Ì | \\\`I     
  Ò | \\\`O     
  Ù | \\\`U    
  ä | \\"a     
  ë | \\"e     
  ï | \\"i     
  ö | \\"o     
  ü | \\"u    
  Ä |\\"A     
  Ë | \\"E     
  Ï |\\"I     
  Ö | \\"O     
  Ü | \\"U    
  â | \\^a     
  ê | \\^e     
  î | \\^i     
  ô | \\^o     
  û | \\^u    
  Â | \\^A     
  Ê | \\^E     
  Î | \\^I     
  Ô | \\^O     
  Û | \\^U    
  œ | \\oe     
  Œ | \\OE     
  æ | \\ae     
  Æ | \\AE     
  ß | \\ss  
  
  ű | \H{u}   
  
  Ű | \H{U}  
  
  ő | \H{o} 
  
  Ő | \H{O} 
  
  ç | \c c
  
  Ç | \c C
  
  ø | \o  
  
  å | \r a
  
  Å | \r A
  
  € | \EUR  
  
  £ | \pounds 
  
