function Wait-For-Port {
    param(
        [string]$host,
        [int]$port,
        [int]$timeout = 10
    )

    $start_time = Get-Date
    $elapsed_time = 0

    while ((Test-NetConnection -ComputerName $host -Port $port -InformationLevel Quiet) -eq $false) {
        Start-Sleep -Seconds 1
        $current_time = Get-Date
        $elapsed_time = ($current_time - $start_time).TotalSeconds

        Write-Host "Trying to connect to pg via $host:$port"

        if ($elapsed_time -ge $timeout) {
            Write-Host "Unable to connect to pg"
            exit 1
        }
    }
}

Wait-For-Port -host "postgres" -port 5432

python manage.py runserver 0.0.0.0:8000
