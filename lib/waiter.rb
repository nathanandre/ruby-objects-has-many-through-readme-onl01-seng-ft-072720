class Waiter
    attr_accessor :name, :yrs_experience
 
    @@all = []
   
    def initialize(name, yrs_experience)
      @name = name
      @yrs_experience = yrs_experience
      @@all << self
    end
   
    def self.all
      @@all
    end

    def new_meal(customer, total, tip=0)
        Meal.new(self, customer, total, tip)
    end

    def meals
        Meal.all.select do |meal|
          meal.waiter == self #checking for waiter now
        end
    end

    def best_tipper
        best_tipped_meal = meals.max do |meal_a, meal_b|
          meal_a.tip <=> meal_b.tip
        end
       
        best_tipped_meal.customer
    end

    def worst_tipper
        worst_tipped_meal = meals.min do |meal_a, meal_b|
            meal_a.tip <=> meal_b.tip
        end
           
        worst_tipped_meal.customer
    end

    def self.senior_waiter
        senior_waiter = self.all.max do |waiter_a, waiter_b|
            waiter_a.yrs_experience <=> waiter_b.yrs_experience
        end
    end

    def self.junior_waiter
        junior_waiter = self.all.min do |waiter_a, waiter_b|
            waiter_a.yrs_experience <=> waiter_b.yrs_experience
        end
    end

    def average_tip
        total_tips = 0
        self.meals.each{ |meal| total_tips += meal.tip}
        average_tip = total_tips / self.meals.count
    end

end