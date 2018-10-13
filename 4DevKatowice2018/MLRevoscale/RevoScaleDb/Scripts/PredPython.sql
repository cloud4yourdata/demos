USE RevoScaleDb;
DECLARE @model VARBINARY(MAX);
DECLARE @sqlscript_testdata NVARCHAR(MAX);
DECLARE @Predictions TABLE
(
 Id INT,
 PredictedValue VARCHAR(100)
);
SET @sqlscript_testdata = N'SELECT * FROM dbo.WineTest';

SELECT @model = model
FROM dbo.Models
WHERE ModelName = 'LinReg'
	AND ModelLanguage = 'Python';

INSERT INTO @Predictions(Id,PredictedValue)
EXEC sp_execute_external_script
				@language = N'Python',
				@script = N'
import pickle
import pandas as pd
svn_model = pickle.loads(py_model)
# variable we will be predicting on.
columns = wines.columns.drop(["Id", "WineId","Color"])
target ="Quality"
df = wines
prediction_result = svn_model.predict(df[columns])
predictions_df = pd.DataFrame(prediction_result)
OutputDataSet = pd.concat([ df["Id"],predictions_df], axis=1)
'
, @input_data_1 = @sqlscript_testdata 
, @input_data_1_name = N'wines'
, @params = N'@py_model varbinary(max)'
, @py_model = @model
--with result sets ((Id INT,"Predicted" VARCHAR(100)))
;
SELECT w.Quality,PredictedValue FROM @Predictions AS p
JOIN dbo.WineTest AS w ON w.Id = p.Id
AND w.Quality<>p.PredictedValue

--WHERE ids.Species <> p.PredictedValue