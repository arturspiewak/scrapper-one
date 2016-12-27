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
      if scrape_role_access
        @data = scrape params[:sax][:address]
        if check_in_db(@data[:title])
          if @data[:error].nil?
            asign
            if @address.save
              redirect_to @address, notice: 'Product has been scraped'
            else
              render 'new'
            end
          else
            render 'new', notice: 'Error occured'
          end
        else
          redirect_to @address, notice: @info
        end
      else
        redirect_to root_path, notice: @error
      end
    else
      redirect_to root_path, notice: 'Wrong address'
    end
  end

  private
  def sax_params
    params.require(:sax).permit(:title, :price, :timestamp, :address)
  end

  def asign
    @address.title = @data[:title]
    @address.price = @data[:price]
    @address.timestamp = @data[:timestamp]
  end

  def scrape_role_access
    length = @address.address.split('/')[4].length
    books = @address.address.split('/')[4].include?('books')
    if current_user.role == 'normal'
      length < 15 ? true : (@error = "Too long url"; false)
    elsif current_user.role == 'premium'
      books ? true : (@error = "Do not contain 'books'"; false)
    else
      true
    end
  end

  def scrape(url)
    s = Scraping.new
    s.scrape(url).to_h
  end

  def update
    @address = Sax.find(@product.id)
    asign
    @address.update(sax_params)
  end

  def check_in_db(title)
    @product = Sax.all.where(title: title)[0]
    if @product.nil?
      true
    else
      if @product.timestamp == Date.today.to_datetime
        @address = @product
        @info = 'Product has been scraped today'
        false
      else
        if @product.timestamp < Date.today.to_datetime
          update
          @info = 'Product has been update'
        end
        false
      end
    end
  end

  def wrong_address
    @address.address.include?("saxoprint") && @address.address.include?("shop") ? true : false
  end
end
