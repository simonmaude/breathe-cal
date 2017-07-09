
When /I am on the home page of the application/ do
    pending
end


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
        assert result
=end
end

Then /I should see the add allergen button in the information bar/ do 
    pending
end


Then /I should see the search box on the map/ do
    pending
end


And /I should see (.*) on the bar/ do |item|
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