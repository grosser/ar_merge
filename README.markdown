 - Merges associations/attributes you want
 - Can merge duplicates
 - Protects from self-merges
 - Keeps counters valid
 - Removes merged record


INSTALL
=======

Rails plugin

    script/plugin install git://github.com/grosser/ar_merge.git

OR Gem

    sudo gem install ar_merge -s http://gemcutter.org


USAGE
=====
Merge from outside the model:

    user.merge!(other,:attributes=>user.attributes.keys,:associations=>%w[movies friends])`

Merge from inside the model

    User < ActiveRecord::Base
      def merge!(other)
        super(other,:attributes=>%w[email website])
      end
    end

Merge duplicates

    #merge all new users, that have the same email
    User.merge_duplicates!(User.find_all_by_status('new')) , :compare=>:email)

AUTHOR
======
[Michael Grosser](http://pragmatig.wordpress.com)  
grosser.michael@gmail.com
Hereby placed under public domain, do what you want, just do not hold me accountable...