[uint64]$count = Read-Host -Prompt "Find primes up to"

function optimisedSearch {
    param ([int]$x)
    $i = 5
    while ($i * $i -le $x) {
        if ($x % $i -eq 0 -or $x % ($i + 2) -eq 0) {
            return $false
        }
        $i += 6
    }

    return $true
}

function isPrime {
    param ([int]$x)
    return ($x -gt 1 -and $x -le 3) -or ($x % 2 -ne 0 -and $x % 3 -ne 0 -and (optimisedSearch($x) -eq $true))
}

for ($i = 1; $i -lt $count; $i++) {
    if (isPrime($i)) {
        Write-Host $i
    }
}