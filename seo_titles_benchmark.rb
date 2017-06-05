require 'concurrent'
require 'pismo'
require 'benchmark'

class SeoTitles
  class << self
    def awesome_seo_titles
      result = ''

      time = Benchmark.measure do
        google_title_future = Concurrent.dataflow { seo_title_from('https://www.google.com') }
        apple_title_future  = Concurrent.dataflow { seo_title_from('https://www.apple.com') }

        titles = Concurrent.dataflow(google_title_future, apple_title_future) do |*titles_values|
          titles_values[0] + titles_values[1]
        end

        result = titles.value
      end
      puts "Total time spent: #{time.real}"

      result
    end

    private

    def seo_title_from(url)
      doc = {}

      time = Benchmark.measure do
        doc = Pismo::Document.new(url)
      end
      puts "Time spent: #{time.real}"

      doc.title
    end
  end
end
