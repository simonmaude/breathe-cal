
Then /I should see (.*) on the (.*) side/ do |item, location|
    pending

=begin
        result = false
        if item.include? "map"
            if location.include? "left"
                result = ...
            elseif location.include? "right"
                result = ...
            end
        elsif item.include? "information"
            if location.include? "left"
                result = ...
            elseif location.include? "right"
                result = ...
            end       
        assert result == true
=end
end


Then /I should see (.*) on the map/ do |item|
    pending
end


Then /I should see (.*) on the bar/ do |item|
    pending
=begin
        result = false
        if item.include? "Recent Searches"
            result = ...
        elsif item.include? "View Favorites"
            result = ...
        elsif item.include? "allergen button"
            result = ...
        end       
        assert result
=end
end