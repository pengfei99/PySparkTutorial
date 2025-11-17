# Debug Environment for Java, Hadoop, Spark, and PySpark
# Save as debug_env.ps1 and run in PowerShell

Write-Host "=== Debug Script for Java, Hadoop, Spark, PySpark ===`n"

# 1. Java Check
Write-Host "`n"
Write-Host "1. Checking Java installation..."
if (Test-Path $env:JAVA_HOME) {
    Write-Host "JAVA_HOME: $env:JAVA_HOME"
    try {
        $javaVersion = java -version 2>&1
        Write-Host $javaVersion
    } catch {
        Write-Host "Failed to run Hadoop command"
    }
} else {
    Write-Host "Java not found in PATH!"
}
Write-Host "`n"

# 2. Hadoop Check
Write-Host "2. Checking Hadoop installation..."
if (Test-Path $env:HADOOP_HOME) {
    Write-Host "HADOOP_HOME: $env:HADOOP_HOME"
    try {
        $hadoopVersion = & "$env:HADOOP_HOME\bin\hadoop.cmd" version 2>&1
        Write-Host $hadoopVersion
    } catch {
        Write-Host "Failed to run Hadoop command"
    }
} else {
    Write-Host "HADOOP_HOME is not set!"
}
Write-Host "`n"

# 3. Spark Check
Write-Host "3. Checking Spark installation..."
if (Test-Path $env:SPARK_HOME) {
    Write-Host "SPARK_HOME: $env:SPARK_HOME"
    try {
        $sparkSubmitVersion = & "$env:SPARK_HOME\bin\spark-submit.cmd" --version 2>&1
        Write-Host $sparkSubmitVersion
    } catch {
        Write-Host "Failed to run Spark submit"
    }
} else {
    Write-Host "SPARK_HOME is not set!"
}
Write-Host "`n"

# 4. PySpark Check
Write-Host "4. Checking PySpark installation..."
try {
    # Check Python version
    $pythonVersion = python --version 2>&1
    Write-Host "Python: $pythonVersion"

    # Run a minimal PySpark test
    $testScript = @"
from pyspark.sql import SparkSession
spark = SparkSession.builder.appName('DebugTest').getOrCreate()
df = spark.createDataFrame([(1,'a'),(2,'b')], ['id','val'])
df.show()
spark.stop()
"@

    $tempFile = "$env:TEMP\pyspark_test.py"
    $testScript | Out-File -FilePath $tempFile -Encoding UTF8

    python $tempFile
} catch {
    Write-Host "PySpark test failed. Check SPARK_HOME and PYSPARK_PYTHON environment variables."
}

Write-Host "`n=== Debug Complete ==="
