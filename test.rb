def foo
  puts self
end

1.send :foo

def bar
  foo
end
