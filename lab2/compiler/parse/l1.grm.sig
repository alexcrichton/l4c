signature L1_TOKENS =
sig
type ('a,'b) token
type svalue
val ASNOP:  'a * 'a -> (svalue,'a) token
val UNARY:  'a * 'a -> (svalue,'a) token
val RPAREN:  'a * 'a -> (svalue,'a) token
val LPAREN:  'a * 'a -> (svalue,'a) token
val RBRACE:  'a * 'a -> (svalue,'a) token
val LBRACE:  'a * 'a -> (svalue,'a) token
val PERCENTEQ:  'a * 'a -> (svalue,'a) token
val SLASHEQ:  'a * 'a -> (svalue,'a) token
val STAREQ:  'a * 'a -> (svalue,'a) token
val MINUSEQ:  'a * 'a -> (svalue,'a) token
val PLUSEQ:  'a * 'a -> (svalue,'a) token
val ASSIGN:  'a * 'a -> (svalue,'a) token
val PERCENT:  'a * 'a -> (svalue,'a) token
val SLASH:  'a * 'a -> (svalue,'a) token
val STAR:  'a * 'a -> (svalue,'a) token
val MINUS:  'a * 'a -> (svalue,'a) token
val PLUS:  'a * 'a -> (svalue,'a) token
val INT:  'a * 'a -> (svalue,'a) token
val RETURN:  'a * 'a -> (svalue,'a) token
val IDENT: (Symbol.symbol) *  'a * 'a -> (svalue,'a) token
val INTCONST: (Word32.word) *  'a * 'a -> (svalue,'a) token
val SEMI:  'a * 'a -> (svalue,'a) token
val EOF:  'a * 'a -> (svalue,'a) token
end
signature L1_LRVALS=
sig
structure Tokens : L1_TOKENS
structure ParserData:PARSER_DATA
sharing type ParserData.Token.token = Tokens.token
sharing type ParserData.svalue = Tokens.svalue
end
