require "spec_helper"

describe ARMerge do
  describe "#merge!" do
    before do
      @user = User.create!(:name=>'x')
      @u2 = User.create!(:name=>'y')
    end

    describe :removal do
      it "removes the merged user" do
        @user.merge!(@u2)
        lambda{@u2.reload}.should raise_error(ActiveRecord::RecordNotFound)
      end

      it "saves the merging user" do
        @user.should_receive(:save!)
        @user.merge!(@u2)
      end
    end

    describe :attributes do
      it "merges and overtakes attributes" do
        @user.name = ''
        @user.merge!(@u2,:attributes=>['name'])
        @user.name.should == 'y'
      end

      it "does not overtake attributes when current is not blank" do
        @user.merge!(@u2,:attributes=>['name'])
        @user.name.should == 'x'
      end
    end

    describe :associations do
      before do
        Movie.delete_all
        @user.movies << Movie.new
        @user.save!
        @user.movies.size.should == Movie.count
      end

      it "overtakes associated objects" do
        @u2.merge!(@user,:associations=>[:movies])
        @u2.reload.should have(Movie.count).movies
      end

      it "does not create new objects" do
        lambda{@u2.merge!(@user,:associations=>['movies'])}.should_not change(Movie,:count)
      end

      it "keeps counters in sync" do
        pending if ActiveRecord::VERSION::MAJOR == 4
        user, merged_user = CountingUser.create!, CountingUser.create!
        user.movies_count.should == 0
        merged_user.movies << Movie.new
        merged_user.save!
        merged_user.reload.movies_count.should == 1

        user.merge!(merged_user,:associations=>[:movies])
        user.reload.movies_count.should == 1
      end
    end

    it "does no merge with new" do
      lambda{@user.merge!(User.new)}.should raise_error
    end

    it "does no merge with self" do
      lambda{@user.merge!(User.find(@user.id))}.should raise_error
    end
  end

  describe "#merge_duplicates!" do
    before do
      @u1 = User.create!(:name=>'a')
      @u2 = User.create!(:name=>'b')
      @u3 = User.create!(:name=>'a')
      @u4 = User.create!(:name=>'a')
      @users=[@u1,@u2,@u3]
    end

    it "merges all records that have the same attributes" do
      User.merge_duplicates!(@users,:compare=>:name).should == [@u1,@u2]
    end

    it "destroys the duplicates" do
      User.merge_duplicates!(@users,:compare=>:name)
      lambda{@u3.reload}.should raise_error(ActiveRecord::RecordNotFound)
    end

    it "merges the first with each of its duplicates" do
      @users = [@u2,@u3,@u1,@u4]
      @u3.should_receive(:merge!).with(@u1)
      @u3.should_receive(:merge!).with(@u4)
      User.merge_duplicates!(@users,:compare=>:name).should == [@u2,@u3]
    end
  end

  it "has a VERSION" do
    ARMerge::VERSION.should =~ /^\d+\.\d+\.\d+$/
  end

  it "does not mess up activerecord version" do
    ARMerge::VERSION.should_not == ActiveRecord::VERSION
    defined?(ActiveRecord::Version).should == nil
    defined?(ActiveRecord::Base::Version).should == nil
  end
end
