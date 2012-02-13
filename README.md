 mscgen for ruby
======================

[Mscgen](http://www.mcternan.me.uk/mscgen/) is simple sequence chart generator. 
This gem generates a script for mscgen. This can generate sequence image(i.e. png, svg...) if you set mscgen path.

 Requirements
----------

* install mscgen

    $ yum install mscgen # Linux(CentOS, Fedora..)
    $ brew isntall mscgen # MacOS X


 Install
----------

    $ gem install mscgen


 Usage
----------
### Setting Mscgen Path

    Builder.mscgen_path = '/usr/local/bin/mscgen'

### Create sequence scripts or images

    require 'mscgen'
    
    # create builder
    builder = Mscgen::Builder.new
    
    # add entities and messages
    a = builder.add_entity('a')
    b = builder.add_entity('b')
    builder.add_message(Mscgen::Message.new(a,b, 'label'))
    
    # create image file
    builder.build('seq.png', :png)



 Contributing to mscgen
----------
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

 Copyright
----------
Copyright (c) 2012 Masata NISHIDA. See LICENSE.txt for further details.

