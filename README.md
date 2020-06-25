execv
=====

To run and replace the current erlang runtime as an external program.

This is an interface to https://linux.die.net/man/3/execv.

For example, the following code starts an `vim` program, and it never
goes back to the erlang shell after `vim` exits.

```
➜  rebar3 shell
===> Verifying dependencies...
===> Compiling execv
Erlang/OTP 23 [erts-11.0.2] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe] [dtrace]

Eshell V11.0.2  (abort with ^G)

1> execv:run("/usr/local/bin/vim", []).

```

Another example to run a command with arguments:

```
1> execv:run("/usr/bin/grep", ["deps", "/tmp/emqx.rebar.config"]).

         [{deps,
         [{deps,
         [{deps,
         [{deps,
```

Build
-----

    $ rebar3 compile

For now only absolute command path is supported.
