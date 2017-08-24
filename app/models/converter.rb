class Converter < ApplicationRecord
  require 'csv'

  def self.import(file)
      quiz = []
      answers = []
      questions = []
      question = nil
    
      is_question = true
      is_answer_reached = false
      
    CSV.foreach(file.path, headers: false) do |r|
      if r[0]
        if is_question
          question  = " #{r[0]} #{r[1]} #{r[2]} #{r[3]} "
          is_question = false
          # now turn for answers
          is_answer_reached = true
        elsif r[0] == "answer:" || r[0] == "ANSWER:"
          is_answer_reached = false
          ans = "#{r[1]}"
          tempa = {question: question , answers: answers, answer: ans}
          questions.push tempa

          is_question = true

          # empty the answers 
          answers = []
        elsif !is_question && is_answer_reached
          option = "#{r[0]}"
          text = "#{r[1]} #{r[2]} #{r[3]} #{r[4]}"
          temp = {option: option , text: text}
          answers.push temp
        end
      end
    end

    quiz.push questions
  end
  
end
