require 'rubygems'
require 'hpricot'
require 'open-uri'

#
#= ruby-npb
#
#Author:: Yu Tsuda
#Mail:: yu.tsuda@gmail.com
#Description:: This is a ruby library for getting some information about NPB.
#
#== History of Development
#See also: http://github.com/yutsuda/ruby-npb/tree/master
#

class NPB
  
  NPB_URL = "http://bis.npb.or.jp/"
  GAMES_DIR = "/games/"
  STATS_DIR = "/stats/"
  THIS_YEAR = Time.now.year.to_s

  #
  # Get Scores of the Games
  #
  def games(proxy=nil)
    doc = get(NPB_URL+THIS_YEAR+GAMES_DIR, proxy)
    
    # get teams name
    teams = get_elements(doc, "td.contentsTeam")
    
    # get scores
    runs = get_elements(doc, "td.contentsRuns")
    
    matches = []
    while teams.size != 0 && runs.size != 0
      matches << teams.slice!(0,2).zip(runs.slice!(0,2)).inject({}){|h, k| h[k[0]] = k[1]; h}
    end

    return matches
    
  end
  
  private
  def get(url, proxy=nil)
    return Hpricot( open(url, :proxy => proxy ).read )    
  end
  
  def get_elements(doc, element)
    elements = []
    (doc/element).each do |e|
      elements << e.inner_text
    end
    return elements
  end
    
end

