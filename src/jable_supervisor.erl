%%%-------------------------------------------------------------------
%%% @author Khashayar <khashayar@localhost.localdomain>
%%% @copyright (C) 2012, Khashayar
%%% @doc
%%%
%%% @end
%%% Created : 30 Sep 2012 by Khashayar <khashayar@localhost.localdomain>
%%%-------------------------------------------------------------------
-module(jable_supervisor).
-compile(export_all).

-include("records.hrl").

start(List_Of_All_Sources) ->
    spawn(?MODULE,init,[List_Of_All_Sources]).

start_link(List_Of_All_Sources) ->
    register(?MODULE, Pid=spawn_link(?MODULE, init, [List_Of_All_Sources])),
    Pid.

init(List) ->
    process_flag(trap_exit, true),
    loop(#sup_state{processes = orddict:new(),
		    sources = List}).

add(Source_Name,Source)->
    ?MODULE ! {add,Source_Name,Source}.

loop(State=#sup_state{}) ->
    receive
	{'EXIT', _From, shutdown} ->
	    io:format("Done Here" , []),
            exit(shutdown); % will kill the child too
        {'EXIT', Pid, _Reason} ->
            %%Write to data base what goes wrong and stuff
	    Checker = orddict:fetch(Pid, State#sup_state.processes),
	    New_Processes = orddict:erase(Pid, State#sup_state.processes),
	    New_Sources = [{Checker#checker.source_name , 
			    Checker#checker.source} | 
			   State#sup_state.sources],
	    loop(State#sup_state{processes = New_Processes,
				sources = New_Sources});
	{add,Source_Name,Source} ->
	    New_Sources = [{Source_Name,Source}|
			   State#sup_state.sources],
	    loop(State#sup_state{sources = New_Sources})
    after 0 ->
	    case State#sup_state.sources of
		[{Source_Name, Source} |Tail] ->
		    Pid = apply(checker, start_link , [Source]),
		    io:format("Created New Process ~p -- ~p : ~p~n",
			      [Pid, Source_Name, Source]),
		    New_Processes = orddict:store(Pid, 
						  #checker{pid = Pid,
							   source_name = Source_Name,
							   source = Source},
						  State#sup_state.processes),
		    loop(State#sup_state{processes = New_Processes , 
					 sources = Tail});
		[] ->
		    loop(State)
	    end
    end.
	
