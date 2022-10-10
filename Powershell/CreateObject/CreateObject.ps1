# 4 ways to create object

# reference: https://www.youtube.com/watch?v=zfcjrJMr9XM

# Method 1: Create hashtable with type cast [PsCustomObject]

#[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments')]
$var1 = [PSCustomObject]@{

    FirstName = 'Tom'
    LastName = 'Hanks'

}

$var1