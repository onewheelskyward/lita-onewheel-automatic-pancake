require 'spec_helper'

describe Lita::Handlers::OnewheelAutomaticPancake, lita_handler: true do
  it { is_expected.to route_command('play x') }
  it { is_expected.to route_command('playtube x') }
  it { is_expected.to route_command('vol up') }
  it { is_expected.to route_command('vol down') }
  it { is_expected.to route_command('vol 50') }

  # before do
  #   mock = File.open('spec/fixtures/baileys.html').read
  #   allow(RestClient).to receive(:get) { mock }
  # end
end
