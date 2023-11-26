module Service
  extend ActiveSupport::Concern
  include ActiveModel::Validations

  module ClassMethods
    # The perform method of a UseCase should always return itself
    def call(*args)
      new(*args).tap { |use_case| use_case.call }
    end
  end

  # implement all the steps required to complete this use case
  def call
    raise NotImplementedError
  end

  # inside of perform, add errors if the use case did not succeed
  def success?
    errors.none?
  end

  def result
    #return whatever needs to be returned
  end
end


User::Create.call