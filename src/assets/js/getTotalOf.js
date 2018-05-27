export default function(activities, field) {
  return activities.reduce((total, act) => {
    return total + Number(act[field])
  }, 0)
}
