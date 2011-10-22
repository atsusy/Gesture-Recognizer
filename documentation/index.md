# Gesture Recognizer Module

## Description

This module extends rotateGesture and pinchGesture property to your view.

## Accessing the repeatedbackgroundimage Module

Declare to tiapp.xml like below.

    <modules>
        <module version="1.0">jp.msmc.gesturerecognizer</module>
    </modules>

## Reference

This module has no property and function.

## Usage
    var image = Ti.UI.createImageView({  
        rotateGesture:true,  
        pinchGesture:true  
    });  
  
    // callback on rotation gesture.  
    image.addEventListener('rotate', function(e){  
        e.rotation; // this is rotation angle(radian)  
        e.velocity; // this is gesture speed  
    });  
  
    // callback on rotation gesture finished.  
    image.addEventListner('rotateend', function(e){  
    });  
  
    // callback on pinch gesture.  
    image.addEventListener('pinch', function(e){  
        e.scale; // this is scale  
        e.velocity; // this is gesture speed  
    });  
  
    // callback on pinch gesture finished.  
    image.addEventListener('pinchend', function(e){  
    });  

## Author

KATAOKA,Atsushi `<atsushi.kataoka@msmc.jp>`

## License

MIT License
