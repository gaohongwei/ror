1. MongoDB
  scope :internal, -> { where(external: false) }
  scope :external, -> { where(external: true) }
  scope :valid_people, -> { where(:name.ne=>INVALID_Artist_NAME) }

  Artist.where(:name.nin => ['name1', 'name 2'])
  Artist.not_in(name: ['name1', 'name 2'])

2. AR
  Artist.where.not(name: 'name1')
  Foo.includes(:bar).where.not('bars.id' => nil)
  Foo.includes(:bar).where.not(bars: { id: nil })

  Prefix.where('length(speall) > 2').sort
