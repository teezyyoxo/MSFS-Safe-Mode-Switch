# msfsSafeModeSwitch for Microsoft Flight Simulator
# Created and released by @teezythakidd
# This script serves the purpose of allowing fellow Flight Simmers to choose whether they want to start MSFS 2020 or MSFS 2024 in Safe Mode or Normal Mode.
# See the README for more info.
# All changes are in CHANGELOG.md.

# Add required assemblies
Add-Type -AssemblyName 'System.Windows.Forms'
Add-Type -AssemblyName 'System.Drawing'

# Define paths for MSFS based on the sim and platform selected
$simConfigurations = @{
    "MSFS 2020" = @{
        "Microsoft Store / Xbox" = "C:\XboxGames\Microsoft Flight Simulator\Content\"
        "Steam"                  = "C:\Program Files (x86)\Steam\steamapps\common\MicrosoftFlightSimulator\"
    }
    "MSFS 2024" = @{
        "Microsoft Store / Xbox" = "C:\XboxGames\Microsoft Flight Simulator 2024\Content\"
        "Steam"                  = "C:\Program Files (x86)\Steam\steamapps\common\Microsoft Flight Simulator 2024\"
    }
}
$gameLaunchHelperExe = "gamelaunchhelper.exe"  # The correct executable for launching MSFS

function Get-SelectedSimName {
    if ($msfs2024Radio.Checked) { return "MSFS 2024" }
    return "MSFS 2020"
}

function Get-SelectedPlatformName {
    if ($steamRadio.Checked) { return "Steam" }
    return "Microsoft Store / Xbox"
}

function Get-SelectedPath {
    $selectedSim = Get-SelectedSimName
    $selectedPlatform = Get-SelectedPlatformName
    return $simConfigurations[$selectedSim][$selectedPlatform]
}

function Get-SelectionDescription {
    $selectedSim = Get-SelectedSimName
    $selectedPlatform = Get-SelectedPlatformName
    return "$selectedSim ($selectedPlatform)"
}

function Center-ControlHorizontally {
    param (
        [System.Windows.Forms.Control]$Control,
        [System.Windows.Forms.Control]$Parent
    )

    $x = [Math]::Max(0, [int](($Parent.ClientSize.Width - $Control.Width) / 2))
    $Control.Location = New-Object System.Drawing.Point($x, $Control.Location.Y)
}

function Center-CheckboxVisually {
    param (
        [System.Windows.Forms.CheckBox]$CheckBox,
        [System.Windows.Forms.Control]$Parent,
        [int]$GlyphCompensation = 9
    )

    $x = [Math]::Max(0, [int](($Parent.ClientSize.Width - $CheckBox.Width) / 2) + $GlyphCompensation)
    $CheckBox.Location = New-Object System.Drawing.Point($x, $CheckBox.Location.Y)
}

function Center-ButtonRow {
    param (
        [System.Windows.Forms.Control[]]$Controls,
        [System.Windows.Forms.Control]$Parent,
        [int]$Spacing
    )

    $totalWidth = 0
    for ($i = 0; $i -lt $Controls.Count; $i++) {
        $totalWidth += $Controls[$i].Width
        if ($i -lt ($Controls.Count - 1)) {
            $totalWidth += $Spacing
        }
    }

    $x = [Math]::Max(0, [int](($Parent.ClientSize.Width - $totalWidth) / 2))
    foreach ($control in $Controls) {
        $control.Location = New-Object System.Drawing.Point($x, $control.Location.Y)
        $x += $control.Width + $Spacing
    }
}

function Invoke-SimModeChange {
    param (
        [bool]$EnableSafeMode
    )

    $selectedPath = Get-SelectedPath
    $selectionDescription = Get-SelectionDescription
    $msfsExePath = Join-Path $selectedPath $gameLaunchHelperExe
    $runningLockPath = Join-Path $selectedPath 'running.lock'

    if (-not (Test-Path $msfsExePath)) {
        [System.Windows.Forms.MessageBox]::Show(
            "Error: The MSFS executable was not found for $selectionDescription.`n`nChecked path:`n$msfsExePath",
            "Error",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Error
        )
        return
    }

    if ($EnableSafeMode) {
        New-Item -Path $runningLockPath -ItemType File -Force | Out-Null
        [System.Windows.Forms.MessageBox]::Show(
            "Safe Mode is activated for $selectionDescription.`n`n`"running.lock`" file created.",
            "Confirmation",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Information
        )
    } else {
        if (Test-Path $runningLockPath) {
            Remove-Item -Path $runningLockPath -Force
            [System.Windows.Forms.MessageBox]::Show(
                "`"running.lock`" file deleted. Normal Mode activated for $selectionDescription.",
                "Confirmation",
                [System.Windows.Forms.MessageBoxButtons]::OK,
                [System.Windows.Forms.MessageBoxIcon]::Information
            )
        } else {
            [System.Windows.Forms.MessageBox]::Show(
                "No `"running.lock`" file found. Normal Mode activated for $selectionDescription.",
                "Confirmation",
                [System.Windows.Forms.MessageBoxButtons]::OK,
                [System.Windows.Forms.MessageBoxIcon]::Information
            )
        }
    }

    if ($autoStartCheckbox.Checked) {
        Start-Process $msfsExePath
    }

    $form.Close()
}

# Create the form (application window)
$form = New-Object System.Windows.Forms.Form
$form.Text = 'msfs-safeModeSwitch'
$form.Size = New-Object System.Drawing.Size(550, 340)  # Increased window size for the extra options

# Set a fixed window size (width x height)
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog  # Makes the window non-resizable
$form.MaximizeBox = $false  # Disables the maximize button
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen  # Centers the form

# Icon for form - DISABLED FOR NOW.
# Set the form's icon (replace 'icon.ico' with the path to your own .ico file)
# $iconPath = "C:\............."  # Provide the full path to the icon file
# $form.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($iconPath)

# Create a label that asks the user the question
$label = New-Object System.Windows.Forms.Label
$label.AutoSize = $true  # Ensures the label resizes to fit the text
$label.Text = 'Choose your sim, platform, and launch mode.'
$label.Location = New-Object System.Drawing.Point(0, 20)
$form.Controls.Add($label)

# Create Safe Mode button
$safeButton = New-Object System.Windows.Forms.Button
$safeButton.Text = 'Safe Mode'
$safeButton.Location = New-Object System.Drawing.Point(0, 50)
$safeButton.Size = New-Object System.Drawing.Size(100, 30)  # Adjusted button size for better fit
$form.Controls.Add($safeButton)

# Create Normal Mode button
$normalButton = New-Object System.Windows.Forms.Button
$normalButton.Text = 'Normal Mode'
$normalButton.Location = New-Object System.Drawing.Point(0, 50)
$normalButton.Size = New-Object System.Drawing.Size(100, 30)  # Adjusted button size for better fit
$form.Controls.Add($normalButton)

# Create Cancel button
$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Text = 'Cancel'
$cancelButton.Location = New-Object System.Drawing.Point(0, 50)
$cancelButton.Size = New-Object System.Drawing.Size(100, 30)  # Adjusted button size for better fit
$form.Controls.Add($cancelButton)

# Group sim selection radio buttons separately from platform selection.
$simGroupBox = New-Object System.Windows.Forms.GroupBox
$simGroupBox.Text = 'Simulator'
$simGroupBox.Location = New-Object System.Drawing.Point(0, 90)
$simGroupBox.Size = New-Object System.Drawing.Size(280, 70)
$form.Controls.Add($simGroupBox)

# Create radio buttons for sim selection
$msfs2020Radio = New-Object System.Windows.Forms.RadioButton
$msfs2020Radio.Text = 'MSFS 2020'
$msfs2020Radio.Checked = $true
$msfs2020Radio.Location = New-Object System.Drawing.Point(15, 30)
$msfs2020Radio.Size = New-Object System.Drawing.Size(120, 30)
$simGroupBox.Controls.Add($msfs2020Radio)
# ---
$msfs2024Radio = New-Object System.Windows.Forms.RadioButton
$msfs2024Radio.Text = 'MSFS 2024'
$msfs2024Radio.Location = New-Object System.Drawing.Point(145, 30)
$msfs2024Radio.Size = New-Object System.Drawing.Size(120, 30)
$simGroupBox.Controls.Add($msfs2024Radio)

# Create a separate group for platform selection.
$platformGroupBox = New-Object System.Windows.Forms.GroupBox
$platformGroupBox.Text = 'Platform'
$platformGroupBox.Location = New-Object System.Drawing.Point(0, 165)
$platformGroupBox.Size = New-Object System.Drawing.Size(280, 85)
$form.Controls.Add($platformGroupBox)

# Create radio buttons for platform selection
$storeRadio = New-Object System.Windows.Forms.RadioButton
$storeRadio.Text = 'Microsoft Store / Xbox'
$storeRadio.Checked = $true
$storeRadio.Location = New-Object System.Drawing.Point(15, 25)
$storeRadio.Size = New-Object System.Drawing.Size(180,30)
$platformGroupBox.Controls.Add($storeRadio)
# ---
$steamRadio = New-Object System.Windows.Forms.RadioButton
$steamRadio.Text = 'Steam'
$steamRadio.Location = New-Object System.Drawing.Point(15, 50)
$steamRadio.Size = New-Object System.Drawing.Size(120,30)
$platformGroupBox.Controls.Add($steamRadio)

# Create a checkbox for auto-starting MSFS
$autoStartCheckbox = New-Object System.Windows.Forms.CheckBox
$autoStartCheckbox.AutoSize = $true
$autoStartCheckbox.Text = 'Check the box to auto-start the selected sim after making your selection.'
$autoStartCheckbox.Location = New-Object System.Drawing.Point(0, 255)
$form.Controls.Add($autoStartCheckbox)

# Event handler for Safe Mode button
$safeButton.Add_Click({
    Invoke-SimModeChange -EnableSafeMode $true
})

# Event handler for Normal Mode button
$normalButton.Add_Click({
    Invoke-SimModeChange -EnableSafeMode $false
})

# Configure Cancel button behavior so the form can close cleanly.
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton

# Center the non-button UI elements based on the form width.
$centerLayout = {
    Center-ButtonRow -Controls @($safeButton, $normalButton, $cancelButton) -Parent $form -Spacing 10
    Center-ControlHorizontally -Control $label -Parent $form
    Center-ControlHorizontally -Control $simGroupBox -Parent $form
    Center-ControlHorizontally -Control $platformGroupBox -Parent $form
    Center-CheckboxVisually -CheckBox $autoStartCheckbox -Parent $form
}

$form.Add_Shown($centerLayout)

# Show the form (launch the window) and suppress the dialog result output.
$form.ShowDialog() | Out-Null
