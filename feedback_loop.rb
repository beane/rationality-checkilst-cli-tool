def feedback_loop(*valid_input, &block)
  loop do
    res = block.call
    puts res
    puts res.class
    puts valid_input
    puts valid_input.first.class
    puts valid_input.class
    break if valid_input.any? { |input| input == res }
    # otherwise repeat the loop
  end
end

