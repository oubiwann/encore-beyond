#############
Encore Beyond
#############

Introduction
============

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

Dependencies
------------

This project assumes that you have `rebar`_ installed somwhere in your
``$PATH``.

This project depends upon the following, which installed to the ``deps``
directory of this project when you run ``make deps``:

* `LFE`_ (Lisp Flavored Erlang; needed only to compile)
* `lfeunit`_ (needed only to run the unit tests)

Installation
============

Just clone this puppy and jump in:

.. code:: bash

Dev server:
    $ git clone https://github.com/lfe/yaws-rest-starter.git
    $ cd yaws-rest-starter
    $ make dev

Production server:
    $ made run

This will install all the dependencies and start up the YAWS server.


Usage
=====

Add content to me here!

.. Links
.. -----
.. _rebar: https://github.com/rebar/rebar
.. _LFE: https://github.com/rvirding/lfe
.. _lfeunit: https://github.com/lfe/lfeunit
