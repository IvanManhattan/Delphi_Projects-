unit UnitDish;

interface

type
  TDish = class
    private
      DishName: String;
      DishCategory: String;
      DishPrice: Integer;
    public
      constructor tDish(DishName: String; DishCategory: String; DishPrice: Integer);
      function getDishName(): String;
      function getDishCategory(): String;
      function getDishPrice(): Integer;
      procedure setDishName(const DishName: String);
      procedure setDishCategory(const DishCategory: String);
      procedure setDishPrice(const DishPrice: Integer);
  end;

implementation

  constructor TDish.tDish(DishName: String; DishCategory: String; DishPrice: Integer);
  begin
    self.DishName := DishName;
    self.DishCategory := DishCategory;
    self.DishPrice := DishPrice;
  end;

  function TDish.getDishName(): String;
  begin
    result := DishName;
  end;

  function TDish.getDishCategory(): String;
  begin
    result := DishCategory;
  end;

  function TDish.getDishPrice(): Integer;
  begin
    result := DishPrice;
  end;

  procedure TDish.setDishName(const DishName: String);
  begin
    self.DishName := DishName;
  end;

  procedure TDish.setDishCategory(const DishCategory: String);
  begin
    self.DishCategory := DishCategory;
  end;

  procedure TDish.setDishPrice(const DishPrice: Integer);
  begin
    self.DishPrice := DishPrice;
  end;


end.
