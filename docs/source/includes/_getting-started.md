# Getting Started

## Download the Tutorial Project

To help you get started more quickly, we've provided a repo with some helper
tools in them. The rest of the tutorial will refer to this project. Here it
is:

```bash
$ git clone https://github.com/lfex/mnesia-tutorial.git mnesiatut
$ cd mnesiatut
```

Next, let's get all the dependencies downloaded and built:

```bash
$ make
```

Okay, we're ready to go :-) You can start up an mnesia-ready LFE REPL by
using a ``make`` target we provided in the ``Makefile`` for you. You need to
pass it the path of the database you want to create or connect to, stored in
an environment variable:

```bash
$ lfe -mnesia dir '"/tmp/funky"'
```

This will dump you into the shell, ready to start dataing:

```
Erlang/OTP 17 [erts-6.2] [source] [64-bit] [smp:4:4] ...

   ..-~.~_~--..
  (      \\    )     |   A Lisp-2+ on the Erlang VM
  |`-.._/_\\_.-';    |   Type (help) for usage info.
  |         g (_ \   |
  |        n    | |  |   Docs: http://docs.lfe.io/
  (       a    / /   |   Source: http://github.com/rvirding/lfe
   \     l    (_/    |
    \   r     /      |   LFE v0.11.0-dev (abort with G^)
     `-E___.-'

>
```


## First Run

You're now in the LFE REPL, so let's create a new database on disk, start it
up, and then create a table:

```cl
> (mnt:create-schema #(start true))
ok
> (mnt:create-table 'funky)
#(atomic ok)
>
```

We can take a look at our creation with this command:

```cl
> (mnt:info)
```

Which should give you something like this:

```erlang
---> Processes holding locks <---
---> Processes waiting for locks <---
---> Participant transactions <---
---> Coordinator transactions <---
---> Uncertain transactions <---
---> Active tables <---
funky          : with 0        records occupying 317      words of mem
schema         : with 2        records occupying 541      words of mem
===> System info in version "4.8", debug level = none <===
opt_disc. Directory "/tmp/funky" is used.
use fallback at restart = false
running db nodes   = [nonode@nohost]
stopped db nodes   = []
master node tables = []
remote             = []
ram_copies         = [funky]
disc_copies        = [schema]
disc_only_copies   = []
[{nonode@nohost,disc_copies}] = [schema]
[{nonode@nohost,ram_copies}] = [funky]
3 transactions committed, 0 aborted, 0 restarted, 2 logged to disc
0 held locks, 0 in queue; 0 local transactions, 0 remote
0 transactions waits for other nodes: []
ok
```

You can quit the REPL now, as we'll restart it in the next section.


### Next

We've had a little taste, next we're going to spend some time getting to know
Mnesia a little better.
