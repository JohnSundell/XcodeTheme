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

let darkThemeURL = URL(fileURLWithPath: #file.replacingOccurrences(of: "Sources/XcodeTheme/main.swift", with: "SundellsColorsDark.xccolortheme"))
let lightThemeURL = URL(fileURLWithPath: #file.replacingOccurrences(of: "Sources/XcodeTheme/main.swift", with: "SundellsColorsLight.xccolortheme"))
let darkThemeData = try Data(contentsOf: darkThemeURL)
let lightThemeData = try Data(contentsOf: lightThemeURL)

let xcodeFolder = try Folder.home.subfolder(at: "Library/Developer/Xcode")
let userDataFolder = try xcodeFolder.createSubfolderIfNeeded(withName: "UserData")
let themeFolder = try userDataFolder.createSubfolderIfNeeded(withName: "FontAndColorThemes")

let darkThemeFile = try themeFolder.createFile(named: "SundellsColorsDark.xccolortheme")
let lightThemeFile = try themeFolder.createFile(named: "SundellsColorsLight.xccolortheme")
try darkThemeFile.write(darkThemeData)
try lightThemeFile.write(lightThemeData)

print("")
print("🎉 Sundell's Colors Dark successfully installed")
print("🎉 Sundell's Colors Light successfully installed")
print("👍 Select them in Xcode's preferences to start using it (you may have to restart Xcode first)")
