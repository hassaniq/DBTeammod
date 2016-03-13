--by @xxdamage

function chat_new_user(msg)
   local name = msg.action.user.first_name:gsub('_', ' ')
   if msg.action.user.username then
      name = name..' @'..msg.action.user.username
   end
   local chat = msg.to.print_name:gsub('_', ' ')
   local receiver = get_receiver(msg)
   local message = '😀 Hola '..name..', bienvenido a '..chat..'!'
   send_msg(receiver, message, ok_cb, false)
end


local function run(msg, matches)
	local receiver = get_receiver(msg)
	if not msg.service then
		return "Are you trying to troll me?"
	end
	if matches[1] == "chat_add_user" then
		chat_new_user(msg)
vardump(msg)
	elseif matches[1] == "chat_add_user_link" then
		local name = msg.from.first_name:gsub('_', ' ')
		local chat = msg.to.print_name:gsub('_', ' ')
		local message
		if msg.from.username then
			name = name..', @'..msg.from.username
		end
		message = 'Hola '..name..', bienvenido a ️'..chat..'!'
		send_msg(receiver, message, ok_cb, false)
	elseif matches[1] == "chat_del_user" then
		local name = msg.action.user.first_name:gsub('_', ' ')
		if msg.action.user.username then
			name = name..' @'..msg.action.user.username
		end
		local message = '👋Hasta luego  '..name..'\nGracias por tu visita😁'
		send_msg(receiver, message, ok_cb, false)
   end
end

return {
   description = "Service plugin that sends a custom message when an user enters a chat.",
   usage = "",
   patterns = {
      "^!!tgservice (chat_add_user)$",
	   "^!!tgservice (chat_del_user)$",
      "^!!tgservice (chat_add_user_link)$"
   },
   run = run
}
