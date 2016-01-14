module RSpecHelpers

  module FeatureSpecs
    def show_screenshot
      path = File.join(Rails.root, "tmp/screenshot-#{Time.now.to_f}.png")
      if Capybara.current_driver == :poltergeist
        page.driver.resize(1024, 1536)
        page.driver.render(path)
        Launchy.open("file://#{path}")
      elsif Capybara.current_driver == :webkit
        page.driver.save_screenshot(path)
        Launchy.open("file://#{path}")
      else
        save_and_open_page
      end
    end

    def save_screenshot(file_name)
      target_location = File.join(Capybara.save_and_open_page_path, file_name)
      if Capybara.javascript_driver == :poltergeist
        page.driver.render(target_location, full: true)
      elsif Capybara.javascript_driver == :webkit
        page.driver.save_screenshot(path)
      else
        puts "save_screenshot not implemented yet for javascript driver #{Capybara.javascript_driver}"
      end
    end
  end

end
