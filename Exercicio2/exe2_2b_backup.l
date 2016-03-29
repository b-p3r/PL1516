%{
#include <stdlib.h>
#include <stdio.h>


%}

%S AUT TITLE FIELD SPEC SPEC2 SPEC3
%%

[ ]*"booktitle"[ ]*"="[  ]*[{"]+  {printf("            "); BEGIN FIELD;} 
[ ]*"title"[ ]*"="[  ]*[{"]+      {printf("Título    : "); BEGIN TITLE;}
[ ]*"author"[ ]*"="[  ]*[{"]+     {printf("\nAutor(es) : "); BEGIN AUT;}
[ ]*[a-z]+[ ]*"="[  ]*[{"]+       {printf("            "); BEGIN FIELD;}
<AUT>" and "                      {printf("\n            ");}
   /*<AUT>[{]+[A-Za-z \\=\'\`vkruc\~\"\^\~H]+[}]+       {ECHO;}*/
<AUT>[{]                          {BEGIN SPEC;}
<AUT>[}"]                         {printf("\n"); BEGIN INITIAL;}
<AUT>(.|\n)                       {ECHO;}


<AUT>[{]*"\\'"[\\{]*"a"[}]*      printf("á"); 
<AUT>[{]*"\\'"[\\{]*"e"[}]*      printf("é"); 
<AUT>[{]*"\\'"[\\{]*"i"[}]*      printf("í"); 
<AUT>[{]*"\\'"[\\{]*"o"[}]*      printf("ó"); 
<AUT>[{]*"\\'"[\\{]*"u"[}]*      printf("ú"); 
<AUT>[{]*"\\'"[\\{]*"A"[}]*      printf("Á"); 
<AUT>[{]*"\\'"[\\{]*"E"[}]*      printf("É"); 
<AUT>[{]*"\\'"[\\{]*"I"[}]*      printf("Í"); 
<AUT>[{]*"\\'"[\\{]*"O"[}]*      printf("Ó"); 
<AUT>[{]*"\\'"[\\{]*"U"[}]*      printf("Ú"); 

<AUT>[{]*"\\`"[\\{]*"a"[}]*      printf("à"); 
<AUT>[{]*"\\`"[\\{]*"e"[}]*      printf("è"); 
<AUT>[{]*"\\`"[\\{]*"i"[}]*      printf("ì"); 
<AUT>[{]*"\\`"[\\{]*"o"[}]*      printf("ò"); 
<AUT>[{]*"\\`"[\\{]*"u"[}]*      printf("ù"); 
<AUT>[{]*"\\`"[\\{]*"A"[}]*      printf("À"); 
<AUT>[{]*"\\`"[\\{]*"E"[}]*      printf("È"); 
<AUT>[{]*"\\`"[\\{]*"I"[}]*      printf("Ì"); 
<AUT>[{]*"\\`"[\\{]*"O"[}]*      printf("Ò"); 
<AUT>[{]*"\\`"[\\{]*"U"[}]*      printf("Ù"); 


<AUT>[{]*"\\"["][\\{]*"a"[}]*    printf("ä"); 
<AUT>[{]*"\\"["][\\{]*"e"[}]*    printf("ë"); 
<AUT>[{]*"\\"["][\\{]*"i"[}]*    printf("ï"); 
<AUT>[{]*"\\"["][\\{]*"o"[}]*    printf("ö"); 
<AUT>[{]*"\\"["][\\{]*"u"[}]*    printf("ü"); 
<AUT>[{]*"\\"["][\\{]*"A"[}]*    printf("Ä"); 
<AUT>[{]*"\\"["][\\{]*"E"[}]*    printf("Ë"); 
<AUT>[{]*"\\"["][\\{]*"I"[}]*    printf("Ï"); 
<AUT>[{]*"\\"["][\\{]*"O"[}]*    printf("Ö"); 
<AUT>[{]*"\\"["][\\{]*"U"[}]*    printf("Ü"); 


<AUT>[{]*"\\^"[\\{]*"a"[}]*      printf("â"); 
<AUT>[{]*"\\^"[\\{]*"e"[}]*      printf("ê"); 
<AUT>[{]*"\\^"[\\{]*"i"[}]*      printf("î"); 
<AUT>[{]*"\\^"[\\{]*"o"[}]*      printf("ô"); 
<AUT>[{]*"\\^"[\\{]*"u"[}]*      printf("û"); 
<AUT>[{]*"\\^"[\\{]*"A"[}]*      printf("Â"); 
<AUT>[{]*"\\^"[\\{]*"E"[}]*      printf("Ê"); 
<AUT>[{]*"\\^"[\\{]*"I"[}]*      printf("Î"); 
<AUT>[{]*"\\^"[\\{]*"O"[}]*      printf("Ô"); 
<AUT>[{]*"\\^"[\\{]*"U"[}]*      printf("Û"); 

<AUT>[{]*"\\r"[\\{]*"a"[}]*      printf("å"); 
<AUT>[{]*"\\r"[\\{]*"e"[}]*      printf("e̊"); 
<AUT>[{]*"\\r"[\\{]*"i"[}]*      printf("i̊"); 
<AUT>[{]*"\\r"[\\{]*"o"[}]*      printf("o̊"); 
<AUT>[{]*"\\r"[\\{]*"u"[}]*      printf("ů"); 
<AUT>[{]*"\\r"[\\{]*"A"[}]*      printf("Å"); 
<AUT>[{]*"\\r"[\\{]*"E"[}]*      printf("E̊"); 
<AUT>[{]*"\\r"[\\{]*"I"[}]*      printf("I̊"); 
<AUT>[{]*"\\r"[\\{]*"O"[}]*      printf("O̊"); 
<AUT>[{]*"\\r"[\\{]*"U"[}]*      printf("Ů"); 

<AUT>[{]*"\\~"[\\{]*"a"[}]*      printf("ã"); 
<AUT>[{]*"\\~"[\\{]*"e"[}]*      printf("ẽ"); 
<AUT>[{]*"\\~"[\\{]*"i"[}]*      printf("ĩ"); 
<AUT>[{]*"\\~"[\\{]*"o"[}]*      printf("õ"); 
<AUT>[{]*"\\~"[\\{]*"u"[}]*      printf("ũ"); 
<AUT>[{]*"\\~"[\\{]*"A"[}]*      printf("Ã"); 
<AUT>[{]*"\\~"[\\{]*"E"[}]*      printf("Ẽ"); 
<AUT>[{]*"\\~"[\\{]*"I"[}]*      printf("Ĩ"); 
<AUT>[{]*"\\~"[\\{]*"O"[}]*      printf("Õ"); 
<AUT>[{]*"\\~"[\\{]*"U"[}]*      printf("Ũ"); 

<AUT>[{]*"\\oe"[}]*              printf("œ"); 
<AUT>[{]*"\\OE"[}]*              printf("Œ"); 
<AUT>[{]*"\\ae"[}]*              printf("æ"); 
<AUT>[{]*"\\AE"[}]*              printf("Æ"); 
<AUT>[{]*"\\ss"[}]*              printf("ß"); 
<AUT>[{]*"\\aa"[}]*              printf("Å"); 
<AUT>[{]*"\\H"[{\\]"u}"[}]*      printf("ű"); 
<AUT>[{]*"\\H"[{\\]"U}"[}]*      printf("Ű"); 
<AUT>[{]*"\\H"[{\\]"o}"[}]*      printf("ő"); 
<AUT>[{]*"\\H"[{\\]"O}"[}]*      printf("Ő"); 
<AUT>[{]*"\\c"[{\\]"c}"[}]*      printf("ç"); 
<AUT>[{]*"\\c"[{\\]"C}"[}]*      printf("Ç"); 


<AUT>[{]*"\\."[\\{]*"a"[}]*      printf("ȧ"); 
<AUT>[{]*"\\."[\\{]*"e"[}]*      printf("ė"); 
<AUT>[{]*"\\."[\\{]*"i"[}]*      printf("i"); 
<AUT>[{]*"\\."[\\{]*"o"[}]*      printf("ȯ"); 
<AUT>[{]*"\\."[\\{]*"A"[}]*      printf("Ȧ"); 
<AUT>[{]*"\\."[\\{]*"E"[}]*      printf("Ė"); 
<AUT>[{]*"\\."[\\{]*"I"[}]*      printf("İ"); 
<AUT>[{]*"\\."[\\{]*"O"[}]*      printf("Ȯ"); 

<AUT>[{]*"\\u"[\\{]*"a"[}]*      printf("ă"); 
<AUT>[{]*"\\u"[\\{]*"e"[}]*      printf("ĕ"); 
<AUT>[{]*"\\u"[\\{]*"i"[}]*      printf("ĭ"); 
<AUT>[{]*"\\u"[\\{]*"o"[}]*      printf("ŏ"); 
<AUT>[{]*"\\u"[\\{]*"u"[}]*      printf("ŭ"); 
<AUT>[{]*"\\u"[\\{]*"A"[}]*      printf("Ă"); 
<AUT>[{]*"\\u"[\\{]*"E"[}]*      printf("Ĕ"); 
<AUT>[{]*"\\u"[\\{]*"I"[}]*      printf("Ĭ"); 
<AUT>[{]*"\\u"[\\{]*"O"[}]*      printf("Ŏ"); 
<AUT>[{]*"\\u"[\\{]*"U"[}]*      printf("Ŭ"); 


<AUT>[{]*"\\d"[\\{]*"a"[}]*      printf("ã"); 
<AUT>[{]*"\\d"[\\{]*"e"[}]*      printf("ẽ"); 
<AUT>[{]*"\\d"[\\{]*"i"[}]*      printf("ĩ"); 
<AUT>[{]*"\\d"[\\{]*"o"[}]*      printf("õ"); 
<AUT>[{]*"\\d"[\\{]*"u"[}]*      printf("ũ"); 
<AUT>[{]*"\\d"[\\{]*"A"[}]*      printf("Ã"); 
<AUT>[{]*"\\d"[\\{]*"E"[}]*      printf("Ẽ"); 
<AUT>[{]*"\\d"[\\{]*"I"[}]*      printf("Ĩ"); 
<AUT>[{]*"\\d"[\\{]*"O"[}]*      printf("Õ"); 
<AUT>[{]*"\\d"[\\{]*"U"[}]*      printf("Ũ"); 


<AUT>[{]*"\\k"[\\{]*"a"[}]*      printf("ą"); 
<AUT>[{]*"\\k"[\\{]*"e"[}]*      printf("ę"); 
<AUT>[{]*"\\k"[\\{]*"i"[}]*      printf("į"); 
<AUT>[{]*"\\k"[\\{]*"o"[}]*      printf("ǫ"); 
<AUT>[{]*"\\k"[\\{]*"u"[}]*      printf("ų"); 
<AUT>[{]*"\\k"[\\{]*"A"[}]*      printf("Ą"); 
<AUT>[{]*"\\k"[\\{]*"E"[}]*      printf("Ę"); 
<AUT>[{]*"\\k"[\\{]*"I"[}]*      printf("Į"); 
<AUT>[{]*"\\k"[\\{]*"O"[}]*      printf("Ǫ"); 
<AUT>[{]*"\\k"[\\{]*"U"[}]*      printf("Ų"); 


<AUT>[{]*"\\="[\\{]*"a"[}]*      printf("ā"); 
<AUT>[{]*"\\="[\\{]*"e"[}]*      printf("ē"); 
<AUT>[{]*"\\="[\\{]*"i"[}]*      printf("ī"); 
<AUT>[{]*"\\="[\\{]*"o"[}]*      printf("ō"); 
<AUT>[{]*"\\="[\\{]*"u"[}]*      printf("ū"); 
<AUT>[{]*"\\="[\\{]*"A"[}]*      printf("Ā"); 
<AUT>[{]*"\\="[\\{]*"E"[}]*      printf("Ē"); 
<AUT>[{]*"\\="[\\{]*"I"[}]*      printf("Ī"); 
<AUT>[{]*"\\="[\\{]*"O"[}]*      printf("Ō"); 
<AUT>[{]*"\\="[\\{]*"U"[}]*      printf("Ū"); 

<AUT>[{]*"\\v"[\\{]*"c"[}]*      printf("č"); 
<AUT>[{]*"\\v"[\\{]*"C"[}]*      printf("Č"); 
<AUT>[{]*"\\v"[\\{]*"s"[}]*      printf("š"); 
<AUT>[{]*"\\v"[\\{]*"S"[}]*      printf("Š"); 
<AUT>[{]*"\\v"[\\{]*"z"[}]*      printf("ž"); 
<AUT>[{]*"\\v"[\\{]*"Z"[}]*      printf("Ž"); 
<AUT>[{]*"\\v"[\\{]*"e"[}]*      printf("ě"); 
<AUT>[{]*"\\v"[\\{]*"E"[}]*      printf("Ě"); 

<AUT>[{]*"\\o"[}]*               printf("ø"); 
<AUT>[{]*"\\O"[}]*               printf("Ø"); 



<TITLE>[ ]{2,}                     {printf(" ");}
<TITLE>[{]                      {BEGIN SPEC2;}
<TITLE>[}"]                     {printf("\n");BEGIN INITIAL;}



<TITLE>[{]*"\\'"[\\{]*"a"[}]*      printf("á"); 
<TITLE>[{]*"\\'"[\\{]*"e"[}]*      printf("é"); 
<TITLE>[{]*"\\'"[\\{]*"i"[}]*      printf("í"); 
<TITLE>[{]*"\\'"[\\{]*"o"[}]*      printf("ó"); 
<TITLE>[{]*"\\'"[\\{]*"u"[}]*      printf("ú"); 
<TITLE>[{]*"\\'"[\\{]*"A"[}]*      printf("Á"); 
<TITLE>[{]*"\\'"[\\{]*"E"[}]*      printf("É"); 
<TITLE>[{]*"\\'"[\\{]*"I"[}]*      printf("Í"); 
<TITLE>[{]*"\\'"[\\{]*"O"[}]*      printf("Ó"); 
<TITLE>[{]*"\\'"[\\{]*"U"[}]*      printf("Ú"); 

<TITLE>[{]*"\\`"[\\{]*"a"[}]*      printf("à"); 
<TITLE>[{]*"\\`"[\\{]*"e"[}]*      printf("è"); 
<TITLE>[{]*"\\`"[\\{]*"i"[}]*      printf("ì"); 
<TITLE>[{]*"\\`"[\\{]*"o"[}]*      printf("ò"); 
<TITLE>[{]*"\\`"[\\{]*"u"[}]*      printf("ù"); 
<TITLE>[{]*"\\`"[\\{]*"A"[}]*      printf("À"); 
<TITLE>[{]*"\\`"[\\{]*"E"[}]*      printf("È"); 
<TITLE>[{]*"\\`"[\\{]*"I"[}]*      printf("Ì"); 
<TITLE>[{]*"\\`"[\\{]*"O"[}]*      printf("Ò"); 
<TITLE>[{]*"\\`"[\\{]*"U"[}]*      printf("Ù"); 


<TITLE>[{]*"\\"["][\\{]*"a"[}]*    printf("ä"); 
<TITLE>[{]*"\\"["][\\{]*"e"[}]*    printf("ë"); 
<TITLE>[{]*"\\"["][\\{]*"i"[}]*    printf("ï"); 
<TITLE>[{]*"\\"["][\\{]*"o"[}]*    printf("ö"); 
<TITLE>[{]*"\\"["][\\{]*"u"[}]*    printf("ü"); 
<TITLE>[{]*"\\"["][\\{]*"A"[}]*    printf("Ä"); 
<TITLE>[{]*"\\"["][\\{]*"E"[}]*    printf("Ë"); 
<TITLE>[{]*"\\"["][\\{]*"I"[}]*    printf("Ï"); 
<TITLE>[{]*"\\"["][\\{]*"O"[}]*    printf("Ö"); 
<TITLE>[{]*"\\"["][\\{]*"U"[}]*    printf("Ü"); 


<TITLE>[{]*"\\^"[\\{]*"a"[}]*      printf("â"); 
<TITLE>[{]*"\\^"[\\{]*"e"[}]*      printf("ê"); 
<TITLE>[{]*"\\^"[\\{]*"i"[}]*      printf("î"); 
<TITLE>[{]*"\\^"[\\{]*"o"[}]*      printf("ô"); 
<TITLE>[{]*"\\^"[\\{]*"u"[}]*      printf("û"); 
<TITLE>[{]*"\\^"[\\{]*"A"[}]*      printf("Â"); 
<TITLE>[{]*"\\^"[\\{]*"E"[}]*      printf("Ê"); 
<TITLE>[{]*"\\^"[\\{]*"I"[}]*      printf("Î"); 
<TITLE>[{]*"\\^"[\\{]*"O"[}]*      printf("Ô"); 
<TITLE>[{]*"\\^"[\\{]*"U"[}]*      printf("Û"); 

<TITLE>[{]*"\\r"[\\{]*"a"[}]*      printf("å"); 
<TITLE>[{]*"\\r"[\\{]*"e"[}]*      printf("e̊"); 
<TITLE>[{]*"\\r"[\\{]*"i"[}]*      printf("i̊"); 
<TITLE>[{]*"\\r"[\\{]*"o"[}]*      printf("o̊"); 
<TITLE>[{]*"\\r"[\\{]*"u"[}]*      printf("ů"); 
<TITLE>[{]*"\\r"[\\{]*"A"[}]*      printf("Å"); 
<TITLE>[{]*"\\r"[\\{]*"E"[}]*      printf("E̊"); 
<TITLE>[{]*"\\r"[\\{]*"I"[}]*      printf("I̊"); 
<TITLE>[{]*"\\r"[\\{]*"O"[}]*      printf("O̊"); 
<TITLE>[{]*"\\r"[\\{]*"U"[}]*      printf("Ů"); 

<TITLE>[{]*"\\~"[\\{]*"a"[}]*      printf("ã"); 
<TITLE>[{]*"\\~"[\\{]*"e"[}]*      printf("ẽ"); 
<TITLE>[{]*"\\~"[\\{]*"i"[}]*      printf("ĩ"); 
<TITLE>[{]*"\\~"[\\{]*"o"[}]*      printf("õ"); 
<TITLE>[{]*"\\~"[\\{]*"u"[}]*      printf("ũ"); 
<TITLE>[{]*"\\~"[\\{]*"A"[}]*      printf("Ã"); 
<TITLE>[{]*"\\~"[\\{]*"E"[}]*      printf("Ẽ"); 
<TITLE>[{]*"\\~"[\\{]*"I"[}]*      printf("Ĩ"); 
<TITLE>[{]*"\\~"[\\{]*"O"[}]*      printf("Õ"); 
<TITLE>[{]*"\\~"[\\{]*"U"[}]*      printf("Ũ"); 

<TITLE>[{]*"\\oe"[}]*              printf("œ"); 
<TITLE>[{]*"\\OE"[}]*              printf("Œ"); 
<TITLE>[{]*"\\ae"[}]*              printf("æ"); 
<TITLE>[{]*"\\AE"[}]*              printf("Æ"); 
<TITLE>[{]*"\\ss"[}]*              printf("ß"); 
<TITLE>[{]*"\\aa"[}]*              printf("Å"); 
<TITLE>[{]*"\\H"[{\\]"u}"[}]*      printf("ű"); 
<TITLE>[{]*"\\H"[{\\]"U}"[}]*      printf("Ű"); 
<TITLE>[{]*"\\H"[{\\]"o}"[}]*      printf("ő"); 
<TITLE>[{]*"\\H"[{\\]"O}"[}]*      printf("Ő"); 
<TITLE>[{]*"\\c"[{\\]"c}"[}]*      printf("ç"); 
<TITLE>[{]*"\\c"[{\\]"C}"[}]*      printf("Ç"); 


<TITLE>[{]*"\\."[\\{]*"a"[}]*      printf("ȧ"); 
<TITLE>[{]*"\\."[\\{]*"e"[}]*      printf("ė"); 
<TITLE>[{]*"\\."[\\{]*"i"[}]*      printf("i"); 
<TITLE>[{]*"\\."[\\{]*"o"[}]*      printf("ȯ"); 
<TITLE>[{]*"\\."[\\{]*"A"[}]*      printf("Ȧ"); 
<TITLE>[{]*"\\."[\\{]*"E"[}]*      printf("Ė"); 
<TITLE>[{]*"\\."[\\{]*"I"[}]*      printf("İ"); 
<TITLE>[{]*"\\."[\\{]*"O"[}]*      printf("Ȯ"); 

<TITLE>[{]*"\\u"[\\{]*"a"[}]*      printf("ă"); 
<TITLE>[{]*"\\u"[\\{]*"e"[}]*      printf("ĕ"); 
<TITLE>[{]*"\\u"[\\{]*"i"[}]*      printf("ĭ"); 
<TITLE>[{]*"\\u"[\\{]*"o"[}]*      printf("ŏ"); 
<TITLE>[{]*"\\u"[\\{]*"u"[}]*      printf("ŭ"); 
<TITLE>[{]*"\\u"[\\{]*"A"[}]*      printf("Ă"); 
<TITLE>[{]*"\\u"[\\{]*"E"[}]*      printf("Ĕ"); 
<TITLE>[{]*"\\u"[\\{]*"I"[}]*      printf("Ĭ"); 
<TITLE>[{]*"\\u"[\\{]*"O"[}]*      printf("Ŏ"); 
<TITLE>[{]*"\\u"[\\{]*"U"[}]*      printf("Ŭ"); 


<TITLE>[{]*"\\d"[\\{]*"a"[}]*      printf("ã"); 
<TITLE>[{]*"\\d"[\\{]*"e"[}]*      printf("ẽ"); 
<TITLE>[{]*"\\d"[\\{]*"i"[}]*      printf("ĩ"); 
<TITLE>[{]*"\\d"[\\{]*"o"[}]*      printf("õ"); 
<TITLE>[{]*"\\d"[\\{]*"u"[}]*      printf("ũ"); 
<TITLE>[{]*"\\d"[\\{]*"A"[}]*      printf("Ã"); 
<TITLE>[{]*"\\d"[\\{]*"E"[}]*      printf("Ẽ"); 
<TITLE>[{]*"\\d"[\\{]*"I"[}]*      printf("Ĩ"); 
<TITLE>[{]*"\\d"[\\{]*"O"[}]*      printf("Õ"); 
<TITLE>[{]*"\\d"[\\{]*"U"[}]*      printf("Ũ"); 


<TITLE>[{]*"\\k"[\\{]*"a"[}]*      printf("ą"); 
<TITLE>[{]*"\\k"[\\{]*"e"[}]*      printf("ę"); 
<TITLE>[{]*"\\k"[\\{]*"i"[}]*      printf("į"); 
<TITLE>[{]*"\\k"[\\{]*"o"[}]*      printf("ǫ"); 
<TITLE>[{]*"\\k"[\\{]*"u"[}]*      printf("ų"); 
<TITLE>[{]*"\\k"[\\{]*"A"[}]*      printf("Ą"); 
<TITLE>[{]*"\\k"[\\{]*"E"[}]*      printf("Ę"); 
<TITLE>[{]*"\\k"[\\{]*"I"[}]*      printf("Į"); 
<TITLE>[{]*"\\k"[\\{]*"O"[}]*      printf("Ǫ"); 
<TITLE>[{]*"\\k"[\\{]*"U"[}]*      printf("Ų"); 


<TITLE>[{]*"\\="[\\{]*"a"[}]*      printf("ā"); 
<TITLE>[{]*"\\="[\\{]*"e"[}]*      printf("ē"); 
<TITLE>[{]*"\\="[\\{]*"i"[}]*      printf("ī"); 
<TITLE>[{]*"\\="[\\{]*"o"[}]*      printf("ō"); 
<TITLE>[{]*"\\="[\\{]*"u"[}]*      printf("ū"); 
<TITLE>[{]*"\\="[\\{]*"A"[}]*      printf("Ā"); 
<TITLE>[{]*"\\="[\\{]*"E"[}]*      printf("Ē"); 
<TITLE>[{]*"\\="[\\{]*"I"[}]*      printf("Ī"); 
<TITLE>[{]*"\\="[\\{]*"O"[}]*      printf("Ō"); 
<TITLE>[{]*"\\="[\\{]*"U"[}]*      printf("Ū"); 

<TITLE>[{]*"\\v"[\\{]*"c"[}]*      printf("č"); 
<TITLE>[{]*"\\v"[\\{]*"C"[}]*      printf("Č"); 
<TITLE>[{]*"\\v"[\\{]*"s"[}]*      printf("š"); 
<TITLE>[{]*"\\v"[\\{]*"S"[}]*      printf("Š"); 
<TITLE>[{]*"\\v"[\\{]*"z"[}]*      printf("ž"); 
<TITLE>[{]*"\\v"[\\{]*"Z"[}]*      printf("Ž"); 
<TITLE>[{]*"\\v"[\\{]*"e"[}]*      printf("ě"); 
<TITLE>[{]*"\\v"[\\{]*"E"[}]*      printf("Ě"); 

<TITLE>[{]*"\\o"[}]*               printf("ø"); 
<TITLE>[{]*"\\O"[}]*               printf("Ø"); 



<TITLE>(.)                   {ECHO;}
<TITLE>(\n)                   {;}


<FIELD>[}"](\n)[ ]+[}]          {printf("\n\n\n"); BEGIN INITIAL;}
<FIELD>[{]                          {BEGIN SPEC3;}
<FIELD>[}"]                     {printf("\n"); BEGIN INITIAL;}



<FIELD>[{]*"\\'"[\\{]*"a"[}]*      printf("á"); 
<FIELD>[{]*"\\'"[\\{]*"e"[}]*      printf("é"); 
<FIELD>[{]*"\\'"[\\{]*"i"[}]*      printf("í"); 
<FIELD>[{]*"\\'"[\\{]*"o"[}]*      printf("ó"); 
<FIELD>[{]*"\\'"[\\{]*"u"[}]*      printf("ú"); 
<FIELD>[{]*"\\'"[\\{]*"A"[}]*      printf("Á"); 
<FIELD>[{]*"\\'"[\\{]*"E"[}]*      printf("É"); 
<FIELD>[{]*"\\'"[\\{]*"I"[}]*      printf("Í"); 
<FIELD>[{]*"\\'"[\\{]*"O"[}]*      printf("Ó"); 
<FIELD>[{]*"\\'"[\\{]*"U"[}]*      printf("Ú"); 

<FIELD>[{]*"\\`"[\\{]*"a"[}]*      printf("à"); 
<FIELD>[{]*"\\`"[\\{]*"e"[}]*      printf("è"); 
<FIELD>[{]*"\\`"[\\{]*"i"[}]*      printf("ì"); 
<FIELD>[{]*"\\`"[\\{]*"o"[}]*      printf("ò"); 
<FIELD>[{]*"\\`"[\\{]*"u"[}]*      printf("ù"); 
<FIELD>[{]*"\\`"[\\{]*"A"[}]*      printf("À"); 
<FIELD>[{]*"\\`"[\\{]*"E"[}]*      printf("È"); 
<FIELD>[{]*"\\`"[\\{]*"I"[}]*      printf("Ì"); 
<FIELD>[{]*"\\`"[\\{]*"O"[}]*      printf("Ò"); 
<FIELD>[{]*"\\`"[\\{]*"U"[}]*      printf("Ù"); 


<FIELD>[{]*"\\"["][\\{]*"a"[}]*    printf("ä"); 
<FIELD>[{]*"\\"["][\\{]*"e"[}]*    printf("ë"); 
<FIELD>[{]*"\\"["][\\{]*"i"[}]*    printf("ï"); 
<FIELD>[{]*"\\"["][\\{]*"o"[}]*    printf("ö"); 
<FIELD>[{]*"\\"["][\\{]*"u"[}]*    printf("ü"); 
<FIELD>[{]*"\\"["][\\{]*"A"[}]*    printf("Ä"); 
<FIELD>[{]*"\\"["][\\{]*"E"[}]*    printf("Ë"); 
<FIELD>[{]*"\\"["][\\{]*"I"[}]*    printf("Ï"); 
<FIELD>[{]*"\\"["][\\{]*"O"[}]*    printf("Ö"); 
<FIELD>[{]*"\\"["][\\{]*"U"[}]*    printf("Ü"); 


<FIELD>[{]*"\\^"[\\{]*"a"[}]*      printf("â"); 
<FIELD>[{]*"\\^"[\\{]*"e"[}]*      printf("ê"); 
<FIELD>[{]*"\\^"[\\{]*"i"[}]*      printf("î"); 
<FIELD>[{]*"\\^"[\\{]*"o"[}]*      printf("ô"); 
<FIELD>[{]*"\\^"[\\{]*"u"[}]*      printf("û"); 
<FIELD>[{]*"\\^"[\\{]*"A"[}]*      printf("Â"); 
<FIELD>[{]*"\\^"[\\{]*"E"[}]*      printf("Ê"); 
<FIELD>[{]*"\\^"[\\{]*"I"[}]*      printf("Î"); 
<FIELD>[{]*"\\^"[\\{]*"O"[}]*      printf("Ô"); 
<FIELD>[{]*"\\^"[\\{]*"U"[}]*      printf("Û"); 

<FIELD>[{]*"\\r"[\\{]*"a"[}]*      printf("å"); 
<FIELD>[{]*"\\r"[\\{]*"e"[}]*      printf("e̊"); 
<FIELD>[{]*"\\r"[\\{]*"i"[}]*      printf("i̊"); 
<FIELD>[{]*"\\r"[\\{]*"o"[}]*      printf("o̊"); 
<FIELD>[{]*"\\r"[\\{]*"u"[}]*      printf("ů"); 
<FIELD>[{]*"\\r"[\\{]*"A"[}]*      printf("Å"); 
<FIELD>[{]*"\\r"[\\{]*"E"[}]*      printf("E̊"); 
<FIELD>[{]*"\\r"[\\{]*"I"[}]*      printf("I̊"); 
<FIELD>[{]*"\\r"[\\{]*"O"[}]*      printf("O̊"); 
<FIELD>[{]*"\\r"[\\{]*"U"[}]*      printf("Ů"); 

<FIELD>[{]*"\\~"[\\{]*"a"[}]*      printf("ã"); 
<FIELD>[{]*"\\~"[\\{]*"e"[}]*      printf("ẽ"); 
<FIELD>[{]*"\\~"[\\{]*"i"[}]*      printf("ĩ"); 
<FIELD>[{]*"\\~"[\\{]*"o"[}]*      printf("õ"); 
<FIELD>[{]*"\\~"[\\{]*"u"[}]*      printf("ũ"); 
<FIELD>[{]*"\\~"[\\{]*"A"[}]*      printf("Ã"); 
<FIELD>[{]*"\\~"[\\{]*"E"[}]*      printf("Ẽ"); 
<FIELD>[{]*"\\~"[\\{]*"I"[}]*      printf("Ĩ"); 
<FIELD>[{]*"\\~"[\\{]*"O"[}]*      printf("Õ"); 
<FIELD>[{]*"\\~"[\\{]*"U"[}]*      printf("Ũ"); 

<FIELD>[{]*"\\oe"[}]*              printf("œ"); 
<FIELD>[{]*"\\OE"[}]*              printf("Œ"); 
<FIELD>[{]*"\\ae"[}]*              printf("æ"); 
<FIELD>[{]*"\\AE"[}]*              printf("Æ"); 
<FIELD>[{]*"\\ss"[}]*              printf("ß"); 
<FIELD>[{]*"\\aa"[}]*              printf("Å"); 
<FIELD>[{]*"\\H"[{\\]"u}"[}]*      printf("ű"); 
<FIELD>[{]*"\\H"[{\\]"U}"[}]*      printf("Ű"); 
<FIELD>[{]*"\\H"[{\\]"o}"[}]*      printf("ő"); 
<FIELD>[{]*"\\H"[{\\]"O}"[}]*      printf("Ő"); 
<FIELD>[{]*"\\c"[{\\]"c}"[}]*      printf("ç"); 
<FIELD>[{]*"\\c"[{\\]"C}"[}]*      printf("Ç"); 


<FIELD>[{]*"\\."[\\{]*"a"[}]*      printf("ȧ"); 
<FIELD>[{]*"\\."[\\{]*"e"[}]*      printf("ė"); 
<FIELD>[{]*"\\."[\\{]*"i"[}]*      printf("i"); 
<FIELD>[{]*"\\."[\\{]*"o"[}]*      printf("ȯ"); 
<FIELD>[{]*"\\."[\\{]*"A"[}]*      printf("Ȧ"); 
<FIELD>[{]*"\\."[\\{]*"E"[}]*      printf("Ė"); 
<FIELD>[{]*"\\."[\\{]*"I"[}]*      printf("İ"); 
<FIELD>[{]*"\\."[\\{]*"O"[}]*      printf("Ȯ"); 

<FIELD>[{]*"\\u"[\\{]*"a"[}]*      printf("ă"); 
<FIELD>[{]*"\\u"[\\{]*"e"[}]*      printf("ĕ"); 
<FIELD>[{]*"\\u"[\\{]*"i"[}]*      printf("ĭ"); 
<FIELD>[{]*"\\u"[\\{]*"o"[}]*      printf("ŏ"); 
<FIELD>[{]*"\\u"[\\{]*"u"[}]*      printf("ŭ"); 
<FIELD>[{]*"\\u"[\\{]*"A"[}]*      printf("Ă"); 
<FIELD>[{]*"\\u"[\\{]*"E"[}]*      printf("Ĕ"); 
<FIELD>[{]*"\\u"[\\{]*"I"[}]*      printf("Ĭ"); 
<FIELD>[{]*"\\u"[\\{]*"O"[}]*      printf("Ŏ"); 
<FIELD>[{]*"\\u"[\\{]*"U"[}]*      printf("Ŭ"); 


<FIELD>[{]*"\\d"[\\{]*"a"[}]*      printf("ã"); 
<FIELD>[{]*"\\d"[\\{]*"e"[}]*      printf("ẽ"); 
<FIELD>[{]*"\\d"[\\{]*"i"[}]*      printf("ĩ"); 
<FIELD>[{]*"\\d"[\\{]*"o"[}]*      printf("õ"); 
<FIELD>[{]*"\\d"[\\{]*"u"[}]*      printf("ũ"); 
<FIELD>[{]*"\\d"[\\{]*"A"[}]*      printf("Ã"); 
<FIELD>[{]*"\\d"[\\{]*"E"[}]*      printf("Ẽ"); 
<FIELD>[{]*"\\d"[\\{]*"I"[}]*      printf("Ĩ"); 
<FIELD>[{]*"\\d"[\\{]*"O"[}]*      printf("Õ"); 
<FIELD>[{]*"\\d"[\\{]*"U"[}]*      printf("Ũ"); 


<FIELD>[{]*"\\k"[\\{]*"a"[}]*      printf("ą"); 
<FIELD>[{]*"\\k"[\\{]*"e"[}]*      printf("ę"); 
<FIELD>[{]*"\\k"[\\{]*"i"[}]*      printf("į"); 
<FIELD>[{]*"\\k"[\\{]*"o"[}]*      printf("ǫ"); 
<FIELD>[{]*"\\k"[\\{]*"u"[}]*      printf("ų"); 
<FIELD>[{]*"\\k"[\\{]*"A"[}]*      printf("Ą"); 
<FIELD>[{]*"\\k"[\\{]*"E"[}]*      printf("Ę"); 
<FIELD>[{]*"\\k"[\\{]*"I"[}]*      printf("Į"); 
<FIELD>[{]*"\\k"[\\{]*"O"[}]*      printf("Ǫ"); 
<FIELD>[{]*"\\k"[\\{]*"U"[}]*      printf("Ų"); 


<FIELD>[{]*"\\="[\\{]*"a"[}]*      printf("ā"); 
<FIELD>[{]*"\\="[\\{]*"e"[}]*      printf("ē"); 
<FIELD>[{]*"\\="[\\{]*"i"[}]*      printf("ī"); 
<FIELD>[{]*"\\="[\\{]*"o"[}]*      printf("ō"); 
<FIELD>[{]*"\\="[\\{]*"u"[}]*      printf("ū"); 
<FIELD>[{]*"\\="[\\{]*"A"[}]*      printf("Ā"); 
<FIELD>[{]*"\\="[\\{]*"E"[}]*      printf("Ē"); 
<FIELD>[{]*"\\="[\\{]*"I"[}]*      printf("Ī"); 
<FIELD>[{]*"\\="[\\{]*"O"[}]*      printf("Ō"); 
<FIELD>[{]*"\\="[\\{]*"U"[}]*      printf("Ū"); 

<FIELD>[{]*"\\v"[\\{]*"c"[}]*      printf("č"); 
<FIELD>[{]*"\\v"[\\{]*"C"[}]*      printf("Č"); 
<FIELD>[{]*"\\v"[\\{]*"s"[}]*      printf("š"); 
<FIELD>[{]*"\\v"[\\{]*"S"[}]*      printf("Š"); 
<FIELD>[{]*"\\v"[\\{]*"z"[}]*      printf("ž"); 
<FIELD>[{]*"\\v"[\\{]*"Z"[}]*      printf("Ž"); 
<FIELD>[{]*"\\v"[\\{]*"e"[}]*      printf("ě"); 
<FIELD>[{]*"\\v"[\\{]*"E"[}]*      printf("Ě"); 

<FIELD>[{]*"\\o"[}]*               printf("ø"); 
<FIELD>[{]*"\\O"[}]*               printf("Ø"); 
<FIELD>(.|\n)                   {ECHO;}
<SPEC>[}]                       {BEGIN AUT;}
<SPEC>(.|\n)                    {ECHO;}

<SPEC2>[}]                       {BEGIN TITLE;}
<SPEC2>(.|\n)                    {ECHO;}

<SPEC3>[}]                       {BEGIN FIELD;}
<SPEC3>(.|\n)                    {ECHO;}

(.|\n)                          {;}

%%


int yywrap(){ return 1; } 


int main (){


yylex();




return (0); }




