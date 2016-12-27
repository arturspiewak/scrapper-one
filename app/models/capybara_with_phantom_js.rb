require 'capybara/dsl'

module CapybaraWithPhantomJs
  include Capybara::DSL

  def new_session
    Capybara.register_driver :poltergeist do |app|
      options = {
          :window_size  => [1280, 1440],
          :phantomjs_options => ['--proxy-type=none', '--load-images=no', '--ignore-ssl-errors=yes', '--ssl-protocol=any'],
          :timeout => 120
        }
    Capybara::Poltergeist::Driver.new(app, options)
  end

    Capybara.default_selector = :xpath

    @session = Capybara::Session.new(:poltergeist)

    @session.driver.headers = { 'User-Agent' =>
      "Mozilla/5.0 (Macintosh; Intel Mac OS X)" }
    @session
  end

  def html
    @session.html
  end
end
