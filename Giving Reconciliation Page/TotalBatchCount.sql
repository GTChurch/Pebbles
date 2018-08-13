SELECT
  COUNT(DISTINCT fb.Id) [Batches]
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
AND ft.SourceTypeValueId IN (SELECT item FROM dbo.spListToTable (@TransactionType, ','));
