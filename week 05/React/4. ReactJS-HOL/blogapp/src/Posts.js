import React, { Component } from "react";
import Post from "./Post";

class Posts extends Component {
    constructor(props) {
        super(props);

        this.state = {
            posts: [],
            hasError: false
        };
    }

    loadPosts() {
        fetch("https://jsonplaceholder.typicode.com/posts")
            .then((response) => response.json())
            .then((data) => {
                const posts = data.map(
                    (post) =>
                        new Post(
                            post.id,
                            post.title,
                            post.body
                        )
                );

                this.setState({
                    posts: posts
                });
            })
            .catch(() => {
                this.setState({
                    hasError: true
                });
            });
    }

    componentDidMount() {
        this.loadPosts();
    }

    componentDidCatch() {
        this.setState({
            hasError: true
        });
    }

    render() {
        if (this.state.hasError) {
            return <h2>Something went wrong.</h2>;
        }

        return (
            <div className="blog-container">
                <h1>Blog Posts</h1>

                {this.state.posts.map((post) => (
                    <div className="post-card" key={post.id}>
                        <h2>{post.title}</h2>
                        <p>{post.body}</p>
                    </div>
                ))}
            </div>
        );
    }
}

export default Posts;