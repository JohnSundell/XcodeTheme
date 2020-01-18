import Foundation
import Files
import ShellOut

let fontsFolder = try Folder.home.subfolder(at: "Library/Fonts")

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

print("🎨  Installing Xcode theme...")

let themeURL = URL(fileURLWithPath: #file.replacingOccurrences(of: "Sources/XcodeTheme/main.swift", with: "SundellsColors.xccolortheme"))
let themeData = try Data(contentsOf: themeURL)

let xcodeFolder = try Folder.home.subfolder(at: "Library/Developer/Xcode")
let userDataFolder = try xcodeFolder.createSubfolderIfNeeded(withName: "UserData")
let themeFolder = try userDataFolder.createSubfolderIfNeeded(withName: "FontAndColorThemes")

let themeFile = try themeFolder.createFile(named: "SundellsColors.xccolortheme")
try themeFile.write(themeData)

print("")
print("🎉 Sundell's Colors successfully installed")
print("👍 Select it in Xcode's preferences to start using it (you may have to restart Xcode first)")
