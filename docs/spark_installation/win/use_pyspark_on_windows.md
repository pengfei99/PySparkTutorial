# Use pyspark on windows

In this tutorial, we will learn how to use pyspark in windows.

## 1. Setup python en

## 5. Trouble shoot

### 5.1 java.io.IOException: Cannot run program "python3"

This error is caused by the way of how python and pyspark are installed in the OS. And how the env var is configured. 

Two possible solutions:
1. Set up an env var **PYSPARK_PYTHON** = python or the python executable path (works for linux, window, MacOS)
2. Before you create your spark session, add below instructions

```python
import os
import sys
from pyspark.sql import SparkSession

os.environ['PYSPARK_PYTHON'] = sys.executable
os.environ['PYSPARK_DRIVER_PYTHON'] = sys.executable
spark = SparkSession.builder.getOrCreate()
```