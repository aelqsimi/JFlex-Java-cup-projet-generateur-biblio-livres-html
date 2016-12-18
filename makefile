prog : parser.class entree.txt

	java parser < entree.txt

parser.class : parser.java sym.java Yylex.java

	javac parser.java sym.java Yylex.java

parser.java : miniprojet.cup

	java java_cup.Main -expect 2 miniprojet.cup

sym.java : miniprojet.cup

	java java_cup.Main -expect 2 miniprojet.cup

Yylex.java : miniprojet.lex

	java JFlex.Main miniprojet.lex

clean :

	rm -rf *.class *.java
