require "nokogiri"
require "pry"

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  projects = {:projects => {}}

  kickstarter = Nokogiri::HTML(html)
  list = kickstarter.css("#projects_list .project")

  list.each do |item|
    item_hash = {
      item.css("h2 a").text => {
        :image_link => item.css(".project-thumbnail img").attribute("src").value,
        :description => item.css("p.bbcard_blurb").text.delete("\n"),
        :location => item.css(".location-name").text,
        :percent_funded => item.css(".funded strong").text.to_i
      }
    }
    projects[:projects].merge!(item_hash)
  end

  projects[:projects]
end
