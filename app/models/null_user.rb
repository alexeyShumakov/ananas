class NullUser < User
  def owner_of?(model)
    false
  end
end
