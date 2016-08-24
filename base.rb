#!/usr/bin/env ruby

require 'sequel'

DB = Sequel.sqlite('rationality_checklist.db')
CATEGORIES = DB[:categories]
QUESTIONS = DB[:questions]
ANSWER_CHOICES = DB[:answer_choices]
ANSWERS = DB[:answers]

def feedback_loop(*valid_inputs, &block)
  loop do
    res = block.call
    break if valid_inputs.any? { |input| input == res }
    # otherwise, print errors message and repeat loop
    puts ''
    puts 'Invalid input -- please try again.'
    puts ''
  end
end

