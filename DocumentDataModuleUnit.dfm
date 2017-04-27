object DocumentDataModule: TDocumentDataModule
  OldCreateOrder = False
  Left = 356
  Top = 127
  Height = 369
  Width = 461
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 32
    Top = 96
  end
  object mergeDataSet: TOraTable
    Left = 136
    Top = 24
  end
  object mergeDataSetProvider: TDataSetProvider
    Constraints = True
    Options = [poReadOnly, poNoReset, poAutoRefresh]
    Left = 32
    Top = 24
  end
  object SaveDialog1: TSaveDialog
    Left = 136
    Top = 104
  end
  object OpenDialog1: TOpenDialog
    Left = 288
    Top = 96
  end
  object getCheckedFilter: TDataSetFilter
    Glue = ' AND '
    Left = 128
    Top = 176
  end
end
