require 'yaml'
#require 'pry'

class MedocError < Exception

  def initialize(message = 'Unknown MedocError')
    super message
    @embedded_message = message
  end

  def embedded_message
    @embedded_message
  end

  def embedded_message=(value)
    @embedded_message = value
  end
end

class Medoc

  CONFIG_FILE = File.expand_path '~/.medoc.yml'
  @@config = nil

  def self.version
    '0.0.0'
  end

  def self.append(path, dir)
    if path.size > 0 && path[path.size - 1] != '/'
      "#{path}/#{dir}"
    else
      "#{path}#{dir}"
    end
  end

  def self.init
    if !File.exists CONFIG_FILE
      f = File.new CONFIG_FILE, "w"
      f.puts ""
    else
      raise MedocError.new "Error: config file is already existing"
    end
  end

  def self.run(keyword)
    if !Medoc.load_config
      raise MedocError.new 'Error: no config file found. You should run medoc --init.'
    end

    if @@config.has_key? keyword
      instructions = @@config[keyword]
      target = ''
      if instructions.kind_of? Array
        instructions.each do |e|
          if @@config.has_key?(e) && e != keyword
            target = append target, Medoc.run(e)
          else
            target = append target, e
          end
        end
      else
        target = instructions
      end

      return target
    else
      raise MedocError.new "Error: No entry for '#{keyword}' in config file"
    end
  end

  private

    def self.load_config
      if !@@config.nil?
        return true
      end

      if !File.exists? CONFIG_FILE
        return false
      end

      @@config = YAML.load_file CONFIG_FILE
      true
    end
end