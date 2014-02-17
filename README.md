# Encore Beyond

Wikipage: https://github.rackspace.com/rackertools/dev/wiki/Encore-Beyond

## Introduction

Encore Beyond is a service providing a mechanism for storing, appending,
and retrieving structured text (likely in the form of JSON). Traditionally,
CORE has seen a proliferation of data fields added due to temporary needs
to store data about core CORE models. The value of these fields fades yet
they continue to live on in the schema, increasing the brittleness of the
schema. Many of these fields are of no concern to core CORE functionality,
they are simply stored there.

Encore Beyond seeks to solve this problem by providing a proving ground for
fields beyond the necessary Encore fields. Clients are free to add/remove
fields, scoped at the proper level and make decisions based on this
additional "metadata". Encore Beyond is essentially Metadata-As-A-Service.
At the moment these fields will need to be explictly searched or indexed,
they become candidates for moving into the Encore schemas. The advantage
of this approach is that clients have the flexibility to "adapt" the
schemas to fit their needs while Encore is free to keep their schemas
"clean".


### Technology

This is a project builds a RESTful service in
[LFE](https://github.com/rvirding/lfe) and runs on top of the
[YAWS](https://github.com/klacke/yaws)
([Erlang](http://www.erlang.org/)) web server. Of many frameworks tried (several in
Python, Ruby, and Clojure), this one had the best performance overall when
rating request/s, memory concumption, and platform stability. Furthermore, in less
than two hours, were we able to build a REST *framework* capable of handling
80,000 concurrent connections. Subsequent service setups using this framework take
mere seconds to set up.


### Dependencies

This project assumes that you have
[rebar](https://github.com/rebar/rebar) installed somwhere in your ``$PATH``.

If you are running Ubuntu, you will need to install the following:
```bash
    $ sudo apt-get install erlang libpam0g-dev
```

The latter is needed to compile YAWS.

This project depends upon the following, which is automatically installed by
rebar to the ``deps`` directory of this project when you run ``make deps``
(also done implicitely by ``make compile``):

* [Erlang](http://www.erlang.org/)
* [LFE](https://github.com/rvirding/lfe) (Lisp Flavored Erlang; needed only
   to compile)
* [lfeunit](https://github.com/lfe/lfeunit) (needed only to run the unit tests)
* [YAWS](https://github.com/klacke/yaws) (The granddaddy of Erlang web servers)


## Installation

Just clone this puppy and jump in:

```bash
    $ git clone https://github.rackspace.com/rackertools/encore-beyond.git
    $ cd encore-beyond
    $ make compile
```

This will install all the dependencies and compile everything you need.


### Troubleshooting

If your compile process fails, you may need to run ``make get-deps`` explicitly
and then re-run ``make compile``.


## The Encore Beyond Server

### Starting and Stopping

To start the YAWS server + Encore Beyond service in development mode, with any
printing (e.g., ``(: io format ...)``) sent to sdout, just do this:
```bash
    $ make dev
```

To run the daemon, do:
```bash
    $ make run
```

To stop the server once in daemon mode, do:
```bash
    $ make stop
```

### Benchmarks

Benchmarks are a lie. Okay, now that we've gotten that out of the way, on
with the lies!

Running ``httperf`` and ``ab`` against the demo REST service on a 2012 MacBook
Pro laptop with tons of other crap running on it gives **reqs/s** in the
**14,000** to **18,000** range.

Here's an example ``ab`` command that was used:
```bash
    $ ab -k -c 100 -n 20000 http://localhost:8000/
```

And one for ``httperf``:

```bash
    $ httperf --hog \
      --server localhost --port 8000 --uri / \
      --timeout 5 --rate 100 \
      --num-calls 10000 --num-conns 10
```
