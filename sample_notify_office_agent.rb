require 'win32ole'
require 'npb'

#HTTP_PROXY="http://proxy.kuins.net:8080"
KYLE = "C:\\Program Files\\Microsoft Office\\OFFICE11\\DOLPHIN.ACS"


games = NPB.new.games

agent = WIN32OLE.new("Agent.Control")
agent.connected = true
r = agent.Characters.load("dol", KYLE)

while r.status != 0 &&  r.status != 1
    puts 'loading...'
end
dol = agent.Characters.Character("dol")
dol.Activate(2);

dol.show();
games.each do |g|
  g.keys.each do |i|
    dol.speak(i + ": " +  g[i])
  end
  dol.speak("=============")
  dol.play("IDLE(1)")
end
dol.hide();

sleep(15)
