% server
-module(server).
-export([server/0]).


server()->
	{Socket, Fd} = startup(),
	loop({Socket, Fd}).

startup()->
	Domain = inet,
	Type = stream,
	Protocol = tcp,
	{ok, Socket} = socket:open(Domain, Type, Protocol),
	socket:open(Domain, Type, Protocol),
	socket:setopt(Socket, {socket,reuseaddr}, true),
	socket:bind(Socket, #{family => inet, port => 1234, addr => any}),
	socket:listen(Socket),
	Socket.

loop({Socket, Fd}) ->
	{Resp, Res} = socket:accept({Socket, Fd}, 1),
	if 	Resp == ok -> 
			io:format("Server received binary =~p~n", [Res]),
			do_something(Res),
			Closed = socket:close(Res),
			io:format("Server closed socket =~p~n", [Closed]);
		Resp == error -> ok
	end,
    loop({Socket, Fd}).


do_something(ConnFD) ->
	{Resp, Res} = socket:recv(ConnFD),
	if Resp == ok ->
			io:format("Server received binary =~p~n", [Res]);
		Resp == error ->
			io:format("Server received error =~p~n", [Res])
	end,
	Msg = "world",
	socket:send(ConnFD, Msg).
