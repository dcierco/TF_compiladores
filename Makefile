# only works with the Java extension of yacc: 
# byacc/j from http://troi.lincom-asg.com/~rjamison/byacc/

JFLEX  = java -jar jflex.jar 
BYACCJ = ./yacc.linux -tv -J 
JAVAC  = javac

# targets:

all: Parser.class AppTeste.class

run: Parser.class
	java Parser

build: clean Parser.class

clean:
	rm -f *~ *.class *.o *.s Yylex.java Parser.java y.output


AppTeste.class: Yylex.java Parser.java *.java
	$(JAVAC) AppTeste.java


Parser.class: Yylex.java Parser.java *.java
	$(JAVAC) Parser.java

Yylex.java: calc.flex
	$(JFLEX) calc.flex

Parser.java: calc.y
	$(BYACCJ) calc.y
