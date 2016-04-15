require 'rest-client'

module Lita
  module Handlers
    class OnewheelAutomaticPancake < Handler
      config :pancake_server

      route /^play (.*)$/i,
            :play,
            command: true,
            help: {'play' => 'Play something with this text.'}

      route /^kill$/i,
            :kill,
            command: true,
            help: {'kill' => 'MAKE IT STOP'}

      route /^vol up/i,
            :vol_up,
            command: true,
            help: {'vol up' => 'Turn it up!'}

      route /^vol down/i,
            :vol_down,
            command: true,
            help: {'vol down' => 'Turn it down!'}

      route /^playtube (.*)$/i,
            :youtube,
            command: true,
            help: {'playtube' => 'Play this youtube.'}

      def play(response)
        search_term = response.matches[0][0]
        Lita.logger.debug "Search term found #{search_term}"
        list_of_matches = get_matches(search_term)
        chosen_one = list_of_matches.sample
        Lita.logger.debug "#{list_of_matches.count} matches, chose #{chosen_one.to_s}"
        play_file(chosen_one)
        response.reply "Playing #{chosen_one['name']}!"
      end

      def kill(response)
        Lita.logger.debug 'Killing'
        kill_sound
      end

      def vol_up(response)
        RestClient.post "#{config.pancake_server}/vol/up", {}
      end

      def vol_down(response)
        RestClient.post "#{config.pancake_server}/vol/down", {}
      end

      def youtube(response)
        RestClient.post "#{config.pancake_server}/youtube", {uri: response.matches[0][0]}
      end

      def kill_sound
        uri = "#{config.pancake_server}/kill"
        Lita.logger.debug "Killing!  #{uri}"
        RestClient.post uri, {}
      end

      def get_matches(search_term)
        Lita.logger.debug "searching #{config.pancake_server}/search for {query: #{search_term}}"
        response = RestClient.post "#{config.pancake_server}/search", {query: search_term}
        # Lita.logger.debug "Response: #{response}"
        JSON.parse response
      end

      def play_file(chosen_one)
        uri = "#{config.pancake_server}/play/#{chosen_one['id']}"
        Lita.logger.debug "POST to #{config.pancake_server}/play/#{chosen_one['id']}"
        RestClient.post uri, {}
      end

      Lita.register_handler(self)
    end
  end
end
