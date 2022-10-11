# 4 ways to create object

# reference: https://www.youtube.com/watch?v=zfcjrJMr9XM

# Method 1: Create hashtable with type cast [PsCustomObject]

#[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments')]
$var1 = [PSCustomObject]@{

    FirstName = 'Tom'
    LastName = 'Hanks'

}

$var1


# Method 2: Create object using "select-object" command using hashtable key value pairs

# -InputObject with empty string '' is required.

Select-Object @{Name='FirstName';Expression={'John'}},@{Name='LasttName';Expression={'Smith'}} -InputObject ''

# Alternative: using empty string '' and pipe select-object

'' | Select-Object @{Name='FirstName';Expression={'John'}},@{Name='LasttName';Expression={'Smith'}}


# Method 3: First instantiate class psobject then use add-member cmdlet to add property to the particular object.

$obj = New-Object -TypeName psobject #--> First instantiate psobject 
$obj | Add-Member -MemberType NoteProperty -Name FirstName -Value 'John'
$obj | Add-Member -MemberType NoteProperty -Name LastName -Value 'Cena'


    # Add-member cmdlet is not limited to properties, we can also add methods to this approach.

$obj | Add-Member -MemberType ScriptMethod -Name "GetName" -Value {$this.FirstName + ' ' + $this.LastName}

$obj
$obj.GetName()

<#
Here is an explanation from the about_Automatic_Variables help topic, for those who haven't read a help:
$_   
       Same as $PSItem. Contains the current object in the pipeline object.
       You can use this variable in commands that perform an action on every
       object or on selected objects in a pipeline.

$PSItem (introduced in PowerShell 3.0)
       Same as $_. Contains the current object in the pipeline object.
       You can use this variable in commands that perform an action on every
       object or on selected objects in a pipeline.

$This
        In a script block that defines a script property or script method, the
        $This variable refers to the object that is being extended.
#>


# Method 4: Using New-Object and HashTables

$Properties = @{
   FirstName = 'Steve'
   LastName = 'Smith'   
}

$Result = New-Object psobject -Property $Properties; $Result