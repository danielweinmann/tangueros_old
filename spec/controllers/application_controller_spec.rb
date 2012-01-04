require 'spec_helper'

describe ApplicationController do
  describe "#render_404" do
    it "should raise a router error" do
      ->{ subject.send(:render_404)}.should raise_error(ActionController::RoutingError)
    end
  end
end
