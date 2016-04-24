# Structure

## Starting Again

> Restart the LFE REPL using a new data directory:

```bash
$ lfe -mnesia dir '"./Company.DB"'
```

> Create a default database schema:

```lisp
> (mnt:create-schema #(start true))
ok
```

We've had a quick taste of Mnesia, and what some of the calls look like in LFE.
Next we're going to tackle a bit more heady stuff: tables and relationships.

After you have quite from your previous LFE REPL, restart using a different database name and then create a default schema, auto-starting Mnesia.

Then pull in the example code that defines our tables, adding them to the
Mnesia schema we just created:

```cl
> (slurp "examples/structure.lfe")
#(ok structure)
>
```

## Records as Tables

The ``structure`` example module includes LFE records that act as our table definitions,
as well as a macro that lets us create Mnesia tables with almost no boilerplate.

The following records are defined in ``examples/tables.lfe``:

```cl
(defrecord employee
  id
  name
  salary
  gender
  phone
  room-number)

(defrecord department
  id
  name)

(defrecord project
  name
  number)

(defrecord manager
  employee-id
  department-id)

(defrecord in-department
  employee-id
  department-id)

(defrecord in-project
  employee-id
  project-name)
```

These records (tables) are taken from the example given in the
<a href="http://www.erlang.org/doc/apps/mnesia/Mnesia_chap2.html#id63101">Erlang
 Mnesia tutorial</a> which also gives this entity diagram for their proposed
 "Company" database:

<img src="http://www.erlang.org/doc/apps/mnesia/company.gif" />


### 3.3 Creating Our Tables

In the ``src/structure.lfe`` module which we have just imported, some utility
functions are defined which will lets us easily create tables in Mnesia based
on the records defined in the ``include/tables.lfe`` file. Of particular
interest right now is the ``(init)`` function; let's call it:

```cl
> (init)
#(ok
  (#(create-set-tables (#(atomic ok) #(atomic ok) #(atomic ok) #(atomic ok)))
   #(create-bag-tables (#(atomic ok) #(atomic ok)))))
>
```

This just created all our Mnesia tables for us. If we run it again, we'll see
errors indicating that the tables have already been created:

```cl
> (init)
#(error
  (#(create-set-tables
     (#(aborted #(already_exists employee))
      #(aborted #(already_exists department))
      #(aborted #(already_exists project))
      #(aborted #(already_exists in-department))))
   #(create-bag-tables
     (#(aborted #(already_exists manager))
      #(aborted #(already_exists in-project))))))
>
```

As you may guess from the output of that second call, under the covers, the
``init`` function calls a couple of utility functions:

* ``(structure:create-set-tables)``, and
* ``(structure:create-bag-tables)``

These, in turn, call a macro we created to make table-creation much easier.
The custom macro alleviates the dev from having to write tedious and repetitive
boilerplate code. This macro actually calls another macro that is generated
-- by LFE -- for each record (one that gets a list of all the fields for a
given record).

Next, let's re-run that ``info`` function we saw in the previous section:

```cl
> (mnesia:info)
```

The output of that function will be very similar to what we saw in the
previous section. However, do note that our new tables are reported in the
"Active tables" section:

```
...
---> Active tables <---
in-project     : with 0        records occupying 305      words of mem
in-department  : with 0        records occupying 305      words of mem
manager        : with 0        records occupying 305      words of mem
project        : with 0        records occupying 305      words of mem
department     : with 0        records occupying 305      words of mem
employee       : with 0        records occupying 305      words of mem
...
```

If you would like to check up on the tables created above, you can use the
``table_info`` function to pull out certain data. For instance, here's how
you find what backend type is being used for any given table:

```cl
> (mnesia:table_info 'employee 'type)
set
> (mnesia:table_info 'in-project 'type)
bag
>
```

If you're interested in seeing *all* the details of any given table, you can
do so with the ``'all`` parameter:

```cl
> (mnesia:table_info 'employee 'all)
(#(access_mode read_write)
#(active_replicas (nonode@nohost))
#(all_nodes (nonode@nohost))
#(arity 7)
#(attributes (id name salary gender phone room-number))
#(checkpoints ())
#(commit_work ())
#(cookie #(#(1396 680215 616649) nonode@nohost))
#(cstruct
 #(cstruct
   employee
   set
   (nonode@nohost)
   ()
   ()
   0
   read_write
   false
   ()
   ()
   false
   employee
   (id name salary gender ...)
   ()
   ()
   ()
   #(...)...))
#(disc_copies ())
#(disc_only_copies ())
#(frag_properties ())
#(index ())
#(load_by_force false)
#(load_node nonode@nohost)
#(load_order 0)
#(load_reason #(dumper create_table))
#(local_content false)
#(majority false)
#(master_nodes ())
#(memory 317)
#(ram_copies (nonode@nohost))
#(record_name employee)
#(record_validation #(employee 7 set))
#(type set)
#(size 0)
#(snmp ())
#(storage_properties ...)
#(...)...)
>
```

Next up, we'll start inserting some data.



