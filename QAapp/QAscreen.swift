//
//  QAscreen.swift
//  QAapp
//
//  Created by Apple on 05/07/2019.
//  Copyright © 2019 devstop. All rights reserved.
//

import UIKit
import Speech

class QAscreen: UIViewController {
    
    //// UI OBJECTS
    
    
    
    let backgroundImage: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "background.png")
        imageview.contentMode = .scaleAspectFit
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    let cardView: UIView = {
        let view = UIView()
        //        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let questionView: UIImageView = {
        let imageview = UIImageView()
        //        view.backgroundColor = .white
        imageview.image = UIImage(named: "QuestionBox_big.png")
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    
    let micImageViewButton: UIButton = {
        let button = UIButton(type: .system)
        //        button.backgroundColor = .white
        button.setImage(UIImage(named: "mic_big.png"), for: UIControl.State.normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(start_StopButtonHandler), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    let questionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "QUESTION"
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Medium", size: 23)
        //        label.font = UIFont.systemFont(ofSize: 23)
        label.textColor = customColor.singleton.orangeColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Light", size: 18)
        //        label.text = "What is the Capital of"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let recordLabel: UILabel = {
        let label = UILabel()
        label.text = "TAP TO RECORD YOUR ANSWER"
        label.numberOfLines = 2
        label.textAlignment = .center
        //        label.font = UIFont(name: "Roboto-Medium", size: 40)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let countQuestionView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 7
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "stencil", size: 28)
        label.text = "/10"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = customColor.singleton.orangeColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let skipButtonContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 22
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let skipLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Bold", size: 20)
        label.text = "SKIP"
        label.textAlignment = .center
        label.textColor = customColor.singleton.orangeColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let circleView: UIView = {
        let view = UIView()
        view.backgroundColor = customColor.singleton.orangeColor
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let circleImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "skip_icon_only_big.png")
        imageview.contentMode = .scaleAspectFit
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(skipHandler), for: .touchUpInside)
        return button
    }()
    
    
    var count: Int = 0
    var correctAnswers: Int = 0
    
    var checkStartStop = false
    
    var questions = [String]()
    //    let questions: [String] = ["Pakistan", "England", "France", "Canada", "China", "Germany", "USA", "UAE", "Russia", "Australia"]
    var recordedData: String = ""
    var recordedAnswer: [String] = []
    var correctAnsList: [String] = []
    var wrongAnsList: [String] = []
    var correctIncorrectList: [[String]] = [[]]
    
    var answers = [String]()
