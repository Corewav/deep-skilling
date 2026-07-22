function IndianPlayers() {
    const IndianPlayers = [
        "Sachin Tendulkar",
        "Virat Kohli",
        "MS Dhoni",
        "Rohit Sharma",
        "Jasprit Bumrah"
    ];

    const [first, second, third, fourth, fifth] =
        IndianPlayers;

    const T20players = [
        "Suryakumar Yadav",
        "Hardik Pandya"
    ];

    const RanjiTrophyplayers = [
        "Ajinkya Rahane",
        "Cheteshwar Pujara"
    ];

    const allPlayers = [
        ...T20players,
        ...RanjiTrophyplayers
    ];

    return (
        <div className="section">
            <h2>Indian Players</h2>

            <h3>Destructured Players</h3>

            <p>{first}</p>
            <p>{second}</p>
            <p>{third}</p>
            <p>{fourth}</p>
            <p>{fifth}</p>

            <h3>T20 and Ranji Trophy Players</h3>

            {allPlayers.map((player, index) => (
                <p key={index}>{player}</p>
            ))}
        </div>
    );
}

export default IndianPlayers;