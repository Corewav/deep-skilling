function CalculateScore({ name, school, total, goal }) {

    const averageScore = (total / goal) * 100;

    return (
        <div className="score-card">

            <h1>Student Score Calculator</h1>

            <h2>{name}</h2>

            <p>
                <strong>School:</strong> {school}
            </p>

            <p>
                <strong>Total Score:</strong> {total}
            </p>

            <p>
                <strong>Goal:</strong> {goal}
            </p>

            <h3>
                Average Score: {averageScore.toFixed(2)}%
            </h3>

        </div>
    );
}

export default CalculateScore;