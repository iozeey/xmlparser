class Converter < ApplicationRecord
  require 'csv'

  def self.importXml(file)
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
  
  def self.importText(file)
      quiz = []
      answers = []
      questions = []
      question = nil
    
      is_question = true
      can_parse_answers = false
      
    File.open(file.path, "r").each_line do |line|
      
      line = line.squish
 
      if is_question && (line[-1,1] == "?")
        question  = line
        is_question = false
        # now turn for answers parsing
        can_parse_answers = true
      elsif line.downcase.include? "answer:"
        data = line.split(":")

        temp_answer = data[1].squish

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
        is_question = true
        can_parse_answers = false

      elsif !is_question && can_parse_answers
          option = line[0..1].chomp(".")
          text = line[2,line.length].squish
          temp = {option: option , text: text}
          answers.push temp
      end
      puts line
    end
    quiz.push questions
  end
end
