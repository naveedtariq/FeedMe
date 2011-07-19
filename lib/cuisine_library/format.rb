module CuisineLibrary
  module Format
    # 66669
    # 66669-1234
    ZIP_CODE = /^(\d{5}|\d{5}-\d{4})$/

    URL = /^https?:\/\/\S+$/
    
    EMAIL  = /(\A(\s*)\Z)|(\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z)/i
  end
end