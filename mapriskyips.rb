#!/usr/bin/ruby

require 'rubygems'
require 'getopt/std'
require 'pp'
require 'xmlsimple'
require 'geocoder'
require 'simple-rss'
require 'open-uri'

#Get RSS feeds
#Parse RSS feeds
#Pass IPs through geocode
#output coordinates in some format

def get_rss_feed(feed)
  rss = SimpleRSS.parse open(feed)
  return rss
end

def parse_feed(rss)
  ip_list = Array.new
  rss.items.each{|ip|
    #pp ip
    #pp ip.title
    ip_list << ip.title.split('|')[0].strip
  }
  return ip_list
end

def geocode_ip(iplist)
  geocodes = Array.new
  iplist.each{|ip|
    s = Geocoder.search(ip)
    pp s
  }
  return geocodes
end

def create_output(geocode)
end

def main()

# http://www.projecthoneypot.org/list_of_ips.php?t=h&rss=1&rf=138409
#http://www.projecthoneypot.org/list_of_ips.php?t=p&rss=1&rf=138409
#http://www.projecthoneypot.org/list_of_ips.php?t=s&rss=1&rf=138409
#http://www.projecthoneypot.org/list_of_ips.php?t=d&rss=1&rf=138409

  types = ["h", "p", "s", "d"]
  list = Array.new
  geocodes = Array.new
  
  types.each{|x|
  link = "http://www.projecthoneypot.org/list_of_ips.php?t=#{x}&rss=1&rf=138409"
  rss = get_rss_feed(link)
  list << parse_feed(rss)
  }
  puts "Done"
  list = list.flatten
  geocode_ip(list)
  #create_output()
  
end

main()