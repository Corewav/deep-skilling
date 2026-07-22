import styles from "./CohortDetails.module.css";

function CohortDetails() {
    const cohort = {
        name: "React JS",
        startDate: "01/07/2026",
        endDate: "31/07/2026",
        status: "ongoing"
    };

    return (
        <div className={styles.box}>
            <h1>Cohort Details</h1>

            <dl>
                <dt>Name</dt>
                <dd>{cohort.name}</dd>

                <dt>Start Date</dt>
                <dd>{cohort.startDate}</dd>

                <dt>End Date</dt>
                <dd>{cohort.endDate}</dd>

                <dt>Status</dt>
                <dd
                    className={
                        cohort.status === "ongoing"
                            ? styles.ongoing
                            : styles.completed
                    }
                >
                    {cohort.status}
                </dd>
            </dl>
        </div>
    );
}

export default CohortDetails;