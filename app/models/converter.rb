class Converter < ApplicationRecord
  require 'csv'

  def self.import(file)
      quiz = []
      answers = []
      questions = []
      question = nil
    
      is_question = true
      can_parse_answers = false
      
    CSV.foreach(file.path, headers: false) do |r|
      if r[0]
        temp_answer = nil

        if is_question

          question  = " #{r[0]}"
          is_question = false

          # now turn for answers parsing
          can_parse_answers = true
        elsif r[0] && r[0].downcase == "answer:"

          can_parse_answers = false
          temp_answer = "#{r[1]}"
          tempa = {question: question , answers: answers, answer: temp_answer}
          questions.push tempa

          is_question = true

          answers.each do |answer|
            if answer[:option] == temp_answer
              answer[:option] = temp_answer
            else
              answer[:option] = 0
            end 
          end
          # empty the answers 
          answers = []
        elsif !is_question && can_parse_answers
          
          option = "#{r[0]}".chomp(".")
          text = "#{r[1]}"

          temp = {option: option , text: text}
          answers.push temp
        end
      end
    end

    quiz.push questions
  end
  
end