//    let answers = ["Islamabad", "London", "Paris", "Ottawa", "Beijing", "Berlin", "Washington", "Abu Dhabi", "Moscow", "Canberra"]

    
    
    
    //// VIEW WILL APPEAR
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.isHidden = true
        
    }
    
    
    //// ================================ PRIVARE VARIABLES ==================================
    
    private var speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US")) //1
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private var audioEngine = AVAudioEngine()
    var lang: String = "en-US"
    
    //// VIEW DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.questionTitleLabel.text = data.singleton.apiResponseQuestion[0]
        
        data.singleton.apiResponseQuestion.removeFirst()
        data.singleton.apiResponseAnswer.removeFirst()
        
        print("QUESTION: \(data.singleton.apiResponseQuestion)")
        print("ANSWER: \(data.singleton.apiResponseAnswer)")
        
        self.questions = data.singleton.apiResponseQuestion
        self.answers = data.singleton.apiResponseAnswer
        
        questionLabel.text = "\(questions[count])"
        countLabel.text = "\(count+1)/\(questions.count)"
        
        data.singleton.questions = questions
        
        self.setupViews()
        
        
        //// ============= custom code ==============
        
        micImageViewButton.isEnabled = false  //2
        speechRecognizer?.delegate = self as? SFSpeechRecognizerDelegate  //3
        speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: lang))
        SFSpeechRecognizer.requestAuthorization { (authStatus) in  //4
            
            var isButtonEnabled = false
            
            switch authStatus {  //5
            case .authorized:
                isButtonEnabled = true
                
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
                
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
            
            OperationQueue.main.addOperation() {
                self.micImageViewButton.isEnabled = isButtonEnabled
            }
        }
        
        speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: lang))
        
    }
    
    
    //// OBJECTIVE C HANDLERS
    
    func nextQuestion() {
        
        if (count < questions.endIndex-1){
            count = count + 1
            questionLabel.text = "\(questions[count])"
            countLabel.text = "\(count+1)/\(questions.count)"
        }
        else{
            ToastView.shared.long(view, txt_msg: "No More Questions")
        }
        
    }
    
    func calculatingResults() {
        for index in 0..<answers.count {
            
            if answers[index] == recordedAnswer[index]{
                correctAnsList.append(answers[index])
                correctIncorrectList.append(["Correct"])
                correctAnswers = correctAnswers + 1
            }else{
                wrongAnsList.append(recordedAnswer[index])
                correctIncorrectList.append([recordedAnswer[index] + " - " + " Correct: " + answers[index]])
            }
            
        }
        
        data.singleton.correctAnswers = correctAnsList
        data.singleton.totalCorrect = correctAnswers
        data.singleton.wrongAnswers = wrongAnsList
//        correctIncorrectList.remove(at: 0)
        data.singleton.correctIncorrectAnswers = correctIncorrectList
        
    }
    
    @objc func skipHandler(){
        
        nextQuestion()
        
    }
    
    
    @objc func start_StopButtonHandler(){
        
        speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: lang))
        
        if audioEngine.isRunning {
            
            // move to finish screen
            //            calculatingResults()
            //            self.show(ResultViewController(), sender: self)
            
            audioEngine.stop()
            recognitionRequest?.endAudio()
            micImageViewButton.isEnabled = false
            self.recordedAnswer.append(self.recordedData)
            recordLabel.text = "Start Recording"
            print("answers: \(self.recordedAnswer)")
            self.nextQuestion()
            
            
            
        } else {
            startRecording()
            micImageViewButton.pulsate()
            recordLabel.text = "Stop Recording"
        }
        
    }
    //// PRIVATE FUNCTIONS
    
    fileprivate func setupViews() {
        
        view.addSubview(backgroundImage)
        
        view.addSubview(cardView)
        cardView.addSubview(questionView)
        cardView.addSubview(questionTitleLabel)
        cardView.addSubview(questionLabel)
        view.addSubview(micImageViewButton)
        view.addSubview(recordLabel)
        view.addSubview(countQuestionView)
        view.addSubview(skipButtonContainerView)
        view.addSubview(skipButton)
        
        backgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        backgroundImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        backgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        
        cardView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        let centerY1 = NSLayoutConstraint(item: cardView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 0.7, constant: 0)
        
        NSLayoutConstraint.activate([centerY1])
        cardView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        
        questionView.widthAnchor.constraint(equalTo: cardView.widthAnchor).isActive = true
        questionView.heightAnchor.constraint(equalTo: cardView.heightAnchor).isActive = true
        questionView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        questionView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
        
        questionTitleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10).isActive = true
        questionTitleLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        
        
        questionLabel.centerXAnchor.constraint(equalTo: questionTitleLabel.centerXAnchor).isActive = true
        questionLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        questionLabel.widthAnchor.constraint(equalTo: cardView.widthAnchor, constant: -40).isActive = true
        
        
        
        
        micImageViewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        let centerY = NSLayoutConstraint(item: micImageViewButton, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.35, constant: 0)
        
        NSLayoutConstraint.activate([centerY])
        
        micImageViewButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35).isActive = true
        micImageViewButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35).isActive = true
        
        recordLabel.topAnchor.constraint(equalTo: micImageViewButton.bottomAnchor, constant: 5).isActive = true
        recordLabel.centerXAnchor.constraint(equalTo: micImageViewButton.centerXAnchor).isActive = true
        recordLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        recordLabel.widthAnchor.constraint(equalTo: micImageViewButton.widthAnchor, constant: 30).isActive = true
        
        
        countQuestionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        countQuestionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        countQuestionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        countQuestionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08).isActive = true
        
        countQuestionView.addSubview(countLabel)
        countLabel.centerXAnchor.constraint(equalTo: countQuestionView.centerXAnchor).isActive = true
        countLabel.centerYAnchor.constraint(equalTo: countQuestionView.centerYAnchor).isActive = true
        
        skipButtonContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        skipButtonContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        skipButtonContainerView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        skipButtonContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.375).isActive = true
        
        skipButtonContainerView.addSubview(skipLabel)
        skipButtonContainerView.addSubview(circleView)
        
        skipLabel.leftAnchor.constraint(equalTo: skipButtonContainerView.leftAnchor, constant: 15).isActive = true
        skipLabel.centerYAnchor.constraint(equalTo: skipButtonContainerView.centerYAnchor).isActive = true
        
        circleView.rightAnchor.constraint(equalTo: skipButtonContainerView.rightAnchor, constant: -10).isActive = true
        circleView.centerYAnchor.constraint(equalTo: skipButtonContainerView.centerYAnchor).isActive = true
        circleView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        circleView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        circleView.addSubview(circleImageView)
        circleImageView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
        circleImageView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor).isActive = true
        circleImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        circleImageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
        skipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        skipButton.bottomAnchor.constraint(equalTo: skipButtonContainerView.bottomAnchor).isActive = true
        skipButton.heightAnchor.constraint(equalTo: skipButtonContainerView.heightAnchor).isActive = true
        skipButton.widthAnchor.constraint(equalTo: skipButtonContainerView.widthAnchor).isActive = true
        
    }
    
    
    func startRecording() {
        
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.record, mode: .default)
            //            try audioSession.setCategory(AVAudioSession.Category.record)
            try audioSession.setMode(AVAudioSession.Mode.measurement)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                
                self.recordedData = (result?.bestTranscription.formattedString)!
                
                print("recorded data: \(self.recordedData)")
                print("isFinal = \(isFinal)")
                isFinal = (result?.isFinal)!
                
                
            }
            
            if error != nil || isFinal {
                
                print(self.recordedAnswer.count)
                
                if (self.recordedAnswer.count == self.questions.count) {
                    print("print 1")
                    
                    print("recordedAnswer:\(self.recordedAnswer)")
                    
                    self.calculatingResults()
                    self.show(ResultViewController(), sender: self)
                }
                
                
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.micImageViewButton.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
        print("Say something, I'm listening!")
        //        textView.text = "Say something, I'm listening!"
        
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            micImageViewButton.isEnabled = true
        } else {
            micImageViewButton.isEnabled = false
        }
    }
    
}
