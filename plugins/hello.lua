do

function run(msg, matches)
  return "Hola, ¿Como estás? " .. matches[1]
end

return {
  description = "Saluda a alguien", 
  usage = "saluda a [name]",
  patterns = {
    "^saluda a (.*)$",
    "^Saluda a (.*)$"
  }, 
  run = run 
}

end