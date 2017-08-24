class ConverterController < ApplicationController
  def import
    @quize = Converter.import(params[:file])

    puts @quize
    
    # raise 23
    render :template => "converter/index.xml", :type => :builder
  end
end
