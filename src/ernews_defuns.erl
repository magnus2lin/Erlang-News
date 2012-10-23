%%%-------------------------------------------------------------------
%%% @author Ingimar <ingimar@student.gu.se>
%%% @author Khashayar <khashayar@localhost.localdomain>
%%% @author Magnus <magnus@localhost.localdomain>
%%% @copyright (C) 2012, Ingimar
%%% @copyright (C) 2012, Khashayar
%%% @copyright (C) 2012, Magnus
%%% @doc
%%%
%%% @end
%%% Created : 8 Oct 2012 by Ingimar <ingimar@student.gu.se>
%%%-------------------------------------------------------------------
-module(ernews_defuns).
-compile(export_all).


%% <function author="Magnus & Ingimar">
%% read_web: Attempts to fetch and read a document from an URL

%% Reading document was a success
%% Return Header and Body tuple with success Atom
read_web({ok, {{_Version, _, _ReasonPhrase}, Headers, Body}}) ->
	{success,{Headers,Body}};
	
%% read_web/2 - next 5 functions:
%% Reading document returns errors
%% Return tuple with error Atom and associated reason Atom
read_web({error,no_scheme})->
	{error,broken_html};
read_web({error,{failed_connect,_}})->
	{error,connection_failed}; % broken link
read_web({error,{ehostdown,_}})->
	{error,host_is_down};
read_web({error,{ehostunreach,_}})->
	{error,host_unreachable};
read_web({error,{etimedout,_}})->
	{error,connection_timed_out};
	
%% For anything else - return unkown_error
read_web(_) ->
	{error,unkown_error}.

%% Default reader
read_web(default,Src) ->
    ssl:start(),
    inets:start(),
    read_web(httpc:request(Src));
	
%% Reader for coder.io
read_web(iocoder,Src) ->
    ssl:start(),
    inets:start(),
    read_web(httpc:request(get, {Src, []}, [{autoredirect, false}], [])).
%% </function>

% <function author="Khashayar">
% Converts pubDate from RSS document to Erlang date
convert_pubDate_to_datetime(DateTime) ->
    {ok,[_Day, Date, MonthS, Year,HH,MM,SS], _} = 
	io_lib:fread("~3s, ~2d ~3s ~4d ~2d:~2d:~2d" , DateTime),
    Month = case MonthS of
		"Jan" ->
		    1;
		"Feb" ->
		    2;
		"Mar" ->
		    3;
		"Apr" ->
		    4;
		"May" ->
		    5;
		"Jun" ->
		    6;
		"Jul" ->
		    7;
		"Aug" ->
		    8;
		"Sep" ->
		    9;
		"Oct" ->
		    10;
		"Nov" ->
		    11;
		"Dec" ->
		    12
	    end,
    {{Year,Month,Date},{HH,MM,SS}}.
%% </function>
