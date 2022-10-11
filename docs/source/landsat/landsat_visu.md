# Visualization

```js
var visParams = {
  bands: ['SR_B4', 'SR_B3', 'SR_B2'],
  min: 0.0,
  max: 0.3,
}
```

## Single image

```js
Map.centerObject(roi, 8)
Map.addLayer(l8_composite, visParams, 'True Color (432) - Mask - Median')
```

## Image Collection


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