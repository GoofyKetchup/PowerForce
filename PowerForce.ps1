# Cleader terminal then load essential variable

Clear-Host

Write-Host "Loading essential variable..." -ForegroundColor Yellow

# Creating list of 7z commands to execute

$arguments = @(
    "x"
    "`"$target`""
    "-o`"$dest`""
    "-p$password"
    "-y"
)

# Main loop and instructions
while($true) {

    Clear-Host

    # Getting information on the target and getting wordlist path to the brute forcer
    Write-Host "--- PowerForce --- ZIP Bruteforcer by Wordlist" -ForegroundColor Cyan
    Write-Host "Enter the target absolute path :" -ForegroundColor Blue
    $target = Read-Host
    Write-Host "Enter the wordlist absolute path :" -ForegroundColor Blue
    $wordlist = Read-Host
    Write-Host "Enter 7z absolute path :" -ForegroundColor Blue
    $sevenZip = Read-Host
    Write-Host "Enter the destination of extracted file and directory :" -ForegroundColor Blue
    $dest = Read-Host
    

    # Verification...

    # Checking if ZIP exist

    Write-Host "Checking if target exist" -ForegroundColor Yellow

    if (Test-Path $target) {
        Write-Host "Target Exist!" -ForegroundColor Green
    } else {
        Write-Host "Target do not exist." -ForegroundColor Red
        continue
    }

    # Checking if target is zipped

    Write-Host "Checking if Target is Zipped..." -ForegroundColor Yellow

    if (Test-ZipFile$target) {
        Write-Host "Target is Zipped !" -ForegroundColor Green
    } else {
        Write-Host "Target is not Zipped." -Foreground Red
        continue
    }

    # Checking if wordlist exist

    Write-Host "Checking if Wordlist exist..." -ForegroundColor Yellow

    if (Test-Path $wordlist) {
        Write-Host "Wordlist exist!" -Foreground Green
    } else {
        Write-Host "Wordlist do not exists." -Foreground Red
        continue
    }

    # Checking if Seven Zip Terminal Exist

    Write-Host "Checking if 7z exist" -ForegroundColor Yellow

    if (Test-Path $sevenZip) {
        Write-Host "7z exist !" -ForegroundColor Green
    } else {
        Write-Host "7z do not exists." -ForegroundColor Red
        continue
    }

    # Checking if destination exist

    Write-Host "Checking if Destination exists..." -ForegroundColor Yellow

    if (Test-Path $dest) {
        Write-Host "Destination exist !" -ForegroundColor Green
    } else {
        Write-Host "Destination do not exists." -ForegroundColor Red
        continue
    }

    # Get content of wordlist and read it line by line

    Write-Host "Launching the brute force attack using wordlist..." -ForegroundColor Yellow 

    Get-Content $wordlist | ForEach-Object {
        $password = $_
        Write-Host "Current password : $password" -ForegroundColor Yellow

        # Entering 7z commands to test the current word

        $process = Start-Process -FilePath $sevenZip -ArgumentList $arguments -NoNewWindow -Wait -PassThru

        if ($process.ExitCodec -eq 0) {
            Write-Host "Password founded : $password" -ForegroundColor Green
        } else {
            continue
        }
    }
    # Final instructions
    Read-Host "Press any Key to restart. Press CTRL + C to exit"
    [System.Console]::ReadKey($true) > $null
    Clear-Host
}