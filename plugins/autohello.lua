do
function run(msg)
  math.randomseed(os.time());
  num = math.random(0,5);
  if num == 0 then
   return "Hey! hello! "
  elseif num == 1 then
   return "Hi!! "
  elseif num == 2 then
   return "Hi! how are you? "
  elseif num == 3 then
   return "hey! what's up? "
  elseif num == 4 then
   return "Hello!"
  elseif num == 5 then
   return "Hey! hi! "
 end
 
end

return {
  description = "Responde a Hola", 
  usage = "Responde a Hola",
  patterns = {
    "^[Hh]i$",
    "^[Hh]ello$"
  }, 
  run = run 
}

end
