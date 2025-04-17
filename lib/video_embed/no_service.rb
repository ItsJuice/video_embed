class VideoEmbed
  class NoService 
    def url?(url)
      true
    end

    def embed(url, options = {})
      '<p>Video embed not available.</p>'
    end

    def embed(url, options = {})
      vimeo_url = NoService::Url.new(url, options)
      vimeo_url.embed
    end

    class Url
      attr_reader :url, :width, :height, :html

      def initialize(url, options = {})
        @url = url
        @width = options.fetch(:width, 560)
        @height = options.fetch(:height, 315)
        @html = options.fetch(:html, {})
      end

      def embed
        %Q{<iframe src="#{url}" width="#{width}" height="#{height}" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen#{html_attributes}></iframe>}
      end

      private

      def html_attributes
        @html.map { |key, value| " #{key}=\"#{value}\"" }.join
      end
      
      def video_id
        if url.to_s =~ /album\/\d*\/video\//
          url.to_s.match(/vimeo.com(?:\/m)?\/album\/\d*\/video\/(\d*)\??/)[1]
        else
          url.to_s.match(/vimeo.com(?:\/m)?\/(\d*)\??/)[1]
        end
      end
    end
  end
end
