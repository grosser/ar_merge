 - Merges associations/attributes you want
 - Can merge duplicates
 - Protects from self-merges
 - Keeps counters valid
 - Removes merged record


INSTALL
=======

Rails plugin

    rails plugin install git://github.com/grosser/ar_merge.git

OR Gem

    gem install ar_merge


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
[Michael Grosser](grosser.it)</br>
michael@grosser.it</br>
License: MIT
