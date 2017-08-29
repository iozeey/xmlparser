xml.instruct!
xml.quiz do
  @quize.each do |questions|
    xml.question(type: "category") do
      xml.category do
        xml.text "__Category Name__"
      end
    end

    questions.each do |question|
      xml.question(type: "multichoice") do
        xml.name do
          xml.text question[:question]
        end
        xml.questiontext(formate: "html") do
          xml.text question[:question]
        end
        question[:answers].each do |answer|
          xml.answer(fraction: answer[:option]) do
            xml.text answer[:text]
          end
        end
      end
      xml.actualanswer question[:answer]
    end
  end
end
