module Merb
  module Fixtures
    module Helpers
      LOREM = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
      # lorem :type => "html", :count => 5
      def lorem(params = Hash.new)
        output = Array.new
        default = { :count => 1, :type => "plain" }
        params = params.merge(default)
        params[:count].times do
          if params[:type].to_s.eql?("html")
            output.push("<p>#{LOREM}</p>")
          else
            output.push(LOREM)
          end
        end
        return output
      end
    end
  end
end