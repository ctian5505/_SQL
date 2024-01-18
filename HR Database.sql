--- HR Project
  -- Data normalization
  -- Data Cleaning
  -- Adding Constraint

-- Querying

--------------------------------------------------------------
-- Create Database
-- Import the file | File Link:
    -- Raw data is nasa isang table lang which is not a good practice, so that I need to normalize it, and put it to their desinated tables

---------------------* Data Cleaning & Normalization

--  DimGender | Normalization |
        --Transfering the data into DimGender Table
SELECT
  	DISTINCT(GenderID),
  	Sex
INTO
  	DimGender
FROM
  	HRDataset_v14
