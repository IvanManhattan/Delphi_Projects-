unit Objects;

interface

type Person = Class
  private
    name: String;
    id: Integer;

  published
    constructor createPerson(name: String; id: Integer); overload;
    function getName: String;
    function getId: Integer;
    procedure setName(name: String);
    procedure setId(id: Integer);
End;



implementation


  constructor Person.createPerson(name: string; id: Integer);
  begin
    self.name := name;
    self.id := id;
  end;


  function Person.getName: String;
  begin
    result := name;
  end;

  function Person.getId: Integer;
  begin
    result := id;
  end;

  procedure Person.setName(name: String);
  begin
    self.name := name;
  end;

  procedure Person.setId(id: Integer);
  begin
    self.id := id;
  end;

end.
