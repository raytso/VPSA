//
//  CameraViewFeed.swift
//  NoMoreParking
//
//  Created by Ray Tso on 9/16/16.
//  Copyright © 2016 Ray Tso. All rights reserved.
//

import Foundation
import AVFoundation

protocol CameraFeedDelegate: class {
    func finishedRenderingCapture()
}


class CameraFeed: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate, AVCapturePhotoCaptureDelegate, CapturedImageDataSource {
//    private var cameraDataOutput: AVCaptureVideoDataOutput?
    private var captureDeviceOutputQueue: DispatchQueue?
    private var devicesToSearch: [AVCaptureDeviceType]! = [.builtInWideAngleCamera,
                                                           .builtInDuoCamera]
    private var captureSession: AVCaptureSession?
    private var frameImage: CGImage?
    public  var previewLayer: AVCaptureVideoPreviewLayer!
    private var capturePhotoOutput: AVCapturePhotoOutput?
    private var capturePhotoSettings: AVCapturePhotoSettings!
    private var captureDeviceVideoOutput: AVCaptureVideoDataOutput!
    private var capturedImageDataSets: [Data]? = []
    weak var delegate: CameraFeedDelegate?
    
    // MARK: - Protocols
    
    func getCapturedImageDataSets(sender: ConfirmPopoverViewController) -> [Data]? {
        return capturedImageDataSets
    }
    
//    private var capturePhotoDelegation: AVCapturePhotoCaptureDelegate?
    // MARK: - Camera Setup
    
    enum DevicePosition {
        case FrontCamera
        case BackCamera
    }
    
    private func cameraSetup(captureDevicePosition: AVCaptureDevicePosition) {
        var captureDevice: AVCaptureDevice?
        var captureDeviceInput: AVCaptureDeviceInput?
        
        var canSetupCamera: Bool = false
        
        self.captureSession = AVCaptureSession()
        
        if let discoverySession = AVCaptureDeviceDiscoverySession.init(deviceTypes: devicesToSearch,
                                                                       mediaType: AVMediaTypeVideo,
                                                                       position: captureDevicePosition) {
            for device in discoverySession.devices {
                // Finding general camera
                if #available(iOS 10.2, *) {
                    if device.deviceType == AVCaptureDeviceType.builtInDualCamera {
                        captureDevice = device
                        break
                    }
                }
                // Fallback on earlier versions
                if device.deviceType == AVCaptureDeviceType.builtInWideAngleCamera {
                    captureDevice = device
                    break
                } else {
                    // Provide any camera that works
                    break
                }
                
            }
            
            // General camera setup
            do {
                captureDeviceInput = try AVCaptureDeviceInput.init(device: captureDevice)
            }
            catch {
                // Cannot add input device
                // Throws error
            }
            if captureSession!.canAddInput(captureDeviceInput) {
                captureSession!.addInput(captureDeviceInput)
                if captureSession!.canSetSessionPreset(AVCaptureSessionPresetPhoto) {
                    captureSession!.sessionPreset = AVCaptureSessionPresetPhoto
                    canSetupCamera = true
                }
                else {
                    debugPrint("Cannot setup capture session preset")
                }
                // Another preset?
            }
            if canSetupCamera {
                // Capture photo settings
                setupPhotoSettings()
                captureDeviceVideoOutput = AVCaptureVideoDataOutput()
                capturePhotoOutput = AVCapturePhotoOutput()
                // Default
                captureDeviceVideoOutput.videoSettings = nil
                captureDeviceVideoOutput.alwaysDiscardsLateVideoFrames = true
                captureDeviceOutputQueue = DispatchQueue(label: "CaptureDeviceOutputQueue",
                                                         qos: .background,
                                                         target: nil)
                captureDeviceVideoOutput.setSampleBufferDelegate(self, queue: captureDeviceOutputQueue)
                if captureSession!.canAddOutput(captureDeviceVideoOutput) {
                    captureSession!.addOutput(captureDeviceVideoOutput)
                } else {
                    debugPrint("Cannot add video output")
                }
                if captureSession!.canAddOutput(capturePhotoOutput) {
                    captureSession!.addOutput(capturePhotoOutput)
                }
                else {
                    debugPrint("Cannot add photo output")

                }
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
                debugPrint("Camera finished setup")
            } else {
                print("Cannot setup camera")
            }
        }
    }
    
    private func setupPhotoSettings() {
        capturePhotoSettings = AVCapturePhotoSettings.init(format: [AVVideoCodecKey: AVVideoCodecJPEG])
        capturePhotoSettings.isAutoStillImageStabilizationEnabled = true
    }
    
    func startCamera() {
        debugPrint("Camera starting")
        self.captureSession?.startRunning()
    }
    
    func stopCamera() {
        self.captureSession?.stopRunning()
        debugPrint("Camera stopped")
    }
    
//    func captureImage(completion:(_ result: String) -> Void) {
//        self.capturePhotoOutput!.capturePhoto(with: capturePhotoSettings, delegate: self)
//        completion("Done")
//    }

    func captureImage() {
        DispatchQueue.global(qos: .utility).async { [unowned self] in
            let settings = AVCapturePhotoSettings.init(format: [AVVideoCodecKey: AVVideoCodecJPEG])
            self.capturePhotoOutput?.capturePhoto(with: settings, delegate: self)
        }
//        setupPhotoSettings()
    }
    
    func capture(_ captureOutput: AVCapturePhotoOutput,
                 didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?,
                 previewPhotoSampleBuffer: CMSampleBuffer?,
                 resolvedSettings: AVCaptureResolvedPhotoSettings,
                 bracketSettings: AVCaptureBracketedStillImageSettings?,
                 error: Error?) {
        guard (error == nil) else {
            debugPrint(error!.localizedDescription)
            return
        }
        let sampleBuffer = photoSampleBuffer
        let previewBuffer = previewPhotoSampleBuffer
        let imageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer!,previewPhotoSampleBuffer: previewBuffer)
        capturedImageDataSets?.append(imageData!)
        debugPrint(capturedImageDataSets?.count ?? 0)
        delegate?.finishedRenderingCapture()
    }
    
    func captureVideo() {
        
    }
    
    private func setPreviewLayerFrame(frame: CGRect) {
        previewLayer?.frame = frame
    }
    
    func setupCameraSettings(cameraType captureDevicePosition: DevicePosition, cameraPreviewFrameSize: CGRect) {
        switch captureDevicePosition {
            case .FrontCamera:
                self.cameraSetup(captureDevicePosition: .front)
            case .BackCamera:
                self.cameraSetup(captureDevicePosition: .back)
        }
        setPreviewLayerFrame(frame: cameraPreviewFrameSize)
    }
}

