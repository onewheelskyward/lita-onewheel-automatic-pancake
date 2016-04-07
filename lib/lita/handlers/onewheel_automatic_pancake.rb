require 'rest-client'
require 'nokogiri'
require 'sanitize'

module Lita
  module Handlers
    class OnewheelAutomaticPancake < Handler
      route /^play (.*)$/i,
            :play,
            command: true,
            help: {'play' => 'Play something with this text.'}

      Lita.register_handler(self)
    end
  end
end
