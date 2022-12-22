require "ffi"

module External
  extend FFI::Library

  ffi_lib "./external.so"
  attach_function :foo, [:int, :int], :int
  attach_function :read, [], :pointer
end

# puts External.foo(1, 2)
puts External.read.read_string
