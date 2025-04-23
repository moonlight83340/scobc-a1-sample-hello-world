# scobc-a1-sample-hello-world
Unofficial SC-boards sample repository. This repository is for test only.

## Init the repository
```
west init -l .
west update
```

## Build the sample
```
west build -p always -b scsat1_main . -DBOARD_ROOT=../sc-boards
```

## Flash the sample
```
west flash
```

