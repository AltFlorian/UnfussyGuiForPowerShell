[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void] [Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

function Show-UnfussyMessageBox () {
    <#
    .SYNOPSIS
    Displays a simple messagebox.

    .DESCRIPTION
    Displays a simple messagebox.

    .PARAMETER Title
    Title of the messagebox.

    .PARAMETER Message
    Message of the messagebox.

    .Example
    Show-UnfussyMessageBox -title "Cats" -message "I am a cat."
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [string] $title,
        [Parameter(Mandatory=$true, Position=1)]
        [string] $message
    )
    [System.Windows.Forms.MessageBox]::Show($message, $title,0)
}

function Confirm-UnfussyDialog () {
    <#
    .SYNOPSIS
    Displays a simple yes or no dialog.

    .DESCRIPTION
    Displays a simple messagebox with the option to klick yes or no.
    This returns a String (YES, NO).

    .PARAMETER Title
    Title of the messagebox.

    .PARAMETER Message
    Message of the messagebox.

    .Example
    Confirm-UnfussyDialog -title "Cats" -message "Are you a cat?"
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [string] $title,
        [Parameter(Mandatory=$true, Position=1)]
        [string] $message
    )

    $input = [System.Windows.Forms.MessageBox]::Show($message, $title,4)
    return $input
}

function Read-UnfussyInputBox () {
    <#
    .SYNOPSIS
    Displays a simple inputbox.

    .DESCRIPTION
    Displays a simple inputbox and returns the input as a string.

    .PARAMETER Title
    Title of the inputbox.

    .PARAMETER Message
    Message of the inputbox.

    .Example
    Read-UnfussyInputBox -title "Cats or dogs" -message "What is your favourite animal?"
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [string] $title,
        [Parameter(Mandatory=$true, Position=1)]
        [string] $message
    )

    $input = [Microsoft.VisualBasic.Interaction]::InputBox($message, $title)
    return $input
}

function Invoke-UnfussyFilePicker () {
    <#
    .SYNOPSIS
    Displays FileDialog to select a file.

    .DESCRIPTION
    Displays FileDialog to select a file and returns the path as a string.

    .PARAMETER initialDirectory,
    Directory Path to open the FileDialog.

    .PARAMETER filterFileType
    Filter by filetype.

    .Example
    Invoke-UnfussyFilePicker -initialDirectory "C:\temp" -filterFileType "Documents (*.docx)|*.docx|SpreadSheet (*.xlsx)|*.xlsx"
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false, Position=0)]
        [string] $initialDirectory = "%USERPROFILE%",
        [Parameter(Mandatory=$false, Position=1)]
        [string] $filterFileType = "All files (*.*)|*.*"
    )

    $filePicker = New-Object System.Windows.Forms.OpenFileDialog -Property @{ 
        InitialDirectory = $initialDirectory
        Filter = $filterFileType
    }
    $null = $filePicker.ShowDialog()
    return $filePicker.FileName
}

function Invoke-UnfussyFolderPicker () {
    <#
    .SYNOPSIS
    Displays FolderDialog to select a file.

    .DESCRIPTION
    Displays FolderDialog to select a folder and returns the path as a string.

    .Example
    Invoke-UnfussyFolderPicker
    #>

    $folderPicker = New-Object System.Windows.Forms.FolderBrowserDialog
    $null = $folderPicker.ShowDialog()
    return $folderPicker.SelectedPath
}
#* To Do's:
# todo date/time picker, pw input (hidden), dropdown, large textbox
# todo better looking ui

Export-ModuleMember -Function Show-UnfussyMessageBox,Confirm-UnfussyDialog,Read-UnfussyInputBox,Invoke-UnfussyFilePicker,Invoke-UnfussyFolderPicker