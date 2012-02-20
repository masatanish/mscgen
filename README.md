 mscgen for ruby
======================

[Mscgen](http://www.mcternan.me.uk/mscgen/) is simple sequence chart generator. 
This gem generates a script for mscgen. This can generate sequence image(i.e. png, svg...) if you set mscgen path.

 Requirements
----------
### install mscgen

     $ yum install mscgen # Linux(CentOS, Fedora..)
     $ brew isntall mscgen # MacOS X


 Install
----------

    $ gem install mscgen


 Usage
----------

    require 'rubygems'
    require 'mscgen'
    
    # set mscgen path (default is 'mscgen')
    Mscgen.path = '/usr/local/bin/mscgen'

    # create chart
    chart = Mscgen::Chart.new
    
    # add entities and messages
    a = chart.add_entity('a')
    b = chart.add_entity('b')
    c = chart.add_entity('ccc')

    # create messages
    chart.add_message(a,b, 'hoge', :type => :method)
    chart.add_message(b,a, 'return', :type => :method_return)
    chart.add_message(b,c, 'hoge')
    
    # create image file
    chart.to_img('seq.png', :png)

    # or create a script for mscgen
    script = chart.to_msc
    File.open('seq.txt', 'w') {|f| f.write script }

### Support Image Format
 
* png
* svg
* eps
* ismap

refer `mscgen --help`.


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

