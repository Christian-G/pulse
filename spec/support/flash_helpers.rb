module FlashHelpers
  def assert_flash(type, value)
    selector = ".alert.alert-#{type}"
    page.should have_selector selector
    find(selector).text.should include value
  end

  def assert_no_flash(type)
    page.should_not have_selector(".alert.alert-#{type}")
  end

end

RSpec.configure do |config|
  config.include FlashHelpers
end
