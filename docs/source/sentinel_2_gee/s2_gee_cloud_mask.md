# Cloud Mask (GEE)


## Mask clouds using the Sentinel-2 QA band

```js
function maskS2clouds(image) {
  var QA = image.select('QA60')
  
  // Bits 10 and 11 are clouds and cirrus, respectively.
  var cloudBitMask = 1 << 10
  var cirrusBitMask = 1 << 11
  
  // Both flags should be set to zero, indicating clear conditions.
  var cloud  = QA.bitwiseAnd(cloudBitMask).eq(0)
  var cirrus = QA.bitwiseAnd(cirrusBitMask).eq(0)
  var mask = cloud
              .and(cirrus)
  
  var maskedImage = image.updateMask(mask).divide(10000);
  return maskedImage
}
```

```js
var s2_maskS2clouds_QA = s2_filter
                           .map(maskS2clouds)
```

## Mask clouds using the Sentinel-2 cloud probability



```js
var s2_cloudsProba = ee.ImageCollection('COPERNICUS/S2_CLOUD_PROBABILITY')

var s2_cloudsProba_filter = s2_cloudsProba
                              .filterDate(startDate, endDate)
                              .filterBounds(wallonia)
```

```js

function maskS2cloudsProba(image) {
  var clouds = ee.Image(image.get('cloud_mask')).select('probability')
  var isNotCloud = clouds.lt(MAX_CLOUD_PROBABILITY)
  
  var maskedImage = image.updateMask(isNotCloud).divide(10000)
  return maskedImage
}
```

```js
// The masks for the 10m bands sometimes do not exclude bad data at
// scene edges, so we apply masks from the 20m and 60m bands as well.
// Example asset that needs this operation:
// COPERNICUS/S2_CLOUD_PROBABILITY/20190301T000239_20190301T000238_T55GDP
function maskS2Edges(image) {
  var maskedImage = image.updateMask(
                        image.select('B8A')
                             .mask()
                             .updateMask(image.select('B9')
                                              .mask()
                                        )
                                      )
  
  return maskedImage
}
```

```js
var MAX_CLOUD_PROBABILITY = 65

// Join S2 SR with cloud probability dataset to add cloud mask.
var s2SrWithCloudMask = ee.Join.saveFirst('cloud_mask').apply({
  primary: s2_filter.map(maskS2Edges),
  secondary: s2_cloudsProba_filter,
  condition:
      ee.Filter.equals({leftField: 'system:index', rightField: 'system:index'})
});

var s2CloudMasked = ee.ImageCollection(s2SrWithCloudMask)
                      .map(maskS2cloudsProba)
```