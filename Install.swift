import Foundation
import Files // marathon:https://github.com/JohnSundell/Files.git
import ShellOut // marathon:https://github.com/JohnSundell/ShellOut.git

let fontsFolder = try Folder.home.subfolder(atPath: "Library/Fonts")

if !fontsFolder.containsFile(named: "SourceCodePro-Regular.ttf") {
    print("🅰️  Downloading Source Code Pro font...")

    let fontZipURL = URL(string: "https://github.com/adobe-fonts/source-code-pro/archive/2.030R-ro/1.050R-it.zip")!
    let fontZipData = try Data(contentsOf: fontZipURL)

    print("🅰️  Installing Source Code Pro font...")

    let fontZipFile = try fontsFolder.createFile(named: "SourceCodePro.zip", contents: fontZipData)
    try shellOut(to: "unzip \(fontZipFile.name) -d SourceCodePro", at: fontsFolder.path)

    let sourceCodeProFolder = try fontsFolder.subfolder(named: "SourceCodePro")
    let ttfFolder = try sourceCodeProFolder.subfolders.first!.subfolder(named: "TTF")
    try ttfFolder.files.move(to: fontsFolder)

    try sourceCodeProFolder.delete()
    try fontZipFile.delete()
}

print("🎨  Downloading Xcode theme...")

let themeURL = URL(string: "https://raw.githubusercontent.com/JohnSundell/XcodeTheme/master/SundellsColors.xccolortheme")!
let themeData = try Data(contentsOf: themeURL)

print("🎨  Installing Xcode theme...")

let xcodeFolder = try Folder.home.subfolder(atPath: "Library/Developer/Xcode")
let userDataFolder = try xcodeFolder.createSubfolderIfNeeded(withName: "UserData")
let themeFolder = try userDataFolder.createSubfolderIfNeeded(withName: "FontAndColorThemes")

let themeFile = try themeFolder.createFile(named: "SundellsColors.xccolortheme")
try themeFile.write(data: themeData)

print("")
print("🎉 Sundell's Colors successfully installed")
print("👍 Select it in Xcode's preferences to start using it (you may have to restart Xcode first)")
