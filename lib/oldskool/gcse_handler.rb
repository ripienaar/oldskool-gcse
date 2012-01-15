module Oldskool
  class GcseHandler
    include Rack::Utils

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

      sidemenu = [{:title => "Google", :url => "http://google.com/search?q=%s" % [ escape_html((query || keyword)) ]},
                  {:title => "Images", :url => "http://google.com/search?q=%s&tbm=isch" % [escape_html query]},
                  {:title => "Videos", :url => "http://google.com/search?q=%s&tbm=vid" % [ escape_html query ]} ]

      {:template => plugin_template(:gcse), :gcse => gcse, :sidemenu => sidemenu}
    end
  end
end
