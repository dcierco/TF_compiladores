
%{
  import java.io.*;
  import java.util.HashMap;
  import java.util.List;
  import java.util.ArrayList;

%}

      
%token DEFINE
%token NL          /* newline  */
%token <dval> NUM  /* a number */
%token IF, WHILE, ELSE, PRINT, FOR
%token <sval> IDENT

%type <obj> exp, cmd, line, input, lcmd, args, execArgs

%nonassoc '<', '>', EQUAL, LESSEQ, HIGHEQ, NOTEQUAL   
%left '-' '+'
%left '*', '/'
%left NEG, OR, AND          /* negation--unary minus */
%right '^'         /* exponentiation        */
      
%%

input:   /* empty string */ {$$=null;}
       | input line  { if ($2 != null) {
                           System.out.print("Avaliacao: " + ((INodo) $2).avalia() +"\n> "); 
							$$=$2;
						}
					    else {
                          System.out.print("\n> "); 
						  $$=null;
						}
					}
       | error NL { System.out.println("entrada ignorada"); }
       ;
      
line:    NL      { if (interactive) System.out.print("\n> "); $$ = null; }
       | exp NL  { $$ = $1;
		   System.out.println("\n= " + $1); 
                   if (interactive) System.out.print("\n>: "); }
       | cmd NL
       

cmd :  IDENT '=' exp ';'            { $$ = new NodoNT(TipoOperacao.ATRIB, $1, (INodo)$3); }
    |  IF '(' exp ')' cmd           { $$ = new NodoNT(TipoOperacao.IF,(INodo)$3, (INodo)$5, null); }
    |  IF '(' exp ')' cmd ELSE cmd  { $$ = new NodoNT(TipoOperacao.IFELSE,(INodo)$3, (INodo)$5, (INodo)$7); }
    |  WHILE '(' exp ')' cmd       { $$ = new NodoNT(TipoOperacao.WHILE,(INodo)$3, (INodo)$5, null); }
    |  FOR '(' cmd exp ';' exp ')' cmd      { $$ = new NodoNT(TipoOperacao.FOR,(INodo)$3, (INodo)$4, (INodo)$6, (INodo)$8); }
    | '{' lcmd '}'                 { $$ = $2; }
    |  DEFINE IDENT '(' args ')' cmd {$$ = $2; ListaFuncao.addFuncao(new Funcao($2)); ListaFuncao.busca($2).addParam($4.toString());ListaFuncao.busca($2).addCMD((INodo)$6);}
    |  IDENT '(' execArgs ')' ';' { List<INodo> execParams = new ArrayList<INodo>(); execParams.add((INodo)$3); ListaFuncao.busca($1).executaFuncao(execParams);}
    ;
      
lcmd : lcmd cmd                 { $$ = new NodoNT(TipoOperacao.SEQ,(INodo)$1,(INodo)$2); }
     |                          { $$ = new NodoNT(TipoOperacao.NULL, null, null, null); }               
     ;

args : IDENT args { $$ = new NodoID($1); }
     | ',' args {}
     |          {$$ = new NodoNT(TipoOperacao.NULL, null, null, null);}
     ;

execArgs : NUM execArgs {$$ = new NodoTDouble($1);}
        | ',' execArgs
        |               {$$ = new NodoNT(TipoOperacao.NULL, null, null, null);}
        ;

exp:     NUM                { $$ = new NodoTDouble($1); }
       | IDENT              { $$ = new NodoID($1); }
       | exp '+' exp        { $$ = new NodoNT(TipoOperacao.ADD,(INodo)$1,(INodo)$3); }
       | exp '-' exp        { $$ = new NodoNT(TipoOperacao.SUB,(INodo)$1,(INodo)$3); }
       | exp '*' exp        { $$ = new NodoNT(TipoOperacao.MULL,(INodo)$1,(INodo)$3); }
       | exp '/' exp        { $$ = new NodoNT(TipoOperacao.DIV,(INodo)$1,(INodo)$3); }
       | exp '<' exp        { $$ = new NodoNT(TipoOperacao.LESS,(INodo)$1,(INodo)$3); }
       | exp '>' exp        { $$ = new NodoNT(TipoOperacao.HIGHER,(INodo)$1,(INodo)$3); }
       | exp LESSEQ exp     { $$ = new NodoNT(TipoOperacao.LESSEQ,(INodo)$1,(INodo)$3); }
       | exp HIGHEQ exp     { $$ = new NodoNT(TipoOperacao.HIGHEQ,(INodo)$1,(INodo)$3); }
       | exp EQUAL exp      { $$ = new NodoNT(TipoOperacao.EQUAL,(INodo)$1,(INodo)$3); }
       | exp NOTEQUAL exp   { $$ = new NodoNT(TipoOperacao.NOTEQUAL,(INodo)$1,(INodo)$3); }
       | '-' exp  %prec NEG { $$ = new NodoNT(TipoOperacao.UMINUS,(INodo)$2,null); }
       | exp '^' exp        { $$ = new NodoNT(TipoOperacao.POW,(INodo)$1,(INodo)$3); }
       | '(' exp ')'        { $$ = $2; }
       ;

%%

  public static HashMap<String, ResultValue> memory = new HashMap<>();
  private ListaFuncao lfunc = new ListaFuncao();
  private Yylex lexer;


  private int yylex () {
    int yyl_return = -1;
    try {
      yylval = new ParserVal(0);
      yyl_return = lexer.yylex();
    }
    catch (IOException e) {
      System.err.println("IO error :"+e);
    }
    return yyl_return;
  }


  public void yyerror (String error) {
    System.err.println ("Error: " + error);
  }


  public Parser(Reader r) {
    lexer = new Yylex(r, this);
  }


  static boolean interactive;

  public static void main(String args[]) throws IOException {
    System.out.println("BYACC/Java with JFlex Calculator Demo");

    Parser yyparser;
    if ( args.length > 0 ) {
      // parse a file
      yyparser = new Parser(new FileReader(args[0]));
    }
    else {
      // interactive mode
      System.out.println("[Quit with CTRL-D]");
      System.out.print("Expression: ");
      interactive = true;
	    yyparser = new Parser(new InputStreamReader(System.in));
    }

    yyparser.yyparse();
    
    if (interactive) {
      System.out.println();
      System.out.println("Have a nice day");
    }
  }
