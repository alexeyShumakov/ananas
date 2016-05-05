class ApplicationSerializer < ActiveModel::Serializer

  def scope
    super ? super : NullUser.new
  end
end
