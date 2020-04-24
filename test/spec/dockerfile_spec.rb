# frozen_string_literal: true

require 'serverspec'
require 'docker'

describe 'scenario test Dockerfile' do
  before(:all) do
    @image = Docker::Image.build_from_dir('../scenarios')
  end

  it 'has the maintainer label' do
    labels = @image.json['Config']['Labels']

    expect(labels.key?('maintainer')).to be true
    expect(labels['maintainer']).to eq('Sophie')
  end
end
