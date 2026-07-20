import { useState } from "react";

function Contact() {
    const [name, setName] = useState("");
    const [email, setEmail] = useState("");
    const [message, setMessage] = useState("");

    const handleSubmit = (event) => {
        event.preventDefault();

        alert("Message sent successfully!");

        setName("");
        setEmail("");
        setMessage("");
    };

    return (
        <div className="page-container">
            <div className="contact-card">
                <h1>Contact Us</h1>

                <p>
                    Have any questions or feedback? Send us a message.
                </p>

                <form onSubmit={handleSubmit}>
                    <div className="form-group">
                        <label>Name</label>

                        <input
                            type="text"
                            value={name}
                            onChange={(event) =>
                                setName(event.target.value)
                            }
                            required
                        />
                    </div>

                    <div className="form-group">
                        <label>Email</label>

                        <input
                            type="email"
                            value={email}
                            onChange={(event) =>
                                setEmail(event.target.value)
                            }
                            required
                        />
                    </div>

                    <div className="form-group">
                        <label>Message</label>

                        <textarea
                            value={message}
                            onChange={(event) =>
                                setMessage(event.target.value)
                            }
                            required
                        />
                    </div>

                    <button
                        type="submit"
                        className="send-button"
                    >
                        Send Message
                    </button>
                </form>
            </div>
        </div>
    );
}

export default Contact;