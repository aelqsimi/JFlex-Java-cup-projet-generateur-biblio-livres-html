import java_cup.runtime.Symbol;

%%
%unicode
%cup
%line
%column

id = [0-9a-zA-Z_éèàâçêîôùû:/.,\-\ \&_!~\*'\(\);\?\+\{\}]
comment = "%%"{id}*
titre = "\\titre"{espace}*
auteurs = "\\auteurs"{espace}*
type = "\\type"{espace}*
critiques = "\\critiques"{espace}*

espace = [ \r\t\b\n]|" "
livre_vide = "{"{espace}*"}"
champ = ({titre}{id}* | {type}{id}* | {auteurs}{id}* | {critiques}{id}*)

livre = "{"{espace}*{champ}(4,4){espace}*"}"

erreur_livre = "{" ([^"\\titre"]{espace}*{id}* 
		| [^"\\auteurs"]{espace}{id}* 
		| [^"\\type"]{espace}{id}*
		| [^"\\critiques"]{espace}{id}* )*
		 "}"
erreur_champ_absent =  "{" (
			   {titre}{id}* {auteurs}{id}* {type}{id}* 
			|  {titre}{id}* {type}{id}* {auteurs}{id}*
			|  {titre}{id}* {critiques}{id}* {type}{id}*
			|  {titre}{id}* {type}{id}* {critiques}{id}*
			|  {titre}{id}* {critiques}{id}* {auteurs}{id}*
			|  {titre}{id}* {auteurs}{id}* {critiques}{id}*
			|  {auteurs}{id}* {titre}{id}* {type}{id}*
			|  {auteurs}{id}* {type}{id}* {titre}{id}* 
			|  {auteurs}{id}* {titre}{id}* {critiques}{id}*
			|  {auteurs}{id}* {critiques}{id}* {titre}{id}* 
			|  {auteurs}{id}* {critiques}{id}* {type}{id}* 
			|  {auteurs}{id}* {type}{id}* {critiques}{id}* 
			|  {type}{id}* {auteurs}{id}* {critiques}{id}*
			|  {type}{id}* {critiques}{id}* {auteurs}{id}* 
			|  {type}{id}* {titre}{id}* {critiques}{id}* 
			|  {type}{id}* {critiques}{id}* {titre}{id}* 
			|  {type}{id}* {type}{id}* {critiques}{id}* 
			|  {type}{id}* {critiques}{id}* {type}{id}* 
			|  {critiques}{id}* {type}{id}* {auteurs}{id}* 
			|  {critiques}{id}* {auteurs}{id}* {type}{id}* 
			|  {critiques}{id}* {titre}{id}* {type}{id}* 
			|  {critiques}{id}* {type}{id}* {titre}{id}* 
			|  {critiques}{id}* {auteurs}{id}* {titre}{id}* 
			|  {critiques}{id}* {titre}{id}* {auteurs}{id}* 
			|  {titre}{id}* {auteurs}{id}* 
			|  {titre}{id}* {type}{id}* 
			|  {titre}{id}* {critiques}{id}* 
			|  {auteurs}{id}* {type}{id}* 
			|  {auteurs}{id}* {critiques}{id}* 
			|  {auteurs}{id}* {titre}{id}* 
			|  {type}{id}* {titre}{id}* 
			|  {type}{id}* {critiques}{id}* 
			|  {type}{id}* {auteurs}{id}* 
			|  {critiques}{id}* {auteurs}{id}* 
			|  {critiques}{id}* {type}{id}* 
			|  {critiques}{id}* {titre}{id}* 
			|  {type}{id}* 
			|  {critiques}{id}* 
			|  {auteurs}{id}* 
			|  {titre}{id}* 
			) "}"
			
	
%%


\{+ {return new Symbol(sym.AO, yytext());}
\}+ {return new Symbol(sym.AF, yytext());}
{titre}{id}* {return new Symbol(sym.TITRE, new String(yytext().substring(7).trim()));}
{auteurs}{id}* {return new Symbol(sym.AUTEURS, new String(yytext().substring(9).trim()));}
{type}{id}* {return new Symbol(sym.TYPE, new String(yytext().substring(6).trim()));}
{critiques}{id}* {return new Symbol(sym.CRITIQUES, new String(yytext().substring(11).trim()));}
({comment})+ {return new Symbol(sym.COMMENT, new String(yytext().substring(yytext().lastIndexOf("%")+1).trim()));}
{espace}+ | {livre_vide} | . {}

{erreur_livre} { System.out.println("Attention : ligne " +(yyline+1)+" colonne "+(yycolumn+1) +"=> livre non conforme ingoré < "+yytext()+" >");}

{erreur_champ_absent} { System.out.println("Attention : ligne " +(yyline+1)+" colonne "+(yycolumn+1) +"=> Champ absent < "+yytext()+" >");}

