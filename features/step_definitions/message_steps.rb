Then /^I should see the "(.*)" message$/ do |message|
  text = case message
         when "alice is excited"
           @alice ||= Factory(:user, :username => "Alice")
           I18n.translate('invitation_code.excited', :user => @alice)
         else
           raise "muriel, you don't have that message key, add one here"
         end

  page.should have_content(text)
end

