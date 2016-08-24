#!/usr/bin/env ruby

require_relative 'base'

answer_choices = ANSWER_CHOICES.order(:id).all
answer_choice_ids = answer_choices.map { |choice| choice[:id] }

puts '' 
puts '' 
puts '************************************'
puts '* THE MIGHTY RATIONALITY CHECKLIST *'
puts '************************************'
puts '' 
puts '' 

begin

CATEGORIES.order(:id).each do |category|
  puts "Category #{category[:id]}: #{category[:text]}"

  QUESTIONS.order(:id).where(category_id: category[:id]).each do |question| # yeah i know it's n+1 dw about it
    puts ''
    input = nil
    feedback_loop(*answer_choice_ids) do
      puts "\t#{question[:letter_rank]}) #{question[:text]}"
      puts ''
      answer_choices.each do |choice|
        puts "\t#{choice[:id]}) #{choice[:text]}"
      end
      puts ''
      printf "How often do you do this?: "
      input = gets.strip.to_i
    end

    # insert answer for current question
    ANSWERS.insert(answer_choice_id: input, question_id: question[:id], responded_at: DateTime.now)
  end
 
  puts ''
end

puts "You did it!"

rescue Interrupt
  puts ''
  puts "kthxbai"
end
