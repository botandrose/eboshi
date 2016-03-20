# require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
#
# describe ApplicationHelper do
#   describe "number_to_per_hour" do
#     it "should return a formatted string" do
#       helper.number_to_per_hour(10).should == "$10/hr"
#     end
#     it "should include cents if present" do
#       helper.number_to_per_hour(10.50).should == "$10.50/hr"
#     end
#     it "should return nil if passed nil" do
#       helper.number_to_per_hour(nil).should be_nil
#     end
#   end
#
#   describe "currency_or_empty" do
#     it "should return currency if > 0" do
#       helper.currency_or_empty(1.23).should == "$1.23"
#     end
#     it "should return -- if == 0" do
#       helper.currency_or_empty(0.0).should == "--"
#     end
#   end
# end
