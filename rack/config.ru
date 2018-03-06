require_relative "middleware/check_route"
require_relative 'app'
use CheckRoute
run App.new
