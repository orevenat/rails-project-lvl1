# frozen_string_literal: true

RSpec.describe HexletCode do
  it 'has a version number' do
    expect(HexletCode::VERSION).not_to be nil
  end

  # rubocop:disable Lint/EmptyBlock
  it 'empty form_for' do
    User = Struct.new(:name, :job, keyword_init: true)
    user = User.new name: 'rob'
    result = HexletCode.form_for user do |f|
    end

    expected = '<form action="#" method="post">
    </form>'
    expect(result).to eq(expected)
  end
  # rubocop:enable Lint/EmptyBlock
end
