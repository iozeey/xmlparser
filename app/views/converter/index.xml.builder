xml.instruct!
xml.quize do
  @quize.each do |questions|
    questions.each do |question|
      xml.question question[:question]
        xml.answers do  
          question[:answers].each do |answer|
            xml.answer(option: answer[:option]) do
              xml.text answer[:text]
            end
          end
        end
      xml.actualanswer question[:answer]
    end
  end
end
