syn region lqdHighlight     start=/^{%\s*highlight\(\s\+\w\+\)\{0,1}\s*%}$/ end=/{%\s*endhighlight\s*%}/ contains=@Spell
syn region jkyFrontMatter   start=/\%^---$/                                 end=/^---$/                  contains=@Spell
HtmlHiLink lqdHighlight     String
HtmlHiLink jkyFrontMatter   String
