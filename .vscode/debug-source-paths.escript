#!/usr/bin/env escript
%% Gleam emits line numbers but no compile_info.source when compiling forms.
%% EDB needs that source path to open the Gleam file in the stack trace.
main(_) ->
    Files = filelib:wildcard("build/dev/erlang/server/_gleam_artefacts/*.abstr"),
    case Files of
        [] -> erlang:error(no_gleam_build_artifacts);
        _ -> lists:foreach(fun compile_module/1, Files)
    end.

compile_module(File) ->
    {ok, Encoded} = file:read_file(File),
    Forms = binary_to_term(Encoded),
    [Source | _] = [Path || {attribute, _, file, {Path, _}} <- Forms],
    Options = [binary, debug_info, beam_debug_info, beam_debug_stack,
               {source, filename:absname(Source)}, return_errors],
    case compile:forms(Forms, Options) of
        {ok, Module, Beam} ->
            Output = filename:join([filename:dirname(filename:dirname(File)),
                                    "ebin", atom_to_list(Module) ++ ".beam"]),
            ok = file:write_file(Output, Beam),
            io:format("Debug source: ~s~n", [Source]);
        Error -> erlang:error({debug_compile_failed, File, Error})
    end.
