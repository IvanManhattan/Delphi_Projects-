unit UnitDish;

interface

type
  TDish = class
    private
      dishName: String;
      dishCategory: String;
      dishPrice: Integer;
    public
      constructor CreateDish(const dishName: String; const dishCtegory: String; const dishPrice: Integer);
      function getDishName(): String;
      function getDishCategory(): String;
      function getDishPrice(): Integer;
      procedure setDishName(const dishName: String);
      procedure setDishCategory(const dishCategory: String);
      procedure setDishPrice(const dishPrice: Integer);
      destructor DestroyDish(dish: TDish);
  end;


implementation

  { TDish }

  constructor TDish.CreateDish(const dishName: string; const dishCtegory: string; const dishPrice: Integer);
  begin
    self.dishName	:= dishName;
    self.dishCategory	:= dishCategory;
    self.dishPrice := dishPrice;
  end;

  function TDish.getDishName(): String;
  begin
    result := dishName;
  end;

  function TDish.getDishCategory(): String;
  begin
    result := dishCategory;
  end;

  function TDish.getDishPrice: Integer;
  begin
    result := dishPrice;
  end;

  procedure TDish.setDishName(const dishName: String);
  begin
    self.dishName	:= dishName;
  end;

  procedure TDish.setDishCategory(const dishCategory: String);
  begin
    self.dishCategory	:= dishCategory;
  end;

  procedure TDish.setDishPrice(const dishPrice: Integer);
  begin
    self.dishPrice := dishPrice;
  end;

  destructor TDish.DestroyDish(dish: TDish);
  begin
    dish.Free;
  end;

end.
