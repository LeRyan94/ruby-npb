require 'rubygems'
require 'hpricot'
require 'open-uri'

class NPB
  
  NPB_URL = "http://bis.npb.or.jp/2008/games/"

  def games(proxy=nil)
    return parse(get(proxy))
  end
  
  private
  def get(proxy=nil)
    return Hpricot( open(NPB_URL, :proxy => proxy ).read )    
  end
  
  def parse(doc)
    # ƒ`[ƒ€–¼‚ğæ“¾
    teams = []
    (doc/"td.contentsTeam").each do |e|
      teams << e.inner_text.slice(0, 8)
    end
    # “¾“_‚ğæ“¾
    runs = []
    (doc/"td.contentsRuns").each do |e|
      runs << e.inner_text
    end

    # ‡Œ‹‰Ê‚ğì¬‚·‚é
    matches = []
    while teams.size != 0 && runs.size != 0
      matches << teams.slice!(0,2).zip(runs.slice!(0,2)).inject({}){|h, k| h[k[0]] = k[1]; h}
    end
    return matches
  end

end

