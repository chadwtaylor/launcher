require 'reward'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# index, amount, subject, summary, limit=nil, tshirt=false, shipable=true

Reward.write 1, "0", "Supporter", "Your support will help make NeverFold a reality. You can contribute any amount on the following page.", nil, false, false
Reward.write 2, "1900", "T-Shirt Backer", "Get your NeverFold conversation-starter t-shirt! Printed on American Apparel.", nil, true, true

Reward.write 3, "2900", "Early Bird Special (Poplar, 36-inch)", "A NeverFold mounting system made of Poplar with 36-inch rods.", 50
Reward.write 4, "3000", "Early Bird Special (Poplar, 48-inch)", "A NeverFold mounting system made of Poplar with 48-inch rods.", 50

Reward.write 5, "3400", "Early Bird Special (Bamboo, 36-inch)", "A NeverFold mounting system made of Bamboo with 36-inch rods.", 50
Reward.write 6, "3500", "Early Bird Special (Bamboo, 48-inch)", "A NeverFold mounting system made of Bamboo with 48-inch rods.", 50

Reward.write 7, "3400", "Poplar Backer (36-inch)", "A NeverFold mounting system made of Poplar with 36-inch rods."
Reward.write 8, "3500", "Poplar Backer (48-inch)", "A NeverFold mounting system made of Poplar with 48-inch rods."

Reward.write 9, "3800", "Bamboo Backer (36-inch)", "A NeverFold mounting system made of Bamboo with 36-inch rods."
Reward.write 10, "3900", "Bamboo Backer (48-inch)", "A NeverFold mounting system made of Bamboo with 48-inch rods."

Reward.write 11, "4900", "T-Shirt + Poplar Backer (36-inch)", "Get a conversation-starter t-shirt along with a NeverFold mounting system made of Poplar with 36-inch rods."
Reward.write 12, "5000", "T-Shirt + Poplar Backer (48-inch)", "Get a conversation-starter t-shirt along with a NeverFold mounting system made of Poplar with 48-inch rods."

Reward.write 13, "5300", "T-Shirt + Bamboo Backer (36-inch)", "Get a conversation-starter t-shirt along with a NeverFold mounting system made of Bamboo with 36-inch rods."
Reward.write 14, "5400", "T-Shirt + Bamboo Backer (48-inch)", "Get a conversation-starter t-shirt along with a NeverFold mounting system made of Bamboo with 48-inch rods."

Reward.write 15, "6000", "Limited Edition (Dark Western Walnut, 48-inch)", "This exotic western walnut with red oak 48-inch rods gives a killer look.", 400
