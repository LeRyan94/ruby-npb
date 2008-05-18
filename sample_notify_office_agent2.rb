require 'win32ole'
require 'npb'


KYLE = "C:\\Program Files\\Microsoft Office\\OFFICE11\\DOLPHIN.ACS"

player_rank = NPB.new.player_stats

agent = WIN32OLE.new("Agent.Control")
agent.connected = true
r = agent.Characters.load("dol", KYLE)

while r.status != 0 &&  r.status != 1
    puts 'loading...'
end
dol = agent.Characters.Character("dol")
dol.Activate(2);

dol.show();
player_rank.each do |p|
  p.keys.each do |i|
    dol.speak(i + ": " +  g[i])
  end
  dol.speak("=============")
  dol.play("IDLE(1)")
end
dol.hide();

sleep(15)
