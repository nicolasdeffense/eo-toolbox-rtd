# Cloud Mask

<p>Clouds can be removed by using the Sentinel-2 QA band
or the <a href="/earth-engine/datasets/catalog/COPERNICUS_S2_CLOUD_PROBABILITY">COPERNICUS/S2_CLOUD_PROBABILITY</a>.

## Mask clouds using the Sentinel-2 QA band


<section class="expandable">
<p class="showalways">Bitmask for QA60</p>
<ul>
<li> Bits 0-9: Unused
<ul>
</ul>
</li>
<li> Bit 10: Opaque clouds
<ul>
<li>0: No opaque clouds</li>
<li>1: Opaque clouds present</li>
</ul>
</li>
<li> Bit 11: Cirrus clouds
<ul>
<li>0: No cirrus clouds</li>
<li>1: Cirrus clouds present</li>
</ul>
</li>
</ul>
</section>

[More info](https://developers.google.com/earth-engine/datasets/catalog/COPERNICUS_S2_SR_HARMONIZED#bands)


```js
function maskS2cloudsQA(image) {
  var qa = image.select('QA60')
  
  // Bits 10 and 11 are clouds and cirrus, respectively.
  var cloudBitMask = 1 << 10
  var cirrusBitMask = 1 << 11
  
  // Both flags should be set to zero, indicating clear conditions.
  var cloud  = qa.bitwiseAnd(cloudBitMask).eq(0)
  var cirrus = qa.bitwiseAnd(cirrusBitMask).eq(0)
  var mask = cloud
              .and(cirrus)
  
  var maskedImage = image.updateMask(mask).divide(10000);
  return maskedImage
}
```

```js
var s2_mask_cloudsQA = s2_filter
                           .map(maskS2cloudsQA)
```

## Mask clouds using the Sentinel-2 cloud probability

The S2 cloud probability is created with the sentinel2-cloud-detector library (using LightGBM). All bands are upsampled using bilinear interpolation to 10m resolution before the gradient boost base algorithm is applied. The resulting 0..1 floating point probability is scaled to 0..100 and stored as a UINT8. Areas missing any or all of the bands are masked out. Higher values are more likely to be clouds or highly reflective surfaces (e.g. roof tops or snow).


| Name | Min  | Max | Pixel Size | Description |
|----------|:----------: |:----------:|:---------: | :--------:|
| `probability` | 0 | 100 | 10 meters | Probability that the pixel is cloudy. |


[More info](https://developers.google.com/earth-engine/datasets/catalog/COPERNICUS_S2_CLOUD_PROBABILITY#description)

```js
var s2_cloudsProba = ee.ImageCollection('COPERNICUS/S2_CLOUD_PROBABILITY')

var MAX_CLOUD_PROBABILITY = 65

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
                        image.select('B8A').mask()
                             .updateMask(image.select('B9').mask()))
  return maskedImage
}
```

```js
// Join S2 SR with cloud probability dataset to add cloud mask.
var s2SrWithCloudMask = ee.Join.saveFirst('cloud_mask').apply({
  primary: s2_filter.map(maskS2Edges),
  secondary: s2_cloudsProba_filter,
  condition:
      ee.Filter.equals({leftField: 'system:index', rightField: 'system:index'})
});

var s2_mask_cloudsProba = ee.ImageCollection(s2SrWithCloudMask)
                              .map(maskS2cloudsProba)
```