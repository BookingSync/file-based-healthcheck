# frozen_string_literal: true

RSpec.describe FileBasedHealthcheck do
  it "has a version number" do
    expect(FileBasedHealthcheck::VERSION).not_to be nil
  end

  describe "#touch" do
    subject(:touch) { file_based_healthcheck.touch }

    let(:file_based_healthcheck) do
      described_class.new(directory: directory, filename: filename, time_threshold: time_threshold)
    end
    let(:directory) { Dir.mktmpdir }
    let(:filename) { "healthcheck" }
    let(:time_threshold) { 1 }

    after do
      file_based_healthcheck.remove
    end

    it "creates a file" do
      expect {
        touch
      }.to change { File.exist?(File.join(directory, filename)) }.from(false).to(true)
    end
  end

  describe "#running?" do
    subject(:running?) { file_based_healthcheck.running? }

    let(:file_based_healthcheck) do
      described_class.new(directory: directory, filename: filename, time_threshold: time_threshold)
    end
    let(:directory) { Dir.mktmpdir }
    let(:filename) { "healthcheck" }
    let(:time_threshold) { 1 }

    after do
      file_based_healthcheck.remove
    end

    context "when the file exists" do
      before do
        file_based_healthcheck.touch
      end

      context "when the threshold has been exceeded" do
        let(:time_threshold) { 0.1 }

        before do
          sleep 0.2
        end

        it { is_expected.to eq false }
      end

      context "when the threshold has not been exceeded" do
        it { is_expected.to eq true }
      end
    end

    context "when the file does not exist" do
      it { is_expected.to eq false }
    end
  end

  describe "#remove" do
    subject(:remove) { file_based_healthcheck.touch }

    let(:file_based_healthcheck) do
      described_class.new(directory: directory, filename: filename, time_threshold: time_threshold)
    end
    let(:directory) { Dir.mktmpdir }
    let(:filename) { "healthcheck" }
    let(:time_threshold) { 1 }

    context "when the file exists" do
      before do
        file_based_healthcheck.remove
      end

      it "deletes a file" do
        expect {
          remove
        }.to change { File.exist?(File.join(directory, filename)) }.from(false).to(true)
      end
    end

    context "when the file does not exist" do
      it "does not do anything" do
        expect {
          remove
        }.not_to raise_error
      end
    end
  end
end
