# OneMap

Swift package with **hand-written `Codable` models** and **typed HTTP request builders** for the Native BL **Maps** API (`v1/maps*`), aligned with MapService.proto and validated against **real server JSON** captures.

The package covers **map display only** — list, image, markers, and geo providers. Edit/admin endpoints (`:change`, `markers:update`, provider configure) are out of scope.

The package does **not** use protobuf code generation. Models follow what the server actually returns, not only what `.proto` declares.

**Platforms:** iOS 15+, macOS 13+, tvOS 17+, visionOS 1+  
**Swift tools:** 6.1+

## Dependencies

| Package | Role in OneMap |
|---------|----------------|
| [RequestResponse](https://github.com/avgx/RequestResponse) | `MapApi` returns `Request<T>` for typed endpoints |
| [OneSecurity](https://github.com/avgx/OneSecurity) | `MapAccess`, `MapViewPolicy`, `MapPolicyEvaluator`; `MapMeta.viewPolicy(for:)` |
| [SafeEnum](https://github.com/avgx/SafeEnum) | Unknown enum wire values decode without failing the payload (e.g. `access`, `sharing.kind`) |
| [OneWireFormat](https://github.com/avgx/OneWireFormat) | Shared wire types where needed |
| [EncodeDecode](https://github.com/avgx/EncodeDecode) | **Tests only** |

## What is included

### API surface (`MapApi`)

| Method | HTTP | Response |
|--------|------|----------|
| `MapApi.list(view:)` | `GET /v1/maps/list` | `ListMapsResponse` |
| `MapApi.batchGet(mapIds:)` | `GET /v1/maps:batchGet` | `BatchGetMapsResponse` |
| `MapApi.getByComponent(_:view:)` | `GET /v1/maps:getByComponent` | `GetMapsByComponentResponse` |
| `MapApi.image(mapId:)` | `GET /v1/maps/image` | `GetMapImageResponse` |
| `MapApi.markers(_:)` | `POST /v1/maps/markers` | `GetMarkersResponse` |
| `MapApi.providers(pageSize:pageToken:)` | `GET /v1/maps/providers` | `ListMapProvidersResponse` |

Optional query `view` uses `MapViewMode` (`VIEW_MODE_ONLY_META`, `VIEW_MODE_FULL`).

### Models

- **`MapFull`** — `{ meta, data }` entry from list/batch/getByComponent responses.
- **`Marker`** — map overlay with optional subtype fields (`camera_marker`, `component_marker`, …).
- **`MapProvider` / `MapType`** — geo map provider configuration.
- **`GetMarkersRequest` / `GetMarkersResponse`** — viewport-filtered marker fetch.

Security types and policy live in **OneSecurity** (`MapAccess`, `MapViewPolicy`).

### Map security policy

```swift
import OneMap
import OneSecurity

let user = SecurityApi.makeContext(from: permissionsResponse)
let policy = map.viewPolicy(for: user)
// policy.canOpen, .canView, .canScale, .canEdit
```

Global gate: when `GlobalPermissions.mapsAccess == .forbid`, the list API may return HTTP error `{ "errorMessage": "Insufficient privileges to get maps list", "grpcErrorCode": 7 }` — handled at the HTTP layer, not as a success model.

## Usage

### List maps

```swift
import OneMap
import RequestResponse
import HTTP

let builder = RequestBuilder.json(baseURL: accountURL, encoder: JSONEncoder())
let response: ListMapsResponse = try await http.send(
    MapApi.list(view: .VIEW_MODE_FULL),
    with: builder
)
let maps = response.items
```

### Raster display flow

1. `MapApi.list` → filter maps with `data.imageMeta != nil`
2. `MapApi.image(mapId:)` → base64 image payload
3. `MapApi.markers(GetMarkersRequest(...))` → camera/component overlays

### Geo display flow

1. `MapApi.list` → maps with `data.type == .geo`
2. `MapApi.providers()` → resolve `provider_id` + `map_type_id` → tile URL / API key

## Module layout

```
Sources/OneMap/
├── API/           MapApi, MapViewMode
├── Enum/          MapTypeKind, SharingKind, PinEdge, DeviceNodeDrawingMode
├── Image/         MapImage, GetMapImageResponse
├── Map/           MapFull, MapMeta, MapData, ListMapsResponse, Map+ViewPolicy
├── Marker/        Marker, MarkerGroup, GetMarkersRequest/Response, subtypes
├── Primitive/     Point, Point3D, ImageSize, Region
└── Provider/      MapProvider, MapType, ListMapProvidersResponse
```

Tests under `Tests/OneMapTests/Decoding/` mirror model folders. Fixtures live in `Tests/OneMapTests/Resources/`.

## Optional fields and wire quirks

Optionality is driven by **fixture diff**, not proto alone:

- `MapData.imageMeta` — optional; raster maps without it are skipped by the webclient for display.
- `MapData.viewpoint`, `iconScale` — optional (absent in older captures).
- `ImageMeta.sizeBytes` — server may send `UInt64`, `Int`, or numeric `String`; decoder accepts all three.
- Marker subtypes — proto `oneof` maps to optional Swift fields on `Marker`.

Unknown JSON keys are ignored (not listed in `CodingKeys`).

## Reference captures

Anonymized fixtures used in tests (no credentials):

| Fixture | Endpoint |
|---------|----------|
| `v1_maps_list_raster.json` | `GET /v1/maps/list` |
| `v1_maps_markers_camera.json` | `POST /v1/maps/markers` |
| `v1_maps_image_meta.json` | `GET /v1/maps/image` (truncated base64) |
| `v1_maps_providers.json` | `GET /v1/maps/providers` |
| `v1_maps_list_forbidden.json` | Error response when maps access is forbidden |

### Adding fixtures from a server

1. Capture JSON from a demo domain (curl or browser devtools).
2. Anonymize IDs, hostnames, credentials, and tokens.
3. Place under `Tests/OneMapTests/Resources/` with `v1_maps_*` naming.
4. Add a decoding test in the matching `Decoding/` folder.
