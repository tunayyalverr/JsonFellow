
# JsonFellow

The library is for;
- save json data to use as mock
- read mock json data
- decode json data to expected object

## Usage

#### save json

```
  JsonFellow.save(json: json, withName: "fileName")
```

| Parametre | Tip     | Açıklama                |
| :-------- | :------- | :------------------------- |
| `json` | `String` | json |
| `withName` | `String` | file name |

#### get data

```
  JsonFellow.dataFrom("path", .locale)
```

| Parametre | Tip     | Açıklama                       |
| :-------- | :------- | :-------------------------------- |
| `path`     | `String`   | json path |
| `withType` | `PathType` | json path type (locale or document) |

#### make object with data
```
  JsonFellow.makeObject(Object.self, data)
```

| Parametre | Tip     | Açıklama                       |
| :-------- | :------- | :-------------------------------- |
| `object` | `T `   | expected object to return from data |
| `data`   | `Data` | data which has expected object |

#### make object with path

```
  JsonFellow.make(Object.self, "mockDataName")
```

| Parametre | Tip     | Açıklama                       |
| :-------- | :------- | :-------------------------------- |
| `object`   | `T `      | expected object to return from data |
| `path`     | `String`  | data which has expected object |
| `withType` | `PathType`| json path type (locale or document) |
