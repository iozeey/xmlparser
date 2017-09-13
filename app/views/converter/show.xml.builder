xml.instruct!(:xml, :encoding => "UTF-8", version: 1.0)

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
          xml.text do
            xml.cdata! question[:question]
          end
        end
        xml.questiontext(format: "html") do
          xml.text do
            xml.cdata! question[:question]
          end
        end
        question[:answers].each do |answer|
          xml.answer(fraction: answer[:option]) do
            xml.text do
              xml.cdata! answer[:text]
            end
          end
        end
        xml.shuffleanswers 0
        xml.single question[:single]
        xml.answernumbering 123
      end
    end
  end
end
