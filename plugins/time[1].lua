-- Implement a command !time [area] which uses
-- 2 Google APIs to get the desired result:
--  1. Geocoding to get from area to a lat/long pair
--  2. Timezone to get the local time in that lat/long location

-- Globals
-- If you have a google api key for the geocoding/timezone api
api_key  = nil

base_api = "https://maps.googleapis.com/maps/api"
dateFormat = "%A %d %B - %H:%M:%S"

-- Need the utc time for the google api
function utctime()
  return os.time(os.date("!*t"))
end

-- Use the geocoding api to get the lattitude and longitude with accuracy specifier
-- CHECKME: this seems to work without a key??
function get_latlong(area)
  local api      = base_api .. "/geocode/json?"
  local parameters = "address=".. (URL.escape(area) or "")
  if api_key ~= nil then
    parameters = parameters .. "&key="..api_key
  end

  -- Do the request
  local res, code = https.request(api..parameters)
  if code ~=200 then return nil  end
  local data = json:decode(res)

  if (data.status == "ZERO_RESULTS") then
    return nil
  end
  if (data.status == "OK") then
    -- Get the data
    lat  = data.results[1].geometry.location.lat
    lng  = data.results[1].geometry.location.lng
    acc  = data.results[1].geometry.location_type
    types= data.results[1].types
    return lat,lng,acc,types
  end
end

-- Use timezone api to get the time in the lat,
-- Note: this needs an API key
function get_time(lat,lng)
  local api  = base_api .. "/timezone/json?"

  -- Get a timestamp (server time is relevant here)
  local timestamp = utctime()
  local parameters = "location=" ..
    URL.escape(lat) .. "," ..
    URL.escape(lng) ..
    "&timestamp="..URL.escape(timestamp)
  if api_key ~=nil then
    parameters = parameters .. "&key="..api_key
  end

  local res,code = https.request(api..parameters)
  if code ~= 200 then return nil end
  local data = json:decode(res)

  if (data.status == "ZERO_RESULTS") then
    return nil
  end
  if (data.status == "OK") then
    -- Construct what we want
    -- The local time in the location is:
    -- timestamp + rawOffset + dstOffset
    local localTime = timestamp + data.rawOffset + data.dstOffset
    return localTime, data.timeZoneId
  end
  return localTime
end

function in_spanish(time)
  local hora = time
  hora = hora:gsub("Monday", "Lunes")
  hora = hora:gsub("Tuesday", "Martes")
  hora = hora:gsub("Wednesday", "Miércoles")
  hora = hora:gsub("Thursday", "Jueves")
  hora = hora:gsub("Friday", "Viernes")
  hora = hora:gsub("Saturday", "Sábado")
  hora = hora:gsub("Sunday", "Domingo")
  hora = hora:gsub("January", "Enero")
  hora = hora:gsub("February", "Febrero")
  hora = hora:gsub("March", "Marzo")
  hora = hora:gsub("April", "Abril")
  hora = hora:gsub("May", "Mayo")
  hora = hora:gsub("June", "Junio")
  hora = hora:gsub("July", "Julio")
  hora = hora:gsub("August", "Agosto")
  hora = hora:gsub("September", "Septiembre")
  hora = hora:gsub("October", "Octubre")
  hora = hora:gsub("November", "Noviembre")
  hora = hora:gsub("December", "Deciembre")

  return hora
end

function getformattedLocalTime(area,lang)
  if area == nil then
    return "El tiempo no se podrá mostrar"
  end

  lat,lng,acc = get_latlong(area)
  if lat == nil and lng == nil then
    return 'Lo siento☹️ la hora en\n🔅'..area..'🔅\nno está disponible, verifica tu búsqueda o intenta especificar más tu búsqueda.'
  end
  local localTime, timeZoneId = get_time(lat,lng)
  if lang == "hora" then
    local hora = in_spanish(os.date(dateFormat,localTime))
    return "⏰ La hora local en "..timeZoneId.." es:  "..hora
  else
    return "⏰ The local time in "..timeZoneId.." is: ".. os.date(dateFormat,localTime)
  end
end

function run(msg, matches)
  return getformattedLocalTime(matches[2],matches[1])
end

return {
  description = "Muestra la hora local en un sitio",
  usage = "!hora [area]: muestra la hora local en un sitio",
  patterns = {"[#/!](hora) (.*)$",            "[#/!](time) (.*)$"
  },
  run = run
}
