# frozen_string_literal: true

RSpec.describe HexletCode do
  User = Struct.new(:name, :job, :gender, keyword_init: true)

  it 'has a version number' do
    expect(HexletCode::VERSION).not_to be nil
  end

  it 'empty form_for' do
    user = User.new name: 'rob'
    result = HexletCode.form_for(user) {}
    expected = load_fixture('empty_form.txt')
    expect(result).to eq(expected)
  end

  it 'empty form_for with url' do
    user = User.new name: 'rob'
    result = HexletCode.form_for(user, url: '/users') {}

    expected = load_fixture('empty_form_with_url.txt')
    expect(result).to eq(expected)
  end

  it 'form with object' do
    user = User.new name: 'rob', gender: 'm'
    result = HexletCode.form_for user, url: '#' do |f|
      f.input :name, class: 'user-input'
      f.input :job
    end

    expected = load_fixture('form_with_object.txt')
    expect(result).to eq(expected)
  end

  it 'form with object with submit' do
    user = User.new name: 'rob', job: 'hexlet', gender: 'm'
    result = HexletCode.form_for user do |f|
      f.input :name
      f.input :job, as: :text
      f.submit 'Wow'
    end

    expected = load_fixture('form_with_object_and_submit.txt')
    expect(result).to eq(expected)
  end

  it 'form with object and overwrite default_options' do
    user = User.new name: 'rob', job: 'hexlet', gender: 'm'
    result = HexletCode.form_for user, url: '#' do |f|
      f.input :job, as: :text, rows: 50, cols: 50
      f.submit
    end

    expected = load_fixture('form_with_object_and_overwrite_default_options.txt')
    expect(result).to eq(expected)
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
