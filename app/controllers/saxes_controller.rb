class SaxesController < ApplicationController
  before_action :authenticate_user!

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
    if wrong_address
      data = scrape params[:sax][:address]
      if check_in_db(data[:title])
        if data[:error].nil?
          @address.title = data[:title]
          @address.price = data[:price]
          @address.timestamp = data[:timestamp]

          if @address.save
            redirect_to @address, notice: 'Product has been scraped'
          else
            render 'new'
          end
        else
          render 'new'
        end
      else
        redirect_to @address
      end
    else
      render 'new'
    end
  end

  private
  def sax_params
    params.require(:sax).permit(:title, :price, :timestamp, :address)
  end

  def scrape(url)
    s = Scraping.new
    s.scrape(url).to_h
  end

  def check_in_db(title)
    @product = Sax.all.where(title: title)[0]
    if @product.nil?
      true
    else
      if @product.timestamp == Date.today.to_datetime
        @address = @product
        false
      else
        true
      end
    end
  end

  def wrong_address
    @address.address.include?("saxoprint") && @address.address.include?("shop") ? true : false
  end
end
