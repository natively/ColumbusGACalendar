desc 'this task populates our event table from eb-xml streams'

task :cron => :environment do
  Event.destroy_all

  require 'nokogiri'
  require 'open-uri'

  # make this the url of your EventListXML stream
  url = "http://xml.eventbooking.com/xml_pubcal.asp?pwl=5A6.6C9A4BC4&mode=rangebasic"
  
  Nokogiri::XML(open(url)).xpath("//event").each do |e|
    puts "Creating " + (e>"event_name").text + "..."
    
    # get the date
    start_date = DateTime.parse( (e>"start_date").text )
    end_date = DateTime.parse( (e>"end_date").text )

    Event.create(
      :name => (e>"event_name").text,
      :unique_event_id => e['event_id'],
      # :description => (e>"description").text,
      :location => (e>"location_name").text,
      :starts_at => start_date,
      :ends_at => end_date )
  end
end