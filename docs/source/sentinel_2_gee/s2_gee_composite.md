# Composite

Reducers are the way to aggregate data over time, space, bands, arrays and other data structures in Earth Engine. The `ee.Reducer` class specifies how data is aggregated. The reducers in this class can specify a simple statistic to use for the aggregation (e.g. minimum, maximum, mean, median, standard deviation, etc.), or a more complex summary of the input data (e.g. histogram, linear regression, list).

Reductions may occur over :
- **time (`imageCollection.reduce()`),**
- space (`image.reduceRegion()`, `image.reduceNeighborhood()`),
- bands (`image.reduce()`),
- attribute space of a `FeatureCollection`** (`featureCollection.reduceColumns()` or `FeatureCollection` methods that start with `aggregate_`).


Consider the example of needing to take the median over a time series of images represented by an `ImageCollection`. To reduce an `ImageCollection`, use `imageCollection.reduce()`. This reduces the collection of images to an individual image. Specifically, the output is computed pixel-wise, such that each pixel in the output is composed of the median value of all the images in the collection at that location. To get other statistics, such as mean, sum, variance, an arbitrary percentile, etc., the appropriate reducer should be selected and applied.

```{note}
For basic statistics like min, max, mean, etc., `ImageCollection` has shortcut methods like `min()`, `max()`, `mean()`, etc. They function in exactly the same way as calling `reduce()`, except the resultant band names will not have the name of the reducer appended.
```

**To composite images in an `ImageCollection`, use `imageCollection.reduce()`. This will composite all the images in the collection to a single image representing, for example, the min, max, mean or standard deviation of the images.**


![reducer](Reduce_ImageCollection.png)


```js
var s2_composite_cloudsProba = s2_mask_cloudsProba
                                .median()
                                .clip(wallonia)
                    
var s2_composite_cloudsQA = s2_mask_cloudsQA
                             .median()
                             .clip(wallonia)
```

## Visualization

```js
var visParams = {
  bands: ['B4','B3','B2'],
  min: 0.0,
  max: 0.3,
};
```

```js
Map.centerObject(wallonia, 8)

Map.addLayer(s2_composite_cloudsProba, visParams, 'S2 SR masked QA60')
Map.addLayer(s2_composite_cloudsQA, visParams, 'S2 SR masked at ' + MAX_CLOUD_PROBABILITY + '%',true)

```

## Exportation to Google Drive


```js
// Get projection of the original image
var projection = s2_filter.first().projection().getInfo()

// Export the image, specifying the CRS, transform, and region.
Export.image.toDrive({
  image: s2_composite_cloudsProba,
  description: 'S2_2019_median_composite',
  folder: 'LBRAT2104',
  crs: projection.crs,                // The base coordinate reference system of this projection (e.g. 'EPSG:4326')
  crsTransform: projection.transform, // The transform between projected coordinates and the base coordinate system
  region: wallonia
});
```

> Composite images created by reducing an image collection are able to produce pixels in any requested projection and therefore have no fixed output projection. Instead, composites have the default projection of WGS-84 with 1-degree resolution pixels. Composites with the default projection will be computed in whatever output projection is requested. A request occurs by displaying the composite in the Code Editor or by explicitly specifying a projection/scale as in an aggregation such as `ReduceRegion` or `Export`.
