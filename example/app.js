// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.


// open a single window
var window = Ti.UI.createWindow({
	orientationModes:[
			  Ti.UI.LANDSCAPE_LEFT,
			  Ti.UI.LANDSCAPE_RIGHT,
			  Ti.UI.PORTRAIT,
			  Ti.UI.UPSIDE_PORTRAIT
			 ]
});

var image = Ti.UI.createImageView({
    image:"toby.jpg",
    recognizeSimultaneously:"pinching,rotate",
    rotateGesture:true,
    pinchingGesture:true,
    panGesture:true
});
var lastAngle = 0.0;
var currentAngle = 0.0;

var lastScale = 1.0;
var currentScale = 1.0;

var currentTranslation = {x:0.0, y:0.0};
var lastTranslation = {x:0.0, y:0.0};

function updateTransform(image)
{
    var transform = Ti.UI.create2DMatrix()
		.scale(lastScale*currentScale)
        .rotate(lastAngle+currentAngle);
        
    transform.tx = lastTranslation.x+currentTranslation.x;
    transform.ty = lastTranslation.y+currentTranslation.y;

	image.transform = transform;
};

image.addEventListener('rotate', function(e){
    currentAngle = e.rotation / Math.PI * 180.0;
	updateTransform(image);
});

image.addEventListener('rotateend', function(e){
    lastAngle = (lastAngle + currentAngle) % 360.0;
    currentAngle = 0.0;
});

image.addEventListener('pinching', function(e){
    currentScale = e.scale;
    updateTransform(image);
});

image.addEventListener('pinchingend', function(e){
    lastScale = (lastScale * currentScale);
    currentScale = 1.0;
});

image.addEventListener('pan', function(e){
	currentTranslation.x = e.translation.x;
	currentTranslation.y = e.translation.y;
	updateTransform(image);
});

image.addEventListener('panend', function(e){
    lastTranslation.x = lastTranslation.x + currentTranslation.x;
    lastTranslation.y = lastTranslation.y + currentTranslation.y;
    currentTranslation.x = 0.0;
    currentTranslation.y = 0.0;
});

window.add(image);
window.open();

