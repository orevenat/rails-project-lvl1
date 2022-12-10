# frozen_string_literal: true

RSpec.describe HexletCode do
  User = Struct.new(:name, :job, :gender, keyword_init: true)

  it 'has a version number' do
    expect(HexletCode::VERSION).not_to be nil
  end

  it 'empty form_for' do
    user = User.new name: 'rob'
    result = HexletCode.form_for(user) {}
    expected = '<form action="#" method="post"></form>'
    expect(result).to eq(expected)
  end

  it 'empty form_for with url' do
    user = User.new name: 'rob'
    result = HexletCode.form_for(user, url: '/users') {}

    expected = '<form action="/users" method="post"></form>'
    expect(result).to eq(expected)
  end

  it 'form with object and class' do
    user = User.new name: 'rob', gender: 'm'

    result = HexletCode.form_for user, url: '#' do |f|
      f.input :name, class: 'user-input'
      f.input :job
    end

    expected = '<form action="#" method="post"><label for="name">Name</label><input name="name" type="text" value="rob" class="user-input"><label for="job">Job</label><input name="job" type="text" value=""></form>'

    expect(result).to eq(expected)
  end

  it 'form with object' do
    user = User.new name: 'rob', job: 'hexlet', gender: 'm'

    result = HexletCode.form_for user do |f|
      f.input :name
      f.input :job, as: :text
      f.submit 'Wow'
    end

    expected = '<form action="#" method="post"><label for="name">Name</label><input name="name" type="text" value="rob"><label for="job">Job</label><textarea name="job" cols="20" rows="40">hexlet</textarea><input type="submit" value="Wow"></form>'

    expect(result).to eq(expected)
  end

  it 'form with object and overwrite default_options' do
    user = User.new name: 'rob', job: 'hexlet', gender: 'm'

    result = HexletCode.form_for user, url: '#' do |f|
      f.input :job, as: :text, rows: 50, cols: 50
      f.submit
    end

    expected = '<form action="#" method="post"><label for="job">Job</label><textarea cols="50" rows="50" name="job">hexlet</textarea><input type="submit" value="Save"></form>'
  end

  it 'form with object and unexpected field with exception' do
    user = User.new name: 'rob', job: 'hexlet', gender: 'm'

    expect do
      result = HexletCode.form_for user, url: '/users' do |f|
        f.input :name
        f.input :job, as: :text
        # Поля age у пользователя нет
        f.input :age
      end
    end.to raise_exception(NoMethodError)
  end
end
