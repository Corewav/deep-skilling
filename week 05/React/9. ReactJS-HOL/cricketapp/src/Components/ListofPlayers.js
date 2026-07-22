function ListofPlayers() {
    const players = [
        { name: "Sachin Tendulkar", score: 100 },
        { name: "Virat Kohli", score: 85 },
        { name: "MS Dhoni", score: 75 },
        { name: "Rohit Sharma", score: 65 },
        { name: "Hardik Pandya", score: 55 },
        { name: "Jasprit Bumrah", score: 45 },
        { name: "Ravindra Jadeja", score: 70 },
        { name: "Shubman Gill", score: 60 },
        { name: "KL Rahul", score: 80 },
        { name: "Rishabh Pant", score: 50 },
        { name: "Suryakumar Yadav", score: 90 }
    ];

    const below70 = players.filter(
        (player) => player.score < 70
    );

    return (
        <div className="section">
            <h2>List of Players</h2>

            <h3>All Players</h3>

            {players.map((player, index) => (
                <p key={index}>
                    {player.name} - {player.score}
                </p>
            ))}

            <h3>Players with Score Below 70</h3>

            {below70.map((player, index) => (
                <p key={index}>
                    {player.name} - {player.score}
                </p>
            ))}
        </div>
    );
}

export default ListofPlayers;