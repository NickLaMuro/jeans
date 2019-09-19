$LOAD_PATH.unshift File.expand_path(File.join("..", ".."), __FILE__)
load "jeans" # need to "load" since it isn't a `.rb` file

require "minitest/autorun"

class TestFixture
  def self.[] key
    data[key]
  end

  def self.data
    @data ||= begin
                test_dir = File.dirname(__FILE__)
                Dir[File.join test_dir, "fixtures", "*"].map do |file|
                  [File.basename(file, ".*").to_sym, file]
                end.to_h
              end
  end
end

class Jeans
  # Test helper method that provides a stub set of contacts from an array of
  # arrays or a sample file.
  def with_contacts *contact_list
    if File.exist? contact_list.first
      @db_file_name = contact_list.first
    else
      @db_data = contact_list.map { |contact| Number.new(*contact) }
    end

    yield self
  ensure
    @db_data, @db_file_name = nil
  end
end
