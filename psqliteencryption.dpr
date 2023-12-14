program psqliteencryption;

uses
  System.StartUpCopy,
  FMX.Forms,
  umain in 'umain.pas' {frmMain},
  udm in 'udm.pas' {datamod: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tdatamod, datamod);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
