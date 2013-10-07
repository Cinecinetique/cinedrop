module Fixtures
  def load_fixture(fixture_class)
  	ActiveRecord::FixtureSet.create_fixtures("test/fixtures", fixture_class)
  end
end
