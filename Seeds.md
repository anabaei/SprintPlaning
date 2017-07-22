





categories = ['Books', 'Techology', 'Computers', 'Movies', 'TV', 'Fashion', 'Music']

categories.each do |category|
  #puts "#{category} products created!"
  Category.create(name: category)

end
