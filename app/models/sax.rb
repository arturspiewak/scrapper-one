require_relative 'capybara_with_phantom_js'
require 'capybara/poltergeist'
require 'capybara/dsl'
require 'net/http'

class Sax < ApplicationRecord
  attr_accessor :address
  validates :address, presence: true
end

class Scraping
  include CapybaraWithPhantomJs

  def scrape(url)
    new_session
    begin
      @session.visit url
      sleep 10
      @scrape = Nokogiri::HTML.parse(html)
      to_h
    rescue Capybara::Poltergeist::StatusFailError
      data = {
        error: "StatusFailError"
      }
    rescue Capybara::Poltergeist::TimeoutError
      data = {
        error: "TimeoutError"
      }
    end
  end

  def to_h
    data = {
      title: title,
      price: price,
      timestamp: Date.today.to_datetime
    }
  end

  def title
    title = @scrape.search('//div[@class="shopheadline"]/h1')[0].children.text.delete("\n").strip
    return nil if title.empty?
    title
  end

  def price
    price = @scrape.search('[@class="priceCell finalPrice"]')[0].children.text[1..-1].to_f
    return nil if price.nil?
    price
  end
end
