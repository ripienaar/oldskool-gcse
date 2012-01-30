module Oldskool
  class GcseHandler
    def initialize(params, keyword, config)
      @params = params
      @keyword = keyword
      @config = config
      self
    end

    def plugin_template(template)
      File.read(File.expand_path("../../../views/#{template}.erb", __FILE__))
    end

    def handle_request(keyword, query)
      gcse = GCSE.new(@config[:google_api_key], @keyword[:cx])

      if @params["page"]
        @params["page"] = Integer(@params["page"])
      else
        @params["page"] = 1
      end

      args = {:start => ((@params["page"] - 1) * 10 + 1)}

      gcse.search @params[:q], args

      escaped = URI.escape((query || keyword))

      sidemenu = [{:title => "Google", :url => "http://google.com/search?q=#{escaped}"},
                  {:title => "Images", :url => "http://google.com/search?q=#{escaped}&tbm=isch"},
                  {:title => "Videos", :url => "http://google.com/search?q=#{escaped}&tbm=vid"}]

      {:template => plugin_template(:gcse), :gcse => gcse, :sidemenu => sidemenu}
    end
  end
end
