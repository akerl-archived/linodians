# frozen_string_literal: true
require 'open-uri'
require 'nokogiri'

##
# Module for parsing Linode employee info
module Linodians
  DATA_URL = 'https://www.linode.com/about'.freeze
  PHOTO_URL = 'https://www.linode.com/media/images/employees/%s.png'.freeze

  class << self
    ##
    # Insert a helper .new() method for creating a new Group object
    def new(*args)
      self::Group.new(*args)
    end

    def load_data(data = nil)
      (data || download_data).map { |x| Employee.new x }
    end

    private

    def download_data
      Nokogiri::HTML(open(DATA_URL)).css('div').select do |block|
        block.at_xpath('div/div[@class="employee-display"]')
      end.map do |block|
        username = block.attr(:id)
        new_block = block.at_xpath('div/div[@class="employee-display"]')
        parse_user(username, new_block).merge parse_social(block)
      end
    end

    def parse_user(username, block)
      {
        username: username,
        fullname: block.at_css('strong').text,
        title: block.at_css('small').text
      }
    end

    def parse_social(block)
      links = block.css('a.employee-link').map do |link|
        # Social site name from CSS class, link target
        [parse_class(link[:class]), link['href']]
      end
      links = Hash[links]
      links.each { |k, v| links[k] = parse_handle(k, v) }
      links.merge(social: links.keys)
    end

    def parse_class(text)
      text.split.last.split('-').last.to_sym
    end

    def parse_handle(type, link)
      return link if type == :linkedin
      link.split('/').last
    end
  end
end

require 'linodians/version'
require 'linodians/employee'
require 'linodians/group'
