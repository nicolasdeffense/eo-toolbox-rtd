# Visualization

## Visualize single image

```js
Map.centerObject(roi, 12)
Map.addLayer(s1_mean, {min: -25, max: 5}, 'yearly mean', true)
Map.addLayer(s1_std, {min: 0, max: 4}, 'yearly std', true)
```

## Visualize imageCollection

### Map layers

```js
var listOfImages = monthly_mean.toList(monthly_mean.size())
print('List:',listOfImages)

// Get the size of the image list
var len = listOfImages.size()

len.evaluate(function(l) {
  for (var i=0; i < l; i++) {
    var img = ee.Image(listOfImages.get(i));
    var month = img.get('month').getInfo();
    var year  = img.get('year').getInfo();
    Map.addLayer(img, {min: -25, max:5}, month.toString() + '/' + year.toString());
  } 
})
```

[Source](https://gis.stackexchange.com/questions/348014/how-to-display-a-large-series-of-images-to-the-map-with-a-for-loop-in-earth-engi)

### GIF

```js
// Define arguments for animation function parameters.
var videoArgs = {
  dimensions: 800,
  region: roi.geometry(),
  framesPerSecond: 1,
  crs: 'EPSG:3857',
  min: -25.0,
  max: 5.0
};

print(ui.Thumbnail(monthly_mean, videoArgs))
print(monthly_mean.getVideoThumbURL(videoArgs))
```


[Source](https://developers.google.com/earth-engine/guides/ic_visualization)

