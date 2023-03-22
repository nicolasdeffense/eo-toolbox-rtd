# Composite over mulitple time periods

```js
// List of months
var months = ee.List.sequence(1, 12)
print("Months : ",months)

// List of years
var years = ee.List.sequence(2019, 2019)
print("Years : ",years)
```


```js
// Use .map() to compute monthly composite and clip them to the ROI
var monthly_mean = ee.ImageCollection.fromImages(
  years.map(function (y) {
        return months.map(function (m) {
                return s1_filter
                        .filter(ee.Filter.calendarRange(y, y, 'year'))
                        .filter(ee.Filter.calendarRange(m, m, 'month'))
                        .reduce(ee.Reducer.mean())
                        .set('year',y)
                        .set('month',m);
            });
  })
  .flatten())
  .map(function(image){return image.clip(roi)})
```

[Source](https://gis.stackexchange.com/questions/387012/google-earth-engine-calculating-and-plotting-monthly-average-ndvi-for-a-region)

## Visualization

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

// Render the GIF animation in the console.
print(ui.Thumbnail(monthly_mean, videoArgs))

// Print the GIF URL to the console.
print(monthly_mean.getVideoThumbURL(videoArgs))
```


[Source](https://developers.google.com/earth-engine/guides/ic_visualization)


## Export an Image Collection


```js
// Converts a collection to a single multi-band image containing all of the bands of every image in the collection.
var monthly_mean_image = monthly_mean.toBands()

// Get projection of the original image
var projection = s1_filter.first().projection().getInfo()

// Export the image, specifying the CRS, transform, and region.
Export.image.toDrive({
  image: monthly_mean_image,
  description: 'monthly_mean_Namur_2019',
  folder: 'LBRAT2104',
  crs: projection.crs,
  crsTransform: projection.transform,
  region: roi
});
```