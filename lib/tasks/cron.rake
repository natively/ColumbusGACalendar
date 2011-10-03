desc 'this task populates our event table from eb-xml streams'

task :cron => :environment do
  Event.destroy_all

  require 'nokogiri'
  require 'open-uri'

  # make this the url of your EventListXML stream
  event_list_url = "http://xml.eventbooking.com/xml_pubcal.asp?pwl=5A6.6C9A4BC4&mode=rangebasic"
  
  Nokogiri::XML(open(event_list_url)).xpath("//event").each do |e|
    puts "Creating " + (e>"event_name").text + "..."

    e_url = "http://xml.eventbooking.com/xml_pubcal.asp?pwl=5A6.6C9A4BC4&mode=detail&event_id="+e['event_id']
    e_details = Nokogiri::XML(open(e_url)).xpath("//public_event_detail")

    # get the date
    start_date = DateTime.parse( ( (e_details>"start_date").text + ' ' + (e_details>"start_time").text ) )
    end_date = DateTime.parse( ( (e_details>"end_date").text + ' ' + (e_details>"end_time").text ) ) 

    Event.create(
      :name => (e>"event_name").text,
      :unique_event_id => e['event_id'],
      :description => (e_details>"description").text,
      :location => (e>"location_name").text,
      :starts_at => start_date,
      :ends_at => end_date )
  end
end