export default function(arr, i, n) {
  return arr.reduce((filtered, m) => {
    let num = Number(m)
    if (num >= i) {
      if (!(n === -1 && num === i)) {
        filtered.push(num + n)
      }
    } else {
      filtered.push(num)
    }
    return filtered
  }, [])
}
