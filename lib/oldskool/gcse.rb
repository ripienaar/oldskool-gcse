module Oldskool
  class GCSE
    attr_reader :querytime

    include HTTParty

    def initialize(apikey, cx, apiurl='https://www.googleapis.com/customsearch/v1')
      @cx = cx
      @apikey = apikey
      @api = apiurl
      @lastresult = nil
      @querytime = 0
      @error = nil
    end

    def search(q, args={})
      args[:start] = (args.delete(:page) * 10 + 1) if args[:page]

      start = Time.now
      @lastresult = self.class.get(@api, :query => {:q => q, :key => @apikey, :cx => @cx}.merge(args))

      @querytime = Time.now - start

      if @lastresult["error"]
        @error = @lastresult["error"]["message"]
      else
        @error = nil
      end

      self
    end

    # Array of search results
    def items
      @lastresult["items"]
    end

    def total
      Integer(@lastresult["queries"]["request"].first["totalResults"])
    end

    # Custom Search Engine title
    def title
      @lastresult["context"]["title"]
    end

    # number of total results found in the search
    def total_results
      @lastresults["request"]["totalResults"]
    end

    def has_previous?
      !!@lastresult["queries"]["previousPage"]
    end

    def has_next?
      !!@lastresult["queries"]["nextPage"]
    end

    def next_start
      if has_next?
        return @lastresult["queries"]["nextPage"].first["startIndex"]
      end
    end

    def previous_start
      if has_previous?
        return @lastresult["queries"]["previousPage"].first["startIndex"]
      end
    end

    # do search for the previous results
    def previous
      if (r = @lastresult["queries"]["previousPage"])
        return search_by_query_hash(r.first)
      else
        return nil
      end
    end

    # do a search for the next results
    def next
      if (r = @lastresult["queries"]["nextPage"])
        @previous = @lastresult.clone

        return search_by_query_hash(r.first)
      else
        return nil
      end
    end

    def search_by_query_hash(query)
      if query["startIndex"]
        return search(query["searchTerms"], {:start => query["startIndex"]})
      else
        return search(query["searchTerms"])
      end
    end
  end
end
