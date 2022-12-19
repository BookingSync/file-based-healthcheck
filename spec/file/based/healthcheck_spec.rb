# frozen_string_literal: true

RSpec.describe File::Based::Healthcheck do
  it "has a version number" do
    expect(File::Based::Healthcheck::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
