export default function(activities, act, index) {
  // loop from 0 to index-1
  let start = 0
  activities.every((act, i) => {
    if (i < index) {
      start += Number(act.noOfWeeks)
    }
    // continue while
    return i < index
  })

  let end = start + Number(act.noOfWeeks)
  // if difference of start and end is 1, show only end
  return ((end - start === 1) ? '' : (start+1) + '-') + end
}
