# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Listing.destroy_all
Province.destroy_all
Model.destroy_all
Make.destroy_all

require 'nokogiri'
require 'open-uri'
require 'restclient'
require 'pp'

# province_codes = { 'british-columbia' => 'k0l9007',
#                    'alberta' => 'k0l9003',
#                    'saskatchewan' => 'k0l9009',
#                    'manitoba' => 'k0l9006',
#                    'ontario' => 'k0l9004' }

province_codes = { 'british-columbia' => 'k0l9007' }

cars_hash = {
  mazda: { model: %w[mx5miata rx7] },
  nissan: { model: %w[240sx skyline 350z 370z] },
  toyota: { model: %w[supra mr2] },
  mitsubishi: { model: %w[evolution] },
  honda: { model: %w[s2000] },
  subaru: { model: %w[brz impreza_wrx_sti impreza_wrx] }
}

# For testing
mazda_hash = {
  mazda: { model: %w[mx5miata rx7] }
}

# For testing
manitoba_codes = {
  'manitoba' => 'k0l9006'
}

def currency_to_number(currency)
  currency.to_s.gsub(/[$,]/, '').to_f
end

KIJIJI = 'https://www.kijiji.ca'

listing_counter = 0

province_codes.each do |prov, _pcode|
  province = Province.find_or_create_by(name: prov)
  # puts province.name
  cars_hash.each do |makes, models|
    make = Make.find_or_create_by(name: makes)
    puts make.name
    models[:model].each do |mode|
      # puts mode
      model = Model.find_or_create_by(name: mode,
                                      make: make)
      puts model.name

      # page = Nokogiri::HTML(RestClient.get("#{KIJIJI}/b-#{prov}/#{makes}-#{mode}/#{pcode}?dc=true"))
      puts "#{KIJIJI}/b-cars-trucks/#{prov}/#{makes}-#{mode}-new__used/c174l9004a54a1000054a49"

      page = MetaInspector.new("#{KIJIJI}/b-cars-trucks/#{prov}/#{makes}-#{mode}-new__used/c174l9004a54a1000054a49")

      # page.inspect

      nokopage = Nokogiri::HTML(page.to_s)

      # response = `curl -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.89 Safari/537.36" #{KIJIJI}/b-cars-trucks/#{prov}/#{makes}-#{mode}-new__used/c174l9004a54a1000054a49`
      # page = Nokogiri::HTML(RestClient.get("#{KIJIJI}/b-cars-trucks/#{prov}/#{makes}-#{mode}-new__used/c174l9004a54a1000054a49"))
      # puts response
      # page = Nokogiri::HTML(response)
      # page = RestClient.get("#{KIJIJI}/b-cars-trucks/#{prov}/#{makes}-#{mode}-new__used/c174l9004a54a1000054a49")

      # response = RestClient::Request.new({
      #                                      method: :get,
      #                                      url: "#{KIJIJI}/b-cars-trucks/#{prov}/#{makes}-#{mode}-new__used/c174l9004a54a1000054a49",
      #                                      headers: { useragent: 'Mozilla/5.0' }
      #                                    }).execute do |response, _request, _result|
      #   case response.code
      #   when 400
      #     [:error, parse_json(response.to_str)]
      #   when 200
      #     [:success, parse_json(response.to_str)]
      #   else
      #     raise "Invalid response #{response.to_str} received."
      #   end
      # end
      # puts response

      listings = nokopage.css('div.clearfix')

      # links = []

      listings.each do |listing|
        price = currency_to_number(listing.css('div.price').text.strip)
        description = listing.css('div.description').text.strip
        location = listing.css('div.title a').attr('href').to_s.split('/')

        next if description.eql?('')

        list = Listing.create(title: listing.css('div.title').css('a').text.strip,
                              make: make,
                              model: model,
                              url: "#{KIJIJI}#{listing.css('div.title a').attr('href')}",
                              price: price,
                              description: listing.css('div.description').text.strip,
                              province: province,
                              location: location[2],
                              image_url: listing.css('div.image img').attr('data-src'))

        puts list.title
      end
    end
  end
end

puts "Generated #{Province.count} provinces."
puts "Generated #{Make.count} makes."
puts "Generated #{Model.count} models."
puts "Generated #{Listing.count} listings."
