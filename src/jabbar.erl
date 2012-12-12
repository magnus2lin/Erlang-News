-module(jabbar).
-compile(export_all).

get_first() ->
	List = [{google,"http://news.google.com/news" ++
	"/feeds?hl=en&gl=us&q=erlang&um=1&ie=UTF-8&output=rss"}, 
    {iocoder,"http://coder.io/tag/erlang.rss"},
    {reddit,"http://www.reddit.com/r/erlang.rss"},
    {hacker,"https://news.ycombinator.com/rss"},
    {twitter,"http://search.twitter.com/search.atom?q=%23erlang"},
    {dzone,"http://www.dzone.com/links/feed/search/erlang/rss.xml"}],
	get_first(List,[]).
get_first([{Atom,Source}|T],New) ->
	Item = read(ernews_defuns:read_web(default,Source),Atom),
	URL = element(2,Item),
	get_first(T,[{Atom,URL}|New]);
get_first([],New) ->
	New.


read({error,Reason},_Atom) ->
    {error,Reason};	
read({success,{_Head,Body}},Atom) ->
    [H|_] = ernews_rssread:iterate(Atom,Body),
	H;
read(_,_) ->
	error.

	