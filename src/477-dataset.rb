#!/usr/bin/env ruby

# Build CSV of files in the 477 lego dataset
# https://mostwiedzy.pl/en/open-research-data/lego-bricks-for-training-classification-network,618104539639776-0

require 'bundler/inline'
require 'csv'

gemfile do
  source 'https://rubygems.org'
  gem 'image_size'
end

return

filenames = `find ~/Downloads/lego-datasets/original/renders/3004 -type f -print | sed 's|/Users/brian/Downloads/lego-datasets/||'`

CSV.open('477-dataset.csv', 'w') do |csv|
  csv << ['filename', 'label', 'real', 'color', 'width', 'height', 'format']
  filenames.split("\n").each do |filename|
    next if filename.include?('.DS_Store')
    puts filename
    label = filename.match(%r{./.*/([^_]*)/}).captures.first
    real = filename.include?('/photos/')
    color = filename.match(%r{./.*/.*/[^_]*_(.*)_[0-9]_[0-9].*\..*})&.captures&.first
    image = ImageSize.path(filename)
    csv << [filename, label, real, color, image.width, image.height, image.format]
  end
end
