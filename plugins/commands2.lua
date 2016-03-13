do

function run(msg)
  return "!tetas: muestra tetas.\n!culos: muestra culos.\n!calcular + expresion: calcula expresiones.\n!google + busqueda: responde con una búsqueda de Google.\n!meme: genera memes.\n     -!meme + nombre del meme + texto de abajo + texto de arriba.\n     -!meme listall: muestra lista de nombres de memes.\n \n Saluda a [nombre]: saluda a quien quieras.\n!repite [texto]: el bot repetirá el texto que escribas.\n!torrent [texto]: busca torrents."
end

return {
  description = "Saluda a alguien", 
  usage = "saluda a [name]",
  patterns = {
    "^Más comandos$",
    "^más comandos$",
    "^mas comandos$",
    "^Mas comandos$",
  }, 
  run = run 
}

end