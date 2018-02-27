class ChangeReferenceInOffersFromUsersToRequests < ActiveRecord::Migration[5.1]
  def change
    remove_reference :offers, :user
    add_reference :offers, :request, foreign_key: true
  end
end
