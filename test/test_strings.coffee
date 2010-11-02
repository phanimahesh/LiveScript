eq '(((dollars)))', '\(\(\(dollars\)\)\)'
eq 'one two three', "one
 two
 three"
eq "four five", 'four

 five'

#647
eq "''Hello, World\\''", '''
'\'Hello, World\\\''
'''
eq '""Hello, World\\""', """
"\"Hello, World\\\""
"""
eq 'Hello, World\n', '''
Hello, World\

'''


hello = 'Hello'
world = 'World'
ok '#{hello} #{world}!' is '#{hello} #{world}!'
ok "#{hello} #{world}!" is 'Hello World!'
ok "[#{hello}#{world}]" is '[HelloWorld]'
ok "#{hello}##{world}" is 'Hello#World'
ok "Hello #{ 1 + 2 } World" is 'Hello 3 World'
ok "#{hello} #{ 1 + 2 } #{world}" is "Hello 3 World"


[s, t, r, i, n, g] = ['s', 't', 'r', 'i', 'n', 'g']
ok "#{s}#{t}#{r}#{i}#{n}#{g}" is 'string'
ok "\#{s}\#{t}\#{r}\#{i}\#{n}\#{g}" is '#{s}#{t}#{r}#{i}#{n}#{g}'
ok "\#{string}" is '#{string}'


ok "\#{Escaping} first" is '#{Escaping} first'
ok "Escaping \#{in} middle" is 'Escaping #{in} middle'
ok "Escaping \#{last}" is 'Escaping #{last}'


ok "##" is '##'
ok "#{}" is ''
ok "#{}A#{} #{} #{}B#{}" is 'A  B'
ok "\\\#{}" is '\\#{}'


ok "I won ##{20} last night." is 'I won #20 last night.'
ok "I won ##{'#20'} last night." is 'I won ##20 last night.'


ok "#{hello + world}" is 'HelloWorld'
ok "#{hello + ' ' + world + '!'}" is 'Hello World!'


list = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
ok "values: #{list.join(', ')}, length: #{list.length}." is 'values: 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, length: 10.'
ok "values: #{list.join ' '}" is 'values: 0 1 2 3 4 5 6 7 8 9'


obj = {
  name: 'Joe'
  hi: -> "Hello #{@name}."
  cya: -> "Hello #{@name}.".replace('Hello','Goodbye')
}
ok obj.hi() is "Hello Joe."
ok obj.cya() is "Goodbye Joe."


ok "With #{"quotes"}" is 'With quotes'
ok 'With #{"quotes"}' is 'With #{"quotes"}'

ok "Where is #{obj["name"] + '?'}" is 'Where is Joe?'

ok "Where is #{"the nested #{obj["name"]}"}?" is 'Where is the nested Joe?'
ok "Hello #{world ? "#{hello}"}" is 'Hello World'

ok "Hello #{"#{"#{obj["name"]}" + '!'}"}" is 'Hello Joe!'


a = """
    Hello #{ "Joe" }
    """
ok a is "Hello Joe"


a = 1
b = 2
c = 3
ok "#{a}#{b}#{c}" is '123'


result = null
stash = (str) -> result = str
stash "a #{ ('aa').replace /a/g, 'b' } c"
ok result is 'a bb c'


foo = "hello"
ok "#{foo.replace("\"", "")}" is 'hello'


a = """
    basic heredoc
    on two lines
    """

ok a is "basic heredoc\non two lines"


a = '''
    a
      "b
    c
    '''

ok a is "a\n  \"b\nc"


a = """
a
 b
  c
"""

ok a is "a\n b\n  c"


a = '''one-liner'''

ok a is 'one-liner'


a = """
      out
      here
"""

ok a is "out\nhere"


a = '''
       a
     b
   c
    '''

ok a is "    a\n  b\nc"


a = '''
a


b c
'''

ok a is "a\n\n\nb c"


a = '''more"than"one"quote'''

ok a is 'more"than"one"quote'


val = 10

a = """
    basic heredoc #{val}
    on two lines
    """

b = '''
    basic heredoc #{val}
    on two lines
    '''

ok a is "basic heredoc 10\non two lines"
ok b is "basic heredoc \#{val}\non two lines"


a = '''here's an apostrophe'''
ok a is "here's an apostrophe"


# The indentation detector ignores blank lines without trailing whitespace
a = """
    one
    two

    """
ok a is "one\ntwo\n"

eq ''' line 0
  should not be relevant
    to the indent level
''', '
 line 0\n
should not be relevant\n
  to the indent level
'

eq ''' '\\\' ''', " '\\' "
eq """ "\\\" """, ' "\\" '

eq '''  <- keep these spaces ->  ''', '  <- keep these spaces ->  '

eq 'multiline nested "interpolations" work', """multiline #{
  "nested #{(->
    ok true
    "\"interpolations\""
  )()}"
} work"""
