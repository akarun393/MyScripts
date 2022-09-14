# https://powershellexplained.com/2016-11-06-powershell-hashtable-everything-you-wanted-to-know-about/
<#

1. What is a hashtable?

A hashtable is a data structure much like an array, except you store each value (object) using a key.

It is a basic key/value store.

#>

# Create an empty hash table

$AgeList = @{}

# 2. How to add an item to HashTable

$Key = 'Kelvin'
$Value = 36

$AgeList.Add($Key, $Value)

$AgeList.Add('Alex', 9)

<#2. How to access HashTable

Using brackets for accesss []

Once you add your values to the hashtable, you can pull them back out using that same key (instead of using a numeric index like you would have for an array).#>

$AgeList['Kelvin']
$AgeList['Alex']

# 3. Alternate option to add or update values

$Key = 'Rob'
$Value = 50

$AgeList[$Key] = $Value
$AgeList['Rob']

$AgeList['Maverick'] = 55

$AgeList['Maverick']

# 4. How to pre-populate keys and values without using empty hashtable?

$ageList = @{
    Sam = 36
   Mike  = 9
}

# 5. How to use hashtable as a lookup table?

$environments = @{
    Prod = 'SrvProd05'
    QA   = 'SrvQA02'
    Dev  = 'SrvDev12'
}

$server = $environments[$env]

<#In this example, you specify an environment for the $env variable and it will pick the correct server. 
You could use a switch($env){...} for something like this but this is a nice option.#>

# 6. Multiselection object/items from hashtable?

<#Generally, you think of a hashtable as a key/value pair where you provide one key and get one value. 
PowerShell allows you to provide an array of keys to get multiple values.
In this example I use the same lookup hashtable from above and provide 3 different array styles to get the matches. #>

$environments[@('QA','DEV')] # array style 1
$environments[('QA','DEV')]  # array style 2
$environments['QA','DEV']    # array style 3


# 7. Iterating hashtables

<# Because a hashtable is a collection of key/value pairs, 
you have to iterate over it differently than you would an array or a normal list of items. #>

# i.) The first thing to notice is that if you pipe your hashtable, the pipe treats it like one object.

$ageList | Measure-Object

# Even though the .count property tells you how many values it contains.

$ageList.Count

# You get around this issue by using the .values property if all you need is just the values.

$ageList.values | Measure-Object -Average

# 7.1 More useful option is enumerate the keys and use them to access values. To achieve we can use -f operator.

$ageList.keys | ForEach-Object{
    $message = '{0} is {1} years old!' -f $_, $ageList[$_]
    Write-Output $message
}

# 7.2 other method to enumerate

$ageList.keys | ForEach-Object{
        Write-Output "Key = $_"
        Write-Output "Value = $($ageList[$_])"
        Write-Output '----------'
}

# 7.3 other method to enumerate with a foreach(){...} loop.

foreach($key in $ageList.keys)
{
    $message = '{0} is {1} years old' -f $key, $ageList[$key]
    Write-Output $message
}

# 7.4 Using GetEnumerator() method for iterating over our hashtable.

$ageList.GetEnumerator() | ForEach-Object{
    $message = '{0} is {1} years old!' -f $_.key, $_.value
    Write-Output $message
}
