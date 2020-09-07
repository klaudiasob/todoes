# frozen_string_literal: true

class TodoPolicy < ApplicationPolicy
  def create?
    true
  end

  def update?
    user == record.user
  end

  def index?
    true
  end

  def delete?
    user == record.user
  end
end
