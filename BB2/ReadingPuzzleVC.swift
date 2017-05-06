import UIKit
import Speech

import UIKit
import AVFoundation

class ReadingPuzzleVC: UIViewController {
    
    @IBOutlet var spokenTextField: UITextView!
    @IBOutlet var storyLabel: UILabel!
    @IBOutlet var recordButton: UIButton!
    
    var storyText:String = ""
    var spokenText:String?
    var storyWordArray:[String] = []
    
    fileprivate let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    fileprivate var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    fileprivate var recognitionTask: SFSpeechRecognitionTask?
    fileprivate let audioEngine = AVAudioEngine()
    
    var audioRecorder: AVAudioRecorder!
    @IBOutlet weak var waveformView: WaveformView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Disable the record buttons until authorization has been granted
        recordButton.isEnabled = false
        speechRecognizer.delegate = self
        requestSpeechAuthorization()
        
        storyText = storyLabel.text!
        storyWordArray = storyText.components(separatedBy: " ")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        audioRecorder = audioRecorder(URL(fileURLWithPath:"/dev/null"))
        audioRecorder.record()
        
        let displayLink = CADisplayLink(target: self, selector: #selector(updateMeters))
        displayLink.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        audioRecorder.stop()
    }
    
    deinit {
        print("Deinit audio puzzle")
        audioRecorder.stop()
    }
    
    func updateMeters() {
        audioRecorder.updateMeters()
        let normalizedValue = pow(10, audioRecorder.averagePower(forChannel: 0) / 20) * 10
        print(normalizedValue)
        waveformView.updateWithLevel(CGFloat(normalizedValue))
    }
    
    func audioRecorder(_ filePath: URL) -> AVAudioRecorder {
        let recorderSettings: [String : AnyObject] = [
            AVSampleRateKey: 44100.0 as AnyObject,
            AVFormatIDKey: NSNumber(value: kAudioFormatMPEG4AAC),
            AVNumberOfChannelsKey: 2 as AnyObject,
            AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue as AnyObject
        ]
        
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        let audioRecorder = try! AVAudioRecorder(url: filePath, settings: recorderSettings)
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        
        return audioRecorder
    }

    
    func requestSpeechAuthorization() {
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.recordButton.isEnabled = true
                    self.recordButton.setTitle("Record", for: .normal)
                case .denied:
                    self.recordButton.isEnabled = false
                    self.recordButton.setTitle("User denied access to speech recognition", for: .disabled)
                case .restricted:
                    self.recordButton.isEnabled = false
                    self.recordButton.setTitle("Speech recognition restricted on this device", for: .disabled)
                case .notDetermined:
                    self.recordButton.isEnabled = false
                    self.recordButton.setTitle("Speech recognition not yet authorized", for: .disabled)
                }
            }
        }
    }
}

//MARK: - Voice Recording
extension ReadingPuzzleVC {
    
    fileprivate func startRecording() throws {
        
        //Cancel the previous task if it's running
        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSessionCategoryRecord)
        try audioSession.setMode(AVAudioSessionModeMeasurement)
        try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object")
        }
        
        // Configure request so that results are returned before audio recording is finished
        recognitionRequest.shouldReportPartialResults = true
        
        // A recognition task represents a speech recognition session
        // We keep a reference to the task so that it can be cancelled
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { [unowned self] result, error in
            // This block will be called multiple times until the recognition task is complete
            // Therefore we don't use guard lets because we don't want to exit out of the block's
            // execution prematurely
            
            var isFinal = false
            
            if let result = result {
                let resultText = result.bestTranscription.formattedString
                self.spokenText = resultText
                self.spokenTextField.text = resultText
                self.moveTextIfItMatches()
                isFinal = result.isFinal
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                self.recordButton.isEnabled = true
                self.recordButton.setTitle("Record", for: .normal)
            }
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer:AVAudioPCMBuffer, when:AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
        spokenTextField.text = "(Go adhead, I'm listening)"
    }
    
    func moveTextIfItMatches() {
        guard let spokenText = spokenText else { return }
        
        let spokenWordArray = spokenText.components(separatedBy: " ")
        
        for word in spokenWordArray {
            if storyWordArray.first?.lowercased() == word.lowercased() {
                let font = UIFont.systemFont(ofSize: 17)
                let string = word + " "
                let width = string.width(usingFont: font)
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.storyLabel.center = CGPoint(x: self.storyLabel.center.x - width, y: self.storyLabel.center.y)
                    })
                }
                storyWordArray.removeFirst()
            }
        }
        
    }
}


//MARK: - Button Handling
extension ReadingPuzzleVC {

    @IBAction func recordButtonPressed(_ sender: UIButton) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            recordButton.isEnabled = false
            recordButton.setTitle("Stopping", for: .disabled)
        } else {
            try! startRecording()
            recordButton.setTitle("Stop", for: .normal)
        }
    }
}

extension ReadingPuzzleVC: SFSpeechRecognizerDelegate {
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        
        if available {
            recordButton.isEnabled = false
            recordButton.setTitle("Unavailable", for: .disabled)
        } else {
            recordButton.isEnabled = true
            recordButton.setTitle("Record", for: .normal)
        }
    }
}
