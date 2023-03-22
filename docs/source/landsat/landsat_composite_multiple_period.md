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
var l8_monthly_mean = ee.ImageCollection.fromImages(
  years.map(function (y) {
        return months.map(function (m) {
                return l8_filter
                        .filter(ee.Filter.calendarRange(y, y, 'year'))
                        .filter(ee.Filter.calendarRange(m, m, 'month'))
                        .map(maskClouds)
                        .median()
                        .set('year',y)
                        .set('month',m);
            });
  })
  .flatten())
  .map(function(image){return image.clip(roi)})


print("Monthly mean : ",l8_monthly_mean)
```

## Visualization


```js
// Create RGB visualization images for use as animation frames.
var rgbVis = l8_monthly_mean.map(function(img) {
  return img.visualize(visParams);
})

// Define GIF visualization arguments.
var gifParams = {
  region: roi.geometry(),
  dimensions: 1000,
  crs: 'EPSG:3857',
  framesPerSecond: 1,
  format: 'gif'
}

// Print the GIF URL to the console.
print(rgbVis.getVideoThumbURL(gifParams))

// Render the GIF animation in the console.
print(ui.Thumbnail(rgbVis, gifParams))
```

## Export an Image Collection

```js
// Converts a collection to a single multi-band image containing all of the bands of every image in the collection.
var monthly_image = l8_monthly_mean.toBands()

// Get projection of the original image
var projection = l8_filter.first().projection().getInfo()

// Export the image, specifying the CRS, transform, and region.
Export.image.toDrive({
  image: monthly_image,
  description: 'L8_monthly_median_2019',
  folder: 'LBRAT2104',
  crs: projection.crs,
  crsTransform: projection.transform,
  region: roi
});
```