desc 'this task populates our event table from eb-xml streams'

task :cron => :environment do
  require 'nokogiri'
  require 'open-uri'

  #puts 'Killing the old events table...'
  #Event.destroy_all
  puts 'Killing the old groups table...'
  Group.destroy_all

  #populate the groups table
  puts 'Creating groups...'
  group_url = "http://xml.eventbooking.com/xml_pubcal.asp?pwl=5A6.6C9A4BC4&mode=setupinfo"
  Nokogiri::XML(open(group_url)).xpath("//group").each do |g|
    unless g['type'] == 'I'
      puts 'Creating ' + g['group_name'] + ' with id=' + g['defn_id']
      Group.new do |new_g|
        new_g.group_name = g['group_name']
        new_g.id = g['defn_id']
        new_g.save
      end

    end
  end
  

  # make this the url of your EventListXML stream
  event_list_url = "http://xml.eventbooking.com/xml_pubcal.asp?pwl=5A6.6C9A4BC4&mode=rangebasic"
  
  Nokogiri::XML(open(event_list_url)).xpath("//event").each do |e|
    puts "Creating " + (e>"event_name").text + "..."

    e_url = "http://xml.eventbooking.com/xml_pubcal.asp?pwl=5A6.6C9A4BC4&mode=detail&event_id="+e['event_id']
    e_details = Nokogiri::XML(open(e_url)).xpath("//public_event_detail")

    # get the date
    start_date = DateTime.parse( ( (e_details>"start_date").text + ' ' + (e_details>"start_time").text ) )
    end_date = DateTime.parse( ( (e_details>"end_date").text + ' ' + (e_details>"end_time").text ) ) 

    featured = (e_details>"featured").text
    image_url = (e_details>"picture_full").text

    ticket_info = (e_details>"ticket_info").text
    ticket_prices = (e_details>"ticket_prices").text

    additional_info = (e_details>"additional_info").text

    contact_name = (e_details>"contact").text
    contact_email = (e_details>"contact_email").text
    contact_phone = (e_details>"contact_phone").text

    group_collection = e_details.xpath("//group").collect { |g| g['defn_id'] }

    Event.new(
      :name => (e>"event_name").text,
      :unique_event_id => e['event_id'],
      :description => (e_details>"description").text,
      :featured => featured,
      :image_url => image_url,
      :location => (e>"location_name").text,
      :starts_at => start_date,
      :ends_at => end_date,
      :ticket_info => ticket_info,
      :ticket_prices => ticket_prices,
      :additional_info => additional_info,
      :contact_name => contact_name,
      :contact_email => contact_email,
      :contact_phone => contact_phone
    ) do |e| 
      e.group_ids = group_collection
      e.save
    end
  end
end