// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.


// open a single window
var window = Ti.UI.createWindow({
});

var image = Ti.UI.createImageView({
    image:"lena_std.jpg",
    rotateGesture:true,
    pinchGesture:true
});
var lastAngle = 0.0;
var currentAngle = 0.0;

var lastScale = 1.0;
var currentScale = 1.0;

image.addEventListener('rotate', function(e){
    currentAngle = e.rotation / Math.PI * 180.0;
    image.transform = Ti.UI.create2DMatrix()
        .scale(lastScale*currentScale)
        .rotate(lastAngle+currentAngle);
});

image.addEventListener('rotateend', function(e){
    lastAngle = (lastAngle + currentAngle) % 360.0;
    currentAngle = 0.0;
});

image.addEventListener('pinch', function(e){
    currentScale = e.scale;
    image.transform = Ti.UI.create2DMatrix()
        .scale(lastScale*currentScale)
        .rotate(lastAngle+currentAngle);
});

image.addEventListener('pinchend', function(e){
    lastScale = (lastScale * currentScale);
    currentScale = 1.0;
});

window.add(image);
window.open();

