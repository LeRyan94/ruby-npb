require 'rubygems'
require 'hpricot'
require 'open-uri'

class NPB
  
  NPB_URL = "http://bis.npb.or.jp/" + Time.now.year.to_s + "/games/"
  
  # �������ʂ��擾
  def games(proxy=nil)
    doc = get(proxy)
    
    # �`�[�������擾
    teams = get_elements(doc, "td.contentsTeam")
    
    # ���_���擾
    runs = get_elements(doc, "td.contentsRuns")
    
    matches = []
    while teams.size != 0 && runs.size != 0
      matches << teams.slice!(0,2).zip(runs.slice!(0,2)).inject({}){|h, k| h[k[0]] = k[1]; h}
    end

    return matches
    
  end
  
  private
  def get(proxy=nil)
    return Hpricot( open(NPB_URL, :proxy => proxy ).read )    
  end
  
  def get_elements(doc, element)
    elements = []
    (doc/element).each do |e|
      elements << e.inner_text
    end
    return elements
  end
    
end

