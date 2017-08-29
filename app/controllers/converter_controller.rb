class ConverterController < ApplicationController
  def import
    @quize = Converter.import(params[:file])
    render :template => "converter/index.xml", :type => :builder
  end
end
