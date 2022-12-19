require "file_based_healthcheck/version"
require "fileutils"
require "active_support/core_ext/time"

class FileBasedHealthcheck
  attr_reader :directory, :filename, :time_threshold
  private     :directory, :filename, :time_threshold

  def initialize(directory:, filename:, time_threshold:)
    @directory = directory
    @filename = filename
    @time_threshold = time_threshold
  end

  def touch
    FileUtils.touch(file_path)
  end

  def running?
    return false if !File.exists?(file_path)

    File.mtime(file_path).advance(seconds: time_threshold).utc > Time.now.utc
  end

  def remove
    File.delete(file_path) if File.exists?(file_path)
  end

  private

  def file_path
    File.join(directory, filename)
  end
end
