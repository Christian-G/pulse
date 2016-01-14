module AuthenticationSpecHelper
  def authenticate_as_nren(nren)
    visit nrens_path(tal_id: nren.users.first.tal_id, dont_raise: 1)
  end

  def authenticate(user)
    visit nrens_path(tal_id: user.tal_id, dont_raise: 1)
  end

  def unauthenticate
    visit logout_nrens_path(dont_raise: 1)
  end

  def panel_user
    User.where(tal_id: 1, roles: [User::PANEL], email: "test@example.com").first_or_create!
  end

  def admin_user
    User.where(tal_id: 2, roles: [User::ADMIN], email: "test@example.com").first_or_create!
  end
end
