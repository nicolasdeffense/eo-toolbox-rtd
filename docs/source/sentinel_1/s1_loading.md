# Load Sentinel-1 GRD

The Sentinel-1 mission provides data from a dual-polarization C-band Synthetic Aperture Radar (SAR) instrument at 5.405GHz (C band). This collection includes the S1 Ground Range Detected (GRD) scenes, processed using the Sentinel-1 Toolbox to generate a calibrated, ortho-corrected product. The collection is updated daily. New assets are ingested within two days after they become available.

```js
// Load Sentinel-1 GRD

var sentinel_1 = ee.ImageCollection("COPERNICUS/S1_GRD")
```

Earth Engine uses the following preprocessing steps (as implemented by the Sentinel-1 Toolbox) to derive the backscatter coefficient in each pixel ([source](https://developers.google.com/earth-engine/guides/sentinel1)) :

1. Apply orbit file
    - Updates orbit metadata with a restituted orbit file (or a precise orbit file if the restituted one is not available).
2. GRD border noise removal
    - Removes low intensity noise and invalid data on scene edges.
3. Thermal noise removal
    - Removes additive noise in sub-swaths to help reduce discontinuities between sub-swaths for scenes in multi-swath acquisition modes.
4. Radiometric calibration
    - Computes backscatter intensity using sensor calibration parameters in the GRD metadata.
5. Terrain correction (orthorectification) 
    - Converts data from ground range geometry, which does not take terrain into account, to σ° using the SRTM 30 meter DEM or the ASTER DEM for high latitudes (greater than 60° or less than -60°).
6. Converstion to dB
    - The final terrain-corrected values are converted to decibels via log scaling (10*log10(x)) because it can vary by several orders of magnitude?

```{note}
- Radiometric Terrain Flattening is not being applied due to artifacts on mountain slopes.  
- Sentinel-1 SLC data cannot currently be ingested, as Earth Engine does not support images with complex values due to inability to average them during pyramiding without losing phase information.
```

For more information about these pre-processing steps, please refer to the [Sentinel-1 Pre-processing article](https://developers.google.com/earth-engine/guides/sentinel1). For further advice on working with Sentinel-1 imagery, see [Guido Lemoine's tutorial](https://developers.google.com/earth-engine/tutorials/community/sar-basics) on SAR basics and [Mort Canty's tutorial](https://developers.google.com/earth-engine/tutorials/community/detecting-changes-in-sentinel-1-imagery-pt-1) on SAR change detection.

## Filter Sentinel-1 data

```js
// Define time period, polarisation and orbit direction
var startDate = '2019-01-01'
var endDate   = '2019-12-31'

var polarisation   = 'VV'
var orbitDirection = 'DESCENDING'
var instrument     = 'IW'
```

```js
var roi = ee.FeatureCollection("users/nicolasdeffense/extent_roi_32631")
```

```js
// Select S1 IW images in area of interest and time period
var s1_filter = sentinel_1
                .filter(ee.Filter.eq('instrumentMode', instrument))
                .filter(ee.Filter.listContains('transmitterReceiverPolarisation', polarisation))
                .select(polarisation)
                .filter(ee.Filter.eq('orbitProperties_pass', orbitDirection))
                .filterDate(startDate, endDate)
                .filterBounds(roi)
```