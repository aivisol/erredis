% client
-module(client).
-export([client/0]).

client()->
	Domain = inet,
	Type = stream,
	Protocol = tcp,
	{ok, Socket} = socket:open(Domain, Type, Protocol),
	ok = socket:connect(Socket, #{family => inet, port => 1234, addr => any}),
	Msg = "hello",
	socket:send(Socket, Msg),
	{Resp, Res} = socket:recv(Socket),
	if Resp == ok ->
			io:format("Server received binary =~p~n", [Res]);
		Resp == error ->
			io:format("Server received error =~p~n", [Res])
	end.
