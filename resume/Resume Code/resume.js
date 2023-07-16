async function updateCounter() {
    const res = await fetch("https://testvastagon.azurewebsites.net/api/UpdateVisitCount?code=uifBbZ-fr_caR0rmfq2omVvHQfPcSs__w2V_IsU7FCWJAzFuT77olw==", {
        method: "POST"
    })
    const data = await res.json()
    const count = data[0].count

    document.getElementById("visit-count").innerText = `Visit count: ${count}`
}

updateCounter()


