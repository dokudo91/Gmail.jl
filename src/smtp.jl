using SMTPClient

"""
    send_mail(username, passwd, toaddresses::AbstractArray{<:AbstractString}, subject, msg)
    send_mail(username, passwd, toaddress::AbstractString, subject, msg)
    send_mail(username, passwd, subject, msg)

メールを送信する
"""
function send_mail(username, passwd, toaddresses::AbstractArray{<:AbstractString}, subject, msg)
    if isempty(toaddresses)
        toaddresses = [username]
    end
    opt = SendOptions(; isSSL=true, username, passwd)
    body = get_body(toaddresses, username, subject, msg)
    send("smtps://smtp.gmail.com:465", toaddresses, username, body, opt)
end
function send_mail(username, passwd, toaddress::AbstractString, subject, msg)
    send_mail(username, passwd, [toaddress], subject, msg)
end
function send_mail(username, passwd, subject, msg)
    send_mail(username, passwd, [username], subject, msg)
end

"""
    create_msg(contents...)

本文を作成する

# Example
```
create_msg("aaa", 1, IOBuffer())
```
"""
function create_msg(contents...)
    io = IOBuffer()
    for content in contents
        println(io, content)
    end
    take!(io) |> String
end