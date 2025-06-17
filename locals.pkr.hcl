locals {
  boot = {
    sequoia = [
      # Hello, Hola, Bonjour, etc.
      "<wait60s><spacebar>",
      # Switch language
      "<wait15s>italiano<esc>english<enter>",
      # Select Your Country and Region
      "<wait15s>united states<leftShiftOn><tab><leftShiftOff><spacebar>",
      # Transfer Your Data to This Mac
      "<wait10s><tab><tab><tab><spacebar><tab><tab><spacebar>",
      # Written and Spoken Languages
      "<wait10s><leftShiftOn><tab><leftShiftOff><spacebar>",
      # Accessibility
      "<wait10s><leftShiftOn><tab><leftShiftOff><spacebar>",
      # Data & Privacy
      "<wait10s><leftShiftOn><tab><leftShiftOff><spacebar>",
      # Create Account
      "<wait15s>${var.account.description}<tab>${var.account.username}<tab>${var.account.password}<tab>${var.account.password}<tab><tab><spacebar><tab><tab><spacebar><wait30s>",
      # Enable Voice Over
      "<wait30s><leftAltOn><f5><leftAltOff>",
      # Sign In with Your Apple ID
      "<wait10s><leftShiftOn><tab><leftShiftOff><spacebar>",
      # Are you sure you want to skip signing in with an Apple ID?
      "<wait10s><tab><spacebar>",
      # Terms and Conditions
      "<wait10s><leftShiftOn><tab><leftShiftOff><spacebar>",
      # I have read and agree to the macOS Software License Agreement
      "<wait10s><tab><spacebar>",
      # Enable Location Services
      "<wait10s><leftShiftOn><tab><leftShiftOff><spacebar>",
      # Are you sure you don't want to use Location Services?
      "<wait10s><tab><spacebar>",
      # Select Your Time Zone
      "<wait10s><tab><tab>UTC<enter><leftShiftOn><tab><tab><leftShiftOff><spacebar>",
      # Analytics
      "<wait10s><leftShiftOn><tab><leftShiftOff><spacebar>",
      # Screen Time
      "<wait10s><tab><spacebar>",
      # Siri
      "<wait10s><tab><spacebar><leftShiftOn><tab><leftShiftOff><spacebar>",
      # Choose Your Look
      "<wait10s><leftShiftOn><tab><leftShiftOff><spacebar>",
      # Update Mac Automatically
      "<wait10s><tab><spacebar>",
      # Welcome to Mac
      "<wait10s><spacebar>",
      # Disable Voice Over
      "<wait15s><leftAltOn><f5><leftAltOff>",
      # Enable Keyboard navigation
      "<wait15s><leftAltOn><spacebar><leftAltOff>Terminal<enter>",
      "<wait10s>defaults write NSGlobalDomain AppleKeyboardUIMode -int 3<enter>",
      "<wait10s><leftAltOn>q<leftAltOff>",
      # Now that the installation is done, open "System Settings"
      "<wait10s><leftAltOn><spacebar><leftAltOff>System Settings<enter>",
      # Navigate to "Sharing"
      "<wait10s><leftCtrlOn><f2><leftCtrlOff><right><right><right><down>Sharing<enter>",
      # Navigate to "Screen Sharing" and enable it
      "<wait10s><tab><tab><tab><tab><tab><tab><tab><spacebar>",
      # Navigate to "Remote Login" and enable it
      "<wait10s><tab><tab><tab><tab><tab><tab><tab><tab><tab><tab><tab><tab><spacebar>",
      # Quit System Settings
      "<wait10s><leftAltOn>q<leftAltOff>",
      # Disable Gatekeeper (1/2)
      "<wait10s><leftAltOn><spacebar><leftAltOff>Terminal<enter>",
      "<wait10s>sudo spctl --global-disable<enter>",
      "<wait10s>${var.account.password}<enter>",
      "<wait10s><leftAltOn>q<leftAltOff>",
      # Disable Gatekeeper (2/2)
      "<wait10s><leftAltOn><spacebar><leftAltOff>System Settings<enter>",
      "<wait10s><leftCtrlOn><f2><leftCtrlOff><right><right><right><down>Privacy & Security<enter>",
      "<wait10s><leftShiftOn><tab><leftShiftOff><leftShiftOn><tab><leftShiftOff><leftShiftOn><tab><leftShiftOff><leftShiftOn><tab><leftShiftOff><leftShiftOn><tab><leftShiftOff><leftShiftOn><tab><leftShiftOff><leftShiftOn><tab><leftShiftOff>",
      "<wait10s><down><wait1s><down><wait1s><enter>",
      "<wait10s>${var.account.password}<enter>",
      "<wait10s><leftShiftOn><tab><leftShiftOff><wait1s><spacebar>",
      "<wait10s><leftAltOn>q<leftAltOff>",
      # Allow Automation
      "<wait10s><leftAltOn><spacebar><leftAltOff>Terminal<enter>",
      "<wait10s>automationmodetool enable-automationmode-without-authentication<enter>",
      "<wait10s>${var.account.password}<enter>",
      "<wait10s><leftAltOn>q<leftAltOff>",
    ]
    sonoma  = [
      # Hello, Hola, Bonjour, etc.
      "<wait60s><spacebar>",
      # Switch language
      "<wait15s>italiano<esc>english<enter>",
      # Select Your Country and Region
      "<wait15s>united states<leftShiftOn><tab><leftShiftOff><spacebar>",
      # Written and Spoken Languages
      "<wait10s><leftShiftOn><tab><leftShiftOff><spacebar>",
      # Accessibility
      "<wait10s><leftShiftOn><tab><leftShiftOff><spacebar>",
      # Data & Privacy
      "<wait10s><leftShiftOn><tab><leftShiftOff><spacebar>",
      # Migration Assistant
      "<wait10s><tab><tab><tab><spacebar>",
      # Sign In with Your Apple ID
      "<wait10s><leftShiftOn><tab><leftShiftOff><leftShiftOn><tab><leftShiftOff><spacebar>",
      # Are you sure you want to skip signing in with an Apple ID?
      "<wait10s><tab><spacebar>",
      # Terms and Conditions
      "<wait10s><leftShiftOn><tab><leftShiftOff><spacebar>",
      # I have read and agree to the macOS Software License Agreement
      "<wait10s><tab><spacebar>",
      # Create Account
      "<wait10s>${var.account.username}<tab><tab>${var.account.password}<tab>${var.account.password}<tab><tab><tab><spacebar>",
      # Enable Location Services
      "<wait30s><leftShiftOn><tab><leftShiftOff><spacebar>",
      # Are you sure you don't want to use Location Services?
      "<wait10s><tab><spacebar>",
      # Select Your Time Zone
      "<wait10s><tab>UTC<enter><leftShiftOn><tab><leftShiftOff><spacebar>",
      # Analytics
      "<wait10s><leftShiftOn><tab><leftShiftOff><spacebar>",
      # Screen Time
      "<wait10s><tab><spacebar>",
      # Siri
      "<wait10s><tab><spacebar><leftShiftOn><tab><leftShiftOff><spacebar>",
      # Choose Your Look
      "<wait10s><leftShiftOn><tab><leftShiftOff><spacebar>",
      # Enable Voice Over
      "<wait10s><leftAltOn><f5><leftAltOff><wait10s>v",
      # Now that the installation is done, open "System Settings"
      "<wait10s><leftAltOn><spacebar><leftAltOff>System Settings<enter>",
      # Navigate to "Sharing"
      "<wait10s><leftAltOn>f<leftAltOff>sharing<enter>",
      # Navigate to "Screen Sharing" and enable it
      "<wait10s><tab><tab><tab><tab><tab><spacebar>",
      # Navigate to "Remote Login" and enable it
      "<wait10s><tab><tab><tab><tab><tab><tab><tab><tab><tab><tab><tab><tab><spacebar>",
      # Disable Voice Over
      "<leftAltOn><f5><leftAltOff>",
    ]
    ventura = [
      # Hello, Hola, Bonjour, etc.
      "<wait60s><spacebar>",
      # Switch language
      "<wait15s>italiano<esc>english<enter>",
      # Select Your Country and Region
      "<wait15s>united states<leftShiftOn><tab><leftShiftOff><spacebar>",
      # Written and Spoken Languages
      "<wait10s><leftShiftOn><tab><leftShiftOff><spacebar>",
      # Accessibility
      "<wait10s><leftShiftOn><tab><leftShiftOff><spacebar>",
      # Data & Privacy
      "<wait10s><leftShiftOn><tab><leftShiftOff><spacebar>",
      # Migration Assistant
      "<wait10s><tab><tab><tab><spacebar>",
      # Sign In with Your Apple ID
      "<wait10s><leftShiftOn><tab><leftShiftOff><leftShiftOn><tab><leftShiftOff><spacebar>",
      # Are you sure you want to skip signing in with an Apple ID?
      "<wait10s><tab><spacebar>",
      # Terms and Conditions
      "<wait10s><leftShiftOn><tab><leftShiftOff><spacebar>",
      # I have read and agree to the macOS Software License Agreement
      "<wait10s><tab><spacebar>",
      # Create a Computer Account
      "<wait10s>${var.account.username}<tab><tab>${var.account.password}<tab>${var.account.password}<tab><tab><tab><spacebar>",
      # Enable Location Services
      "<wait10s><leftShiftOn><tab><leftShiftOff><spacebar>",
      # Are you sure you don't want to use Location Services?
      "<wait10s><tab><spacebar>",
      # Select Your Time Zone
      "<wait10s><tab>UTC<enter><leftShiftOn><tab><leftShiftOff><spacebar>",
      # Analytics
      "<wait10s><leftShiftOn><tab><leftShiftOff><spacebar>",
      # Screen Time
      "<wait10s><tab><spacebar>",
      # Siri
      "<wait10s><tab><spacebar><leftShiftOn><tab><leftShiftOff><spacebar>",
      # Choose Your Look
      "<wait10s><leftShiftOn><tab><leftShiftOff><spacebar>",
      # Enable Voice Over
      "<wait10s><leftAltOn><f5><leftAltOff><wait10s>v",
      # Now that the installation is done, open "System Settings"
      "<wait10s><leftAltOn><spacebar><leftAltOff>System Settings<enter>",
      # Navigate to "Sharing"
      "<wait10s><leftAltOn>f<leftAltOff>sharing<enter>",
      # Navigate to "Screen Sharing" and enable it
      "<wait10s><tab><down><spacebar>",
      # Navigate to "Remote Login" and enable it
      "<wait10s><tab><tab><tab><tab><tab><tab><spacebar>",
      # Open "Remote Login" details
      "<wait10s><tab><spacebar>",
      # Enable "Full Disk Access"
      "<wait10s><tab><spacebar>",
      # Click "Done"
      "<wait10s><leftShiftOn><tab><leftShiftOff><leftShiftOn><tab><leftShiftOff><spacebar>",
      # Disable Voice Over
      "<leftAltOn><f5><leftAltOff>",
    ]
  }
  sources = {
    sequoia = "https://updates.cdn-apple.com/2025SpringFCS/fullrestores/082-44534/CE6C1054-99A3-4F67-A823-3EE9E6510CDE/UniversalMac_15.5_24F74_Restore.ipsw",
    sonoma  = "https://updates.cdn-apple.com/2024SummerFCS/fullrestores/052-69922/F5DA2B64-25EB-4370-9E89-FA5689859796/UniversalMac_14.6_23G80_Restore.ipsw",
    ventura = "https://updates.cdn-apple.com/2023FallFCS/fullrestores/042-55833/C0830847-A2F8-458F-B680-967991820931/UniversalMac_13.6_22G120_Restore.ipsw"
  }
}
