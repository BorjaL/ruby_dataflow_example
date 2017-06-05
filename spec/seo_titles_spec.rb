require_relative '../seo_titles_benchmark'

describe SeoTitles do
  describe '.awesome_seo_titles' do
    it 'return google title' do
      expect(described_class.awesome_seo_titles).to include('Google')
    end

    it 'return apple title' do
      expect(described_class.awesome_seo_titles).to include('Apple')
    end
  end
end
