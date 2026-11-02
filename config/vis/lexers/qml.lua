local lexer = lexer

local lex = lexer.new(..., {
	inherit = lexer.load('javascript')
})

lex:add_rule('qml_keyword',
	lex:tag(lexer.KEYWORD,
		lex:word_match({
			'import',
			'pragma',
			'property',
			'readonly',
			'required',
			'signal',
			'on',
			'as',
		})
	)
)

lexer.property['scintillua.comment'] = '//'

return lex
