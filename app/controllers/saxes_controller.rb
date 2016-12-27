class SaxesController < ApplicationController

  def index
    @addresses = Sax.all
  end

  def show
    @address ||= Sax.find(params[:id])
  end

  def new
    @address = Sax.new
  end

  def create
    @address = Sax.new(sax_params)
    data = scrape params[:sax][:address]

    if data[:error].nil?
      @address.title = data[:title]
      @address.price = data[:price]
      @address.timestamp = data[:timestamp]

      if @address.save
        redirect_to root_path
      else
        render 'new'
      end
    else
      render 'new'
    end
  end

  private
  def sax_params
    params.require(:sax).permit(:title, :price, :timestamp)
  end

  def scrape(url)
    s = Scraping.new
    s.scrape(url).to_h
  end
end
