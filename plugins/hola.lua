do

function run(msg, matches)
  return "Hola!"
end

return {
  description = "Saluda a alguien", 
  usage = "saluda a [name]",
  patterns = {
    "^Hola$",
    "^hola$",
    "^Ola$",
    "^ola$"
  }, 
  run = run 
}

end