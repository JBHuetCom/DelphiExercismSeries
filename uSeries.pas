unit uSeries;

interface
  type

    TSlice = class
      Constructor Create(AText : string);
      function slices(ALength : integer) : TArray<string>;
    private
      FText : string;
    end;

implementation
  uses
    System.StrUtils, System.SysUtils, System.Generics.Collections;

  Constructor TSlice.Create(AText : string);
    begin
      FText := AText;
    end;

  function TSlice.slices(ALength : integer) : TArray<string>;
    var
      SliceList : TArray<string>;
    begin
      if (1 > length(FText)) then
        raise EArgumentException.Create('series cannot be empty');

      if (0 > ALength) then
        raise EArgumentOutOfRangeException.Create('slice length cannot be negative');

      if (0 = ALength) then
        raise EArgumentOutOfRangeException.Create('slice length cannot be zero');

      if (ALength > length(FText)) then
        raise EArgumentOutOfRangeException.Create('slice length cannot be greater than series length');

      setlength(SliceList, (length(FText) - ALength + 1));
      for var i := 0 to (length(FText) - ALength) do
        begin
          SliceList[i] := LeftStr(FText, ALength);
          FText := RightStr(FText, (length(FText) - 1));
        end;

      Result := SliceList;
    end;

end.
