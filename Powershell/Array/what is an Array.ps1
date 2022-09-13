<#1. What is an Array ?
More Info: https://poshland.pro/array-and-hashtable-explain/
An array is a list or collection of values or objects.#>

$array = @(1,2,3,5,7,11)

<#2. How will you access an Array?

Once you have your items into an array, you can either use foreach to iterate over the list or use an index to access individual elements in the array.#>

foreach($item in $array)
{
    Write-Output $item
}

Write-Output $array[3]

<# 3.How will you update an Array values?

You can also update values using an index in the same way.#>

$array[2] = 13

foreach($item in $array)
{
    Write-Output $item
}




#Example

$box = @() # Empty array
$box = "Document number 2","Document number 4","Document number 3","Document number 1"
$box

$box | Sort-Object
$box | Sort-Object -Descending

$box = $box + "Document number 6" # one of the method to add new element in array
$box
$box += "Document number 5" # one of the method to add new element in array
$box

$box[1]
$box | Where-Object {$_ -eq "Document number 3"}
