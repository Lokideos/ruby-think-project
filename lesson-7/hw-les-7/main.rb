require_relative 'manufacturable'
require_relative 'instance_counter'
require_relative 'validable'
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'car'
require_relative 'cargo_car'
require_relative 'passenger_car'
require_relative 'tests'
require_relative 'ui'
require_relative 'application'

#test1 = Tests.new
#test1.run
program_ui = UI.new
program_ui.main_msg

program = Application.new
program.run
