require "spec_helper"

describe LineItemsController do
  include ControllerSpecHelpers

  let(:client) { FactoryBot.create(:client) }
  let(:work) { FactoryBot.create(:work, client: client, timestamp: 2, notes: "test") }

  describe "on update" do
    it "updates notes if note is newer than existing" do
      put :update, client_id: client.id, id: work.id, line_item: { timestamp: 3, notes: "testing" }
      response.should be_success
      work.reload.notes.should == "testing"
    end

    it "rejects notes update if note is older than existing" do
      put :update, client_id: client.id, id: work.id, line_item: { timestamp: 1, notes: "testing" }
      response.should be_success
      work.reload.notes.should == "test"
    end
  end
end
