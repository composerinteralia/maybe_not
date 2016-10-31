require_relative './maybe/something'
require_relative './maybe/nothing'

def Maybe(value)
  value.nil? ? Maybe::Nothing.instance : Maybe::Something.new(value)
end
