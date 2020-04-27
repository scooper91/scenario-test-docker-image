# frozen_string_literal: true

require 'serverspec'
require 'docker'

describe 'scenario test Dockerfile' do
  before(:all) do
    @image = Docker::Image.build_from_dir('../scenarios')
    set :os, family: :debian
    set :backend, :docker
    set :docker_image, @image.id
  end

  it 'has the maintainer label' do
    labels = @image.json['Config']['Labels']

    expect(labels.key?('maintainer')).to be true
    expect(labels['maintainer']).to eq('Sophie')
  end

  describe package('google-chrome-stable') do
    it { should be_installed }
  end
end
