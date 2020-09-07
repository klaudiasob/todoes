# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def create?
    true
  end

  def update?
    user == record
  end

  def me?
    user == record
  end

  def delete?
    user == record
  end
end
