document.addEventListener("DOMContentLoaded", () => {
    fetch("event_result.php")
        .then(res => res.json())
        .then(data => {
            renderScoreboard(data);
            calculateIndividualChampions(data);
            calculateIndividualChampionsStrict(data);
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
            <td>${String(i + 1).padStart(2, "0")}</td>
            <td>${label}</td>
            <td>${score}</td>
        </tr>
    `).join("");
};

const calculateIndividualChampions = (data) => {
    const individuals = {};

    data.forEach(({ Roll_Number, Name, Gender, Score, Degree, Year }) => {
        if (!Gender || !Roll_Number) return;

        if (!individuals[Gender]) individuals[Gender] = {};

        if (!individuals[Gender][Roll_Number]) {
            individuals[Gender][Roll_Number] = {
                name: Name,
                total: 0,
                degree: Degree,
                year: Year
            };
        }

        individuals[Gender][Roll_Number].total += parseInt(Score) || 0;
    });

    const titles = {
        Male: "Kalaprathibha",
        Female: "Kalathilakam"
    };

    const rows = Object.entries(titles).map(([gender, title]) => {
        const group = individuals[gender];
        if (!group) return '';

        const [roll, { name, total, degree, year }] = Object.entries(group)
            .sort(([, a], [, b]) => b.total - a.total)[0];

        return `
            <tr>
                <td>${title}</td>
                <td>${name}</td>
                <td>${roll}</td>
                <td>${degree} ${year} Year</td>
                <td>${total}</td>
            </tr>
        `;
    });

    document.getElementById("champion").innerHTML = rows.join("");
};

const calculateIndividualChampionsStrict = (data) => {
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

    const filtered = Object.entries(participants)
        .filter(([, p]) => p.stages.has("on") && p.stages.has("off"));

    const winners = { Male: null, Female: null };

    filtered.forEach(([roll, data]) => {
        const { gender, total } = data;
        if (!winners[gender] || total > winners[gender].total) {
            winners[gender] = { ...data, roll };
        }
    });

    const titles = {
        Male: "Kalaprathibha",
        Female: "Kalathilakam"
    };

    const rows = Object.entries(winners).map(([gender, champ]) => {
        if (!champ) return '';
        return `
            <tr>
                <td>${titles[gender]}</td>
                <td>${champ.name}</td>
                <td>${champ.roll}</td>
                <td>${champ.degree} ${champ.year} Year</td>
                <td>${champ.total}</td>
            </tr>
        `;
    });

    document.getElementById("champion_strict").innerHTML = rows.join("");
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
