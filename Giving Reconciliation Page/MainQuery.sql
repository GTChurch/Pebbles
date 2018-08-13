SELECT
  fb.Id [Id],
  fb.BatchStartDateTime [Date],
  CONCAT(fb.Name, CHAR(10), CHAR(13), '   ($', fb.ControlAmount, ')') [Batch Name & Control Amnt],
  COUNT(ftd.Amount) [Transactions],
  fa.GlCode [GL Code],
  fa.Name [Account Name],
  SUM(ftd.Amount) [Amount]
FROM [FinancialTransaction] ft
  JOIN [FinancialTransactionDetail] ftd
    ON ftd.TransactionId = ft.Id
  JOIN [FinancialBatch] fb
    ON ft.BatchId = fb.Id
  JOIN [FinancialAccount] fa
    ON ftd.AccountId = fa.Id
  JOIN [FinancialPaymentDetail] fpd
    ON ft.FinancialPaymentDetailId = fpd.Id
WHERE fb.BatchStartDateTime >= @StartDate
AND fb.BatchStartDateTime <= @EndDate
AND fpd.CurrencyTypeValueId IN (SELECT item FROM dbo.spListToTable (@CurrencyType, ','))
AND ft.SourceTypeValueId IN (SELECT item FROM dbo.spListToTable (@TransactionType, ','))
GROUP BY fb.Id, fb.Name, fa.Name, fb.BatchStartDateTime, fb.ControlAmount, fa.GlCode
ORDER BY fb.BatchStartDateTime ASC, fa.Name ASC;
