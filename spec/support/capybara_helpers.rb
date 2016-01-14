module CapybaraHelpers

  def eventually
    satisfied = false
    original_error = nil
    [0.1, 0.1, 0.2, 0.2, 0.5, 0.9].each do |interval|
      begin
        yield
        satisfied = true
      rescue => error
        original_error = error
        satisfied = false
      end
      return if satisfied
      sleep interval
    end

    raise original_error unless satisfied
  end

end