do
function run(msg)
  math.randomseed(os.time());
  num = math.random(0,5);
  if num == 0 then
   return "Que genial verte de nuevo! "
  elseif num == 1 then
   return "Hey que gusto verte de nuevo! "
  elseif num == 2 then
   return "Hola ¿Como estas?"
  elseif num == 3 then
   return "Que tal? "
  elseif num == 4 then
   return "Hola!"
  elseif num == 5 then
   return "Hey! hola, que tal?"
 end
 
end

return {
  description = "Responde a Hola", 
  usage = "Responde a Hola",
  patterns = {
    "^[Hh]ola$",
    "^[Oo]la$"
  }, 
  run = run 
}

end
