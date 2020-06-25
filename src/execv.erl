-module(execv).

-export([run/2]).
-on_load(init/0).

-define(APPNAME, execv).
-define(LIBNAME, execv).

run(CmdFileName, Args)  ->
    run(full_cmd_line(CmdFileName, Args)).

run(_) ->
    not_loaded(?LINE).

init() ->
    SoName = filename:join(priv_dir(), ?LIBNAME),
    erlang:load_nif(SoName, 0).

priv_dir() ->
    PrivDir = case code:priv_dir(?APPNAME) of
        {error, bad_name} ->
            Priv = filename:join(["..", priv]),
            case filelib:is_dir(Priv) of
                true -> Priv;
                _ -> "priv"
            end;
        Dir -> Dir
    end,
    filename:absname(PrivDir).


full_cmd_line(CmdFileName, Args) when is_list(Args) ->
    StartScript = filename:join([priv_dir(), "reset_and_exec.sh"]),
    [StartScript, absfilename(CmdFileName)] ++ Args.

absfilename(Filename) ->
    case filelib:is_file(Filename) of
        true ->
            filename:absname(Filename);
        false ->
            error({not_file, Filename})
    end.

not_loaded(Line) ->
    erlang:nif_error({not_loaded, [{module, ?MODULE}, {line, Line}]}).
