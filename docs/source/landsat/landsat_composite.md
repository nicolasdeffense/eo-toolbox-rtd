# Composites

## Single period composite


```js
var l8_composite = l8_filter
                  .map(maskClouds)
                  .median()
```

## Multiple period composites

```js
// List of months
var months = ee.List.sequence(1, 12)
print("Months : ",months)

// List of years
var years = ee.List.sequence(2019, 2019)
print("Years : ",years)

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