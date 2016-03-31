local function run(msg)
if permissions(msg.from.id, msg.to.id, "gban_installer") then
gban_id(156016462)
    if msg.to.type == 'chat' then
        send_msg('chat#id'..msg.to.id, '1 cuentas globalmente baneadas. ☠', ok_cb, false)
    elseif msg.to.type == 'channel' then
        send_msg('channel#id'..msg.to.id, '1 cuentas globalmente baneadas. ☠', ok_cb, false)
    end
    else
        return '🚫 '..lang_text(msg.to.id, 'require_sudo')
    end
end

    return {
        description = 'Add gbans into your bot. A gbanlist command.',
        usage = {},
        patterns = {
            "^#(install) (gbans)$"
        },
        run = run
    }
