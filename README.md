# mnemosyne

[![][mnemosyne-logo]][mnemosyne-logo-large]

[mnemosyne-logo]: resources/images/mnemosyne-y500.png
[mnemosyne-logo-large]: resources/images/mnemosyne-y2000.png

*A Lispy wrapper for Erlang Mnesia and QLC*


##### Contents

* [Introduction](#introduction-)
* [Modules](#modules-)
* [Resources](#resources-)
* [Documentation](#documentation-)
* [License](#license-)


## Introduction [&#x219F;](#contents)

This project offers very little over and above what is provided by the Erlang/OTP ``mnesia`` and ``qlc`` modules.


## Modules [&#x219F;](#contents)

The Erlang namespaces for the modules (ab)used by this project are the following:

* ``mnesia``
* ``qlc``

These are accessible via those same module names in LFE, or using this library, from the following:

* ``mns``
* ``mns-drty`` - split dirty functions into their own module ("dirty" operations are short-cuts that bypass much of the processing and increase the speed of the transaction)
* ``mns-qry`` - qlc alias; longer to type than ``qlc``, but provides some nice visual context

Function names in the ``mnemo*`` modules have the Erlang underscores replaced with LFE hyphens. This work is done via the LFE [kla](https://github.com/lfex/kla) library.


## Resources [&#x219F;](#contents)

* [Mnesia in LYSE](http://learnyousomeerlang.com/mnesia) - One of the best learning-Mnesia resources on the web. Or in print -- buy the book!
* The official [Mnesia docs](http://erlang.org/doc/apps/mnesia/Mnesia_chap1.html)
  * [mnesia module](http://erlang.org/doc/man/mnesia.html)
  * [qlc module](http://erlang.org/doc/man/qlc.html)


## Documentation [&#x219F;](#contents)

TBD


## License [&#x219F;](#contents)

```
Copyright © 2016 Duncan McGreggor

Distributed under the Apache License, Version 2.0.
```