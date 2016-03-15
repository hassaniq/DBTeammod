function run(msg, matches)
  local input = matches[1]
  --URL API
  local BASE_URL = "https://api.spotify.com/v1/search"
  local URLP = "?q=".. (URL.escape(input) or "").."&type=track&limit=5" -- Limit 5
  -- Decode
  local decj, tim = https.request(BASE_URL..URLP)
  if tim ~=200 then return nil  end
  -- Tablas
  local spotify = json:decode(decj)
  local tables = {}
  for pri,result in ipairs(spotify.tracks.items) do
    table.insert(tables, {
        spotify.tracks.total,
        result.name,
        result.external_urls.spotify
      })
  end
  -- mas pinches tablas
  local gets = ""
  for pri,cont in ipairs(tables) do
    gets=gets.."▶️ "..cont[2].." - "..cont[3].."\n"
  end
  -- error de busqueda
  local text_end = gets -- terminacion
  if gets == "" then
    text_end = "0 results"
  end
  -- envio de mensaje
  return text_end
end

--comandos
return {
  description = "Search music in spotify. MK: Jarriz.",
  usage = "!Spotify + Name Track",
  patterns = {
    "^![Ss]potify$",
    "^![Ss]potify (.*)$",
    "^/[Ss]potify$",
    "^/[Ss]potify (.*)$",
    "^#[Ss]potify$",
    "^#[Ss]potify (.*)$"
  },
  run = run
}