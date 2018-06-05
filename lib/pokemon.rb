class Pokemon
  attr_accessor :id, :name, :type, :hp, :db

  def initialize(id:, name:, type:, hp: 60, db:)
    @id = id
    @name = name
    @type = type
    @hp = hp
    @db = db
  end

  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
  end

  def self.find(id_input, db)
    pokemon_info = db.execute("SELECT * FROM pokemon WHERE id=?", id_input).flatten
    Pokemon.new(id: pokemon_info[0], name: pokemon_info[1], type: pokemon_info[2], hp: pokemon_info[3], db: db)
  end

  def alter_hp(new_hp, db)
    db.execute("UPDATE pokemon SET hp = ? WHERE id = ?", new_hp, self.id)
  end

  pikachu = Pokemon.(name => 'Pikachu', type =>'electric', @db)
  pikachu.save

  magikarp = Pokemon.new(name => 'Magikarp', 'water', @db)
  magikarp.save

  pikachu.alter_hp(59, @db)
  magikarp.alter_hp(0, @db)

end
