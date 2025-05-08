
document.addEventListener("DOMContentLoaded", () => {
    fetch("event_result.php")
        .then(res => res.json())
        .then(data => {
            renderScoreboard(data);
            findTop5MaleChampions(data);
            findTop5FemaleChampions(data);
            topOnStagePerformers(data);
            topOffStagePerformers(data);
        })
        .catch(err => console.error("Error fetching data:", err));
});


const renderScoreboard = (data) => {
    const scores = {};

    data.forEach(({ Degree, Year, Score }) => {
        const key = Degree === "Msc" ? "Msc" : `${Degree} ${Year}`;
        scores[key] = (scores[key] || 0) + (parseInt(Score) || 0);
    });

    const sortedScores = Object.entries(scores)
        .sort((a, b) => b[1] - a[1])
        .slice(0, 3);

    const tbody = document.querySelector("#scoreboard tbody");
    tbody.innerHTML = sortedScores.map(([label, score], i) => `
        <tr>
            <td>${label}</td>
            <td>${score}</td>
        </tr>
    `).join("");
};


const getEligibleParticipants = (data) => {
    const participants = {};

    data.forEach(({ Roll_Number, Name, Gender, Score, event_Type, stage, Degree, Year }) => {
        if (event_Type !== "individual") return;
        if (!Roll_Number || !Gender || !stage) return;

        if (!participants[Roll_Number]) {
            participants[Roll_Number] = {
                name: Name,
                gender: Gender,
                total: 0,
                stages: new Set(),
                degree: Degree,
                year: Year
            };
        }

        participants[Roll_Number].total += parseInt(Score) || 0;
        participants[Roll_Number].stages.add(stage);
    });

    return Object.entries(participants)
        .filter(([, p]) => p.stages.has("on") || p.stages.has("off"))
        .map(([roll, p]) => ({ ...p, roll }));
};

// Function to get the top 5 male champions
const findTop5MaleChampions = (data) => {
    const eligible = getEligibleParticipants(data);
    const males = eligible.filter(p => p.gender === "Male");

    // Sort by total score in descending order and get top 5
    const topMales = males.sort((a, b) => b.total - a.total).slice(0, 5);

    const rows = topMales.map(male => `
        <tr>
            <td>${male.name}</td>
            <td>${male.roll}</td>
            <td>${male.degree} ${male.year} Year</td>
            <td>${male.total}</td>
        </tr>
    `).join('');

    document.getElementById("champion").innerHTML = rows;
};

// Function to get the top 5 female champions
const findTop5FemaleChampions = (data) => {
    const eligible = getEligibleParticipants(data);
    const females = eligible.filter(p => p.gender === "Female");

    // Sort by total score in descending order and get top 5
    const topFemales = females.sort((a, b) => b.total - a.total).slice(0, 5);

    const rows = topFemales.map(female => `
        <tr>
            <td>${female.name}</td>
            <td>${female.roll}</td>
            <td>${female.degree} ${female.year} Year</td>
            <td>${female.total}</td>
        </tr>
    `).join('');

    document.getElementById("champion_strict").innerHTML = rows;
};



const topOnStagePerformers = (data) => {
    const participants = {};

    data.forEach(({ Roll_Number, Name, Score, stage, Degree, Year }) => {
        if (stage !== "on" || !Roll_Number) return;

        if (!participants[Roll_Number]) {
            participants[Roll_Number] = {
                name: Name,
                total: 0,
                degree: Degree,
                year: Year
            };
        }

        participants[Roll_Number].total += parseInt(Score) || 0;
    });

    const medals = ["01", "02", "03"];

    const top = Object.entries(participants)
        .sort(([, a], [, b]) => b.total - a.total)
        .slice(0, 3);

    const rows = top.map(([roll, { name, total, degree, year }], i) => `
        <tr>
            <td>${medals[i]}</td>
            <td>${name}</td>
            <td>${roll}</td>
            <td>${degree} ${year} Year</td>
            <td>${total}</td>
        </tr>
    `);

    document.getElementById("top_on_stage").innerHTML = rows.join("");
};



const topOffStagePerformers = (data) => {
    const participants = {};

    data.forEach(({ Roll_Number, Name, Score, stage, Degree, Year }) => {
        if (stage !== "off" || !Roll_Number) return;

        if (!participants[Roll_Number]) {
            participants[Roll_Number] = {
                name: Name,
                total: 0,
                degree: Degree,
                year: Year
            };
        }

        participants[Roll_Number].total += parseInt(Score) || 0;
    });

    const medals = ["01", "02", "03"];

    const top = Object.entries(participants)
        .sort(([, a], [, b]) => b.total - a.total)
        .slice(0, 3);

    const rows = top.map(([roll, { name, total, degree, year }], i) => `
        <tr>
            <td>${medals[i]}</td>
            <td>${name}</td>
            <td>${roll}</td>
            <td>${degree} ${year} Year</td>
            <td>${total}</td>
        </tr>
    `);

    document.getElementById("top_off_stage").innerHTML = rows.join("");
};
