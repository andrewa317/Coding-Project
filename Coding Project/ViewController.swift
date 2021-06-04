

import UIKit
import AVFoundation
// Imports framework for playing audio ^
import AVKit
    		
class ViewController: UIViewController {
    
    var player = AVAudioPlayer()
    
    @IBOutlet weak var videoView: UIView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let sound = Bundle.main.path(forResource: "Claire De Lune", ofType: "mp3")
        
        //bundle main contains the directory of the currently executed code
        
        //do catch helps present errors
        do {
        player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath:sound!))

        }
        catch {
            print(error)
        }
    }
			

    
    private func setupView() {
        let video = URL(fileURLWithPath: Bundle.main.path(forResource: "VIDEO 1", ofType: "mov")!)
        
        let videoPlayer = AVPlayer(url: video)
        
        let videoLayer = AVPlayerLayer(player: videoPlayer)
        //AVPLayerLayer allows me to put the video in the background and allows me to do cool things like fill aspect ratio

        
        videoLayer.frame = self.videoView.frame
        self.videoView.layer.addSublayer(videoLayer)
        videoLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        //fills the video to the entire screen, looks clean
        
        videoPlayer.play()
        videoPlayer.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.videoDidPlayToEnd(_:)), name: NSNotification.Name(rawValue: "AVPlayerItemEndTimeNotification"), object: videoPlayer.currentItem)

        //In attempt to figure out how to make the video loop, I found a workaround that uses notification center as an ovserver to notify when the video ends. The next section calls it to play the video again. I use @objc because there was a selector.
    }
    @objc func videoDidPlayToEnd(_ notification: Notification) {
        let videoPlayer: AVPlayerItem = notification.object as! AVPlayerItem
        videoPlayer.seek(to: CMTime.zero)
        //.seek function brings video to where you call it to, in this case zero is the beginning. "as" serves to treat the previous object as the AVPlayerItem
    }
    
    @IBAction func Play(_ sender: Any) {
        player.play()
        //ties the button f	rom storyboard to the play function
        setupView()
    }

    
}



	
