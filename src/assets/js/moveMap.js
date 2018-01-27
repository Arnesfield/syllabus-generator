export default function(map, i, n) {
  let newMap = {}
  Object.keys(map).forEach(e => {
    // if is equal to i or more
    // add n
    let m = Number(e)
    // check if n is -1
    // if -1 and m == i, do not include
    if (m >= i) {
      if (!(n === -1 && m === i)) {
        newMap[m + n] = map[e]
      }
    } else {
      // else, retain it and add it to new map
      newMap[e] = map[e]
    }
  })
  return newMap
}
