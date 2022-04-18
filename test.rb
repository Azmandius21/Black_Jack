loop do
  x = 1
  begin
    y = rand(10)
    raise 'Y = 0' if y.zero?

    puts y
  rescue RuntimeError => e
    next
  end
end
