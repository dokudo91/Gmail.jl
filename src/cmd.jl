using ArgParse

include("smtp.jl")

function create_settings()
    s = ArgParseSettings()
    @add_arg_table! s begin
        "send"
        action = :command
        help = "メールを送信する"
    end
    @add_arg_table! s["send"] begin
        "--username", "-u"
        default = "username"
        help = "送信元メールアドレス"
        "--password", "-p"
        default = "password"
        help = "パスワード"
        "--subject", "-s"
        default = "subject"
        help = "題名"
        "--msg", "-m"
        default = "msg"
        help = "本文"
        "--to", "-t"
        nargs = '*'
        arg_type = String
        help = "宛先メールアドレス。省略した場合、usernameにメールする。"
    end
    s
end

function run_cmd()
    s = create_settings()
    args = parse_args(s; as_symbols=true)::Dict{Symbol,Any}
    command = args[:_COMMAND_]::Symbol
    cargs = args[command]::Dict{Symbol,Any}
    if command == :send
        run_send(cargs)
    end
end

"""
```
s = create_settings()
args = parse_args(["send"], s; as_symbols=true)
command = args[:_COMMAND_]
cargs = args[command]
run_send(cargs)
```
"""
function run_send(cargs)
    username = cargs[:username]::String
    password = cargs[:password]::String
    subject = cargs[:subject]::String
    msg = cargs[:msg]::String
    to = cargs[:to]::Vector{String}
    send_mail(username, password, to, subject, msg)
end

isinteractive() || run_cmd()
