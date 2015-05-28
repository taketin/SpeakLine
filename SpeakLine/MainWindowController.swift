//
//  MainWindowController.swift
//  SpeakLine
//
//  Created by Takeshita Hidenori on 2015/05/25.
//  Copyright (c) 2015年 taketin. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var voicesPopup: NSPopUpButton!
    @IBOutlet weak var speakButton: NSButton!
    @IBOutlet weak var stopButton: NSButton!

    let speechSynth = NSSpeechSynthesizer()
    let voices = NSSpeechSynthesizer.availableVoices()!
    let voiceNamePrefix = "com.apple.speech.synthesis.voice."
    var isStarted: Bool = false {
        didSet {
            updateButtons()
        }
    }

    override var windowNibName: String {
        return "MainWindowController"
    }

    override func windowDidLoad() {
        super.windowDidLoad()
        updateButtons()
        speechSynth.delegate = self
        setupVoicesPopup()
    }

    // mark: - Action methods

    @IBAction func speakIt(sender: NSButton) {
        let selectedVoice = voicesPopup.selectedItem!.title
        speechSynth.setVoice(voiceNamePrefix + selectedVoice)
        let string = textField.stringValue
        if string.isEmpty {
            println("string from \(textField) is empty.")
        } else {
            speechSynth.startSpeakingString(string)
            isStarted = true
        }
    }

    @IBAction func stopIt(sender: NSButton) {
        speechSynth.stopSpeaking()
    }

    // mark: - private methods

    private func updateButtons() {
        if isStarted {
            speakButton.enabled = false
            stopButton.enabled = true
        } else {
            speakButton.enabled = true
            stopButton.enabled = false
        }
    }

    private func setupVoicesPopup() {
        for i in voices {
            voicesPopup.addItemWithTitle(i.substringFromIndex(count(voiceNamePrefix)))
        }
    }
}

extension MainWindowController: NSSpeechSynthesizerDelegate {
    func speechSynthesizer(sender: NSSpeechSynthesizer, didFinishSpeaking finishedSpeaking: Bool) {
        isStarted = false
        println("finishedSpeaking=\(finishedSpeaking)")
    }
}

extension MainWindowController: NSWindowDelegate {
    func windowShouldClose(sender: AnyObject) -> Bool {
        return !isStarted
    }
}