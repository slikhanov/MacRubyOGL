# sizeof calculation for various types
def sizeof(type)
  size_ptr = Pointer.new("Q")
  align_ptr = Pointer.new("Q")
  NSGetSizeAndAlignment(type, size_ptr, align_ptr)
  size_ptr.value
end
