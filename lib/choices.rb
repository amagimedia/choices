require 'hashie/mash'
require 'erb'
require 'yaml'

module Choices
  extend self

  def load_settings(filename, env)
    mash = Hashie::Mash.new(load_settings_hash(filename))

    with_local_settings(filename, '.local') do |local|
      mash.update local
    end

    if env == "default"
      return mash
    end

    mash.fetch(env) do
      raise IndexError, %{Missing key for "#{env}" in `#{filename}'}
    end
  end

  def load_settings_from_files(filenames, env)
    mash = Hashie::Mash.new()

    # always load default settings first
    mash.update(load_settings(filenames.shift, env))

    # override default settings with patch settings, if they exist
    filenames.each do |file_name|
      if File.exist? file_name
        begin
          mash.update(load_settings(file_name, env))
        rescue IndexError => ex
          puts("#{env} configs does not exist in the patch file; falling back to default configs.")
        end
      else
        puts("Skipping file #{file_name}, file not found")
      end
    end
    mash
  end

  def load_settings_hash(filename)
    yaml_content = ERB.new(IO.read(filename)).result
    yaml_load(yaml_content)
  end

  def with_local_settings(filename, suffix)
    local_filename = filename.sub(/(\.\w+)?$/, "#{suffix}\\1")
    if File.exist? local_filename
      hash = load_settings_hash(local_filename)
      yield hash if hash
    end
  end

  def yaml_load(content)
    if defined?(YAML::ENGINE) && defined?(Syck)
      # avoid using broken Psych in 1.9.2
      old_yamler = YAML::ENGINE.yamler
      YAML::ENGINE.yamler = 'syck'
    end
    begin
      YAML::load(content)
    ensure
      YAML::ENGINE.yamler = old_yamler if defined?(YAML::ENGINE) && defined?(Syck)
    end
  end
end

if defined? Rails
  require 'choices/rails'
end
