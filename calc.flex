%%

%byaccj

%{
  private Parser yyparser;

  public Yylex(java.io.Reader r, Parser yyparser) {
    this(r);
    this.yyparser = yyparser;
  }
%}

NUM = [:digit:]+ ("." [:digit:]+)?
IDENT = [:letter:]+ ([:letter:]|[:digit:])*
NL  = \n | \r | \r\n

%%

/* operators */
";" | 
"{" | 
"}" | 
"+" | 
"-" | 
"*" | 
"/" | 
"^" | 
"(" | 
")" |
"<" |
">" |
"="   { return (int) yycharat(0); }

"==" { return Parser.EQUAL; }
">=" { return Parser.HIGHEQ; }
"<=" { return Parser.LESSEQ; }
"!=" { return Parser.NOTEQUAL; }

 
if  { return Parser.IF; }
else  { return Parser.ELSE; }
while  { return Parser.WHILE; }
print  { return Parser.PRINT; }
define { return Parser.DEFINE; }


{NL}   { return Parser.NL; }

{NUM}  { yyparser.yylval = new ParserVal(Double.parseDouble(yytext()));
         return Parser.NUM; }

{IDENT} { yyparser.yylval = new ParserVal(yytext());
         return Parser.IDENT; }

[ \t]+ { }

[^]    { System.err.println("Error: unexpected character '"+yytext()+"'"); return -1; }
