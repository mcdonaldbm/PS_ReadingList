<#
.Synopsis
   Creates a "reading list" file in the specified location
.DESCRIPTION
   Long description
.EXAMPLE
   PS> New-ReadingList -Name "My List" -Path "C:\Temp"
.EXAMPLE
   PS> $params = @("My List", "C:\Temp")
   PS> $params | New-ReadingList
#>
function New-ReadingList
{
    [CmdletBinding()]
    [Alias()]
    Param
    (
        # Name of the new reading list
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $Name,

        # Path for the reading list file
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=1)]
        $Path
    )

    Begin
    {
        $contents = @{
            'Name' = $Name
        }
        if (!(Test-Path $Path)) {
            throw "Invalid path, please enter a valid path and try again"
        }
    }
    Process
    {
        try {
            $readinglist = New-Item -ItemType File -Path $Path -Name $("$Name.json")
            $addtext = $contents | ConvertTo-Json | Out-File -FilePath $("$Path\$Name.json")
        } catch {
            throw "Could not create the Reading List: $Name.  Make sure you have the appropriate permissions to that path and try again."
        }
    }
    End
    {
        Write-Output "Reading List: $Name - Successfully created at: $Path"
    }
}