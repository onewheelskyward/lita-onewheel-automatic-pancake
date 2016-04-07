require 'spec_helper'

describe Lita::Handlers::OnewheelAutomaticPancake, lita_handler: true do
  it { is_expected.to route_command('play x') }

  # before do
  #   mock = File.open('spec/fixtures/baileys.html').read
  #   allow(RestClient).to receive(:get) { mock }
  # end
end
