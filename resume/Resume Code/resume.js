async function updateCounter() {
    const res = await fetch("https://vastagonresumecountapi.azurewebsites.net/api/UpdateVisitCount?code=vkWbdknVU5eE-hHjIGv3-_SYny77exqri0dlogICMPJFAzFuXX7YCg==", {
        method: "POST"
    })
    const data = await res.json()
    const count = data[0].count

    document.getElementById("visit-count").innerText = `Visit count: ${count}`
}

updateCounter()


