do

function run(msg, matches)
  return "" .. matches[1]
end

return {
  description = "Saluda a alguien", 
  usage = "saluda a [name]",
  patterns = {
    "^!repetir (.*)$",
    "^!say (.*)$",
    "^!escribe (.*)$",
    "^!repite (.*)$"
  }, 
  run = run 
}

end