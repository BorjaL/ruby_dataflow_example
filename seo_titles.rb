require 'concurrent'
require 'pismo'
require 'benchmark'

class SeoTitles
  class << self
    def awesome_seo_titles
      google_title_future = Concurrent.dataflow { seo_title_from('https://www.google.com') }
      apple_title_future  = Concurrent.dataflow { seo_title_from('https://www.apple.com') }

      titles = Concurrent.dataflow(google_title_future, apple_title_future) do |*titles_values|
        titles_values[0] + titles_values[1]
      end

      titles.value
    end

    private

    def seo_title_from(url)
      Pismo::Document.new(url).title
    end
  end
end
