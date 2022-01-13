import React, { useState, useRef, useEffect, memo } from 'react';
import axios from 'axios';
import {
    useParams,
    useNavigate, Link
} from "react-router-dom";
import YouTube from 'react-youtube';
import Collapsible from '../../components/Collapsible/Collapsible';
import './Learn.css'
import moment from 'moment';
import My404 from '../My404/My404'
import { ListCourse } from '../../Data.js'
axios.defaults.withCredentials = true
const ThisUserID = new URLSearchParams(document.cookie.replaceAll("; ", "&")).get('StudyMate');
export default memo(function Learn({ LearnData, Admin, User }) {
    const [pending, setPending] = useState(true);
    const { course, lesson } = useParams();
    const { feature, id, subid } = useParams();
    const [dataLearning, setData] = useState({});
    const [comments, setComments] = useState([]);
    const [videoid, setVideoID] = useState('');
    const onClickRepl = (index, parentindex, repl, parent) => {
        console.log(parent)
        const newcomments = [...comments];
        if (repl) {
            const sub_comment = newcomments[parentindex]['SubComments'][index + 1];
            if (!sub_comment || !sub_comment['thisuser'])
                newcomments[parentindex]['SubComments'].splice(index + 1, 0, { thisuser: true, parent_comment: parent })
        } else if (!newcomments[index]['SubComments'][0] || !newcomments[index]['SubComments'][0]['thisuser']) {
            newcomments[index]['SubComments'].splice(0, 0, { thisuser: true, parent_comment: parent })
        }
        setComments(newcomments);
    }
    const onClickCancel = (index, parentindex) => {
        const newcomments = [...comments];
        newcomments[parentindex]['SubComments'].splice(index, 1)
        setComments(newcomments);

    }
    const _onReady = (e) => {
        console.log(e);
    }
    const opts = {
        playerVars: {
            // https://developers.google.com/youtube/player_parameters
            host: 'https://www.youtube.com',
        },
    };
    function youtube_id(url) {
        var regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#&?]*).*/;
        var match = url.match(regExp);
        return (match && match[7].length == 11) ? match[7] : false;
    }
    const msecToTime = ms => {
        const seconds = Math.floor((ms / 1000) % 60)
        const minutes = Math.floor((ms / (60 * 1000)) % 60)
        const hours = Math.floor((ms / (3600 * 1000)) % 3600)
        return `${hours < 10 ? '0' + hours : hours}:${minutes < 10 ? '0' + minutes : minutes}:${seconds < 10 ? '0' + seconds : seconds
            }`
    }
    const navigate = useNavigate();
    useEffect(async () => {
        try {
            const Tcourse = course ?? id;
            const Tlesson = lesson ?? subid;


            if (!LearnData) {
                const res = await axios.get(`https://localhost:7074/Course/get-learn/${Tcourse}/${Tlesson}`)
                console.log(res)
                if (res.data.status == 201) {
                    navigate('/404')
                }
                if (!Admin) {
                    if (res.data.message.lastlessonlearnt == -1) {
                        navigate(`/learn/${Tcourse}/${res.data.message.listlearn[0].lesson[0].lesson_id}`)
                    } else if (!lesson) {
                        navigate(`/learn/${Tcourse}/${res.data.message.lastlessonlearnt + 1}`)
                    } else {
                        navigate(`/learn/${Tcourse}/${Tlesson}`)
                    }
                } else {
                    navigate(`/admin/${feature}/learn/${Tcourse}/${Tlesson}`)

                }

                setPending(false)
                setData(res.data.message)
                setVideoID(youtube_id(res.data.message.learningurl))
            } else if (LearnData && LearnData.learningurl) {
                setPending(false)
                setData(LearnData)
                setVideoID(youtube_id(LearnData.learningurl))
            }


        } catch (error) {
            console.log(error)
        }
    }, [LearnData])
    const showComment = async () => {
        if (feature != 'approval') {
            try {
                const res = await axios.post(`https://localhost:7074/comment/get-comments`, { lesson_id: lesson || subid });
                console.log(res)
                setComments(res.data.message)
            } catch (error) {
                console.log(error)
            }
        }

    }
    useEffect(() => {
        if (lesson || subid) {
            showComment();
        }
    }, [lesson, subid])
    const handleLesson = (lesson_url, lesson_id, status) => {
        let url = '/learn/';
        if (Admin) {
            url = `/admin/${feature}/learn/`
        }
        if (status != 'block-item') {
            const Tcourse = course ?? id;
            navigate(`${url}${Tcourse}/${lesson_id}`)
            setVideoID(youtube_id(lesson_url))
        }
    }
    let TimerId = 0;
    const handleVideoPlaying = async (e) => {
        if (e.data == 1 && !Admin && ThisUserID != dataLearning.author) {
            TimerId = setInterval(() => {
                if (e.target.getCurrentTime() / e.target.getDuration() > 0.8) {
                    if (dataLearning.lastlessonlearnt + 1 == lesson || dataLearning.lastlessonlearnt == -1) {
                        // var url = dataLearning.listlearn.map(e => {
                        //     var t = e.Lesson.filter(r => (r.LESSON_ID == 1116))
                        //     if (t.length > 0) return t
                        // }).filter(c => c)[0][0].LESSON_URL
                        setData({ ...dataLearning, lastlessonlearnt: parseInt(lesson) })
                        axios.post('https://localhost:7074/course/add-learn', { lesson_id: parseInt(lesson) }).then((e) => { console.log(e) })
                    }
                    clearInterval(TimerId)
                }
                console.log(TimerId)
            }, 1000)

        } else {
            clearInterval(TimerId)
        }
    }
    var status = '';
    return (!pending && <>

        <div id="left-learning">
            <div className="breadcrumb">
                <Link className="breadcrumb-item" to="/"><i className="fas fa-home"></i></Link>
                <Link className="breadcrumb-item" to={`/list-course/${dataLearning.coursemaintype && dataLearning.coursemaintype.course_maintype_id}`}>{dataLearning.coursemaintype && dataLearning.coursemaintype.type_name}</Link>
                <Link className="breadcrumb-item" to={`/list-course/null/${dataLearning.coursetype && dataLearning.coursetype.course_subtype_id}`}>{dataLearning.coursetype && dataLearning.coursetype.type_name}</Link>
                <span className="breadcrumb-item active">{dataLearning.coursetitle}</span>
            </div>
            <div className="video-learning">
                <YouTube opts={opts} videoId={videoid} onReady={_onReady} onStateChange={handleVideoPlaying} />
            </div>
            <div className="info-learning">
                <div className="container">
                    <div className="info-learning-content">
                        <div className="tabs-bar">
                            <div className="tab-item selected-tab">Trao đổi</div>

                        </div>
                        <div className="info-learning-comment">
                            <UserComment User={User} updateComment={showComment} />
                            <div className="person-comment-block">
                                <ul>
                                    {comments.map((item, index) => {
                                        return (
                                            <li key={index}>
                                                <Comment key={index} User={item.user} index={index} Content={item.content}
                                                    parentComment={item.commentid} UsersVoted={item.usersvoted} Time={item.commenttime}
                                                    handleRepl={onClickRepl}
                                                    commentID={item.commentid} updateComment={showComment} />
                                                {item.subcomments.map((item2, index2) => {
                                                    if (item2.thisuser) {
                                                        return (<UserComment key={index2} parent_index={index} updateComment={showComment} User={User}
                                                            index={index2} repl parentComment={item2.parent_comment} handleCancel={onClickCancel} />);
                                                    } else {
                                                        return (
                                                            <Comment parent_index={index} index={index2} key={index2} parentComment={item.commentid}
                                                                UsersVoted={item2.usersvoted} updateComment={showComment} Time={item.commenttime}
                                                                repl User={item2.user} Content={item2.content} handleRepl={onClickRepl}
                                                                commentID={item2.commentid} />
                                                        );
                                                    }
                                                })}
                                            </li>
                                        );

                                    })}
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <div id="right-learning">
            <RightHeader learnt={dataLearning.listlearn && dataLearning.listlearn.reduce((a, b) => a + b.lesson.filter(e => e.lesson_id <= dataLearning.lastlessonlearnt).length, 0)}
                totalLesson={dataLearning.listlearn && dataLearning.listlearn.reduce((a, b) => a + b.lesson.length, 0)}
                title={dataLearning.listlearn && dataLearning.coursetitle} />
            {dataLearning.listlearn && dataLearning.listlearn.map((item, index) => {
                return (
                    <Collapsible className="playlist-wrapper" key={index}>
                        <Chapter learnt={item.lesson.filter(e => e.lesson_id <= dataLearning.lastlessonlearnt).length}
                            title={item.chaptertitle} totalLesson={item.lesson.length} Duration={msecToTime(item.lesson.reduce((a, b) => a + b.duration, 0))} />
                        <div className="playlist-wrapper-list">
                            {
                                item.lesson.map((less, index2) => {
                                    if (less.lesson_id == dataLearning.lastlessonlearnt + 1 || (dataLearning.lastlessonlearnt == -1 && less.lesson_id == lesson) || dataLearning.author == ThisUserID || Admin) {
                                        status = 'normal-item'
                                    } else if (less.lesson_id < dataLearning.lastlessonlearnt + 1) {
                                        status = 'learnt-item'
                                    } else if (less.lesson_id > dataLearning.lastlessonlearnt + 1) {
                                        status = 'block-item'
                                    }
                                    if ((!Admin && less.lesson_id == lesson) || less.lesson_id == subid || subid == index2) {
                                        status += ' learning-item'
                                    }
                                    return (
                                        <Lession status={status} handleLesson={handleLesson} lesson_id={less.lesson_id ?? index2} videoURL={less.lesson_url} key={index2} title={less.lesson_name} duration={msecToTime(less.duration)} />
                                    );
                                })}
                        </div>
                    </Collapsible>
                );
            })}
        </div>
    </>);
})

function UserComment(props) {
    const [commentData, setComment] = useState();
    const ClassName = props.repl ? "comment-block comment-block-repl" : "comment-block"
    const { lesson } = useParams();
    const commentRef = useRef()
    useEffect(() => {
        if (props.repl) commentRef.current.focus();
    })
    const handleonPaste = (e) => {
        e.preventDefault();
        var text = (e.originalEvent || e).clipboardData.getData('text/plain');
        document.execCommand("insertHTML", false, text);
    }
    const handleonInput = (e) => {
        if (e.target.innerText != "") {
            commentRef.current.parentNode.classList.add('comment-box')
        } else {
            commentRef.current.parentNode.classList.remove('comment-box')
        }
    }
    const handleKeyDown = (e) => {
        e.target.style.height = 'inherit';
        e.target.style.height = `${e.target.scrollHeight}px`;
        // In case you have a limitation
        // e.target.style.height = `${Math.min(e.target.scrollHeight, limit)}px`;
    }
    const handleOnChange = (e) => {
        setComment(e.target.value);

    }
    const handleSubmit = async () => {
        const data = {
            lesson_id: parseInt(lesson),
            content: commentData,
            parent_comment_id: props.parentComment ? parseInt(props.parentComment) : null,
        };
        setComment('')
        const res = await axios.post('https://localhost:7074/comment/add-comment', data)
        console.log(res)
        if (res.data.status == 200) {
            props.updateComment();
        }

    }
    return (
        <div id="user-comment-block">
            <div className={ClassName}>
                <div className="comment-avt">
                    <img className="CommentBox_myAvatar__3Mi09" src={props.User && props.User.AVATAR_IMG ? `/${props.User.AVATAR_IMG}` : "https://genk.mediacdn.vn/thumb_w/600/2015/screen-shot-2015-07-30-at-2-31-57-pm-1438334096188.png"} alt="Thang Nguyen" />
                </div>
                <div className="comment-content align-items-end">
                    <textarea ref={commentRef} className="comment-input" autoFocus
                        placeholder="Viết gì gì đó đi..." tabIndex="0" dir="ltr" spellCheck="false"
                        autoComplete="off" autoCorrect="off" autoCapitalize="off" onPaste={handleonPaste} onKeyDown={handleKeyDown}
                        onInput={handleonInput} value={commentData} onChange={handleOnChange}></textarea>
                    <div>
                        <button onClick={handleSubmit} className="btn btn-comment">
                            Bình luận
                        </button>
                        {props.repl && <button onClick={() => props.handleCancel(props.index, props.parent_index)}
                            className="btn btn-comment btn-comment-remove">
                            Hủy
                        </button>}
                    </div>
                </div>
            </div>
        </div>
    );
}
function Comment(props) {
    const [vote, setVote] = useState(() => {
        var filter = props.UsersVoted.filter(e => e.user_id == ThisUserID)
        if (filter.length) {
            return { up: filter[0].comment_vote_state == 1, down: filter[0].comment_vote_state == 0 }
        }
        return { up: false, down: false }
    })
    const handleUpVote = () => {
        var data = {
            comment_id: props.commentID,
        }
        if (vote.down && !vote.up) {
            data.comment_state = 1;

        } else {
            data.comment_state = vote.up ? -1 : 1;
        }
        setVote(pre => {
            if (pre.down && !pre.up) {
                return { up: true, down: false }

            } else {
                return { ...pre, up: !pre.up }
            }

        })
        console.log(data)
        axios.post('https://localhost:7074/comment/comment-vote', data).then((r) => {
            console.log(r)
            props.updateComment();
        }).catch(error => console.log(error))
    }
    const handleDownVote = () => {
        var data = {
            comment_id: props.commentID,
        }
        if (!vote.down && vote.up) {
            data.comment_state = 0;

        } else {
            data.comment_state = vote.down ? -1 : 0;
        }
        setVote(pre => {
            if (!pre.down && pre.up) {
                return { up: false, down: true }
            } else {
                return { ...pre, down: !pre.down }
            }

        })
        console.log(data)
        axios.post('https://localhost:7074/comment/comment-vote', data).then((r) => {
            console.log(r)
            props.updateComment();
        }).catch(error => console.log(error))
    }
    const ClassName = props.repl ? "comment-block comment-block-repl" : "comment-block"
    return (
        <div className={ClassName}>
            <div className="comment-avt">
                <img className="CommentBox_myAvatar__3Mi09" src={props.User && props.User.avatar_img ? `/${props.User.avatar_img}` : "https://genk.mediacdn.vn/thumb_w/600/2015/screen-shot-2015-07-30-at-2-31-57-pm-1438334096188.png"} alt={props.User.fullname} />
            </div>
            <div className="comment-content">
                <div className="comment-user-name">
                    <a href="">{props.User.fullname}</a>
                </div>
                <div className="comment-body">{props.Content}</div>
                <div className="comment-footer">
                    <span className="comment-vote">
                        <span className={"upvote " + (vote.up ? "active" : "")}>
                            <span onClick={handleUpVote}>
                                <i className="fas fa-arrow-up font-size-h5 fa-fw"></i>
                            </span>
                            <span>{props.UsersVoted.filter(e => e.comment_vote_state == 1).length}</span>
                        </span>
                        <span className={"downvote " + (vote.down ? "active" : "")}>
                            <span onClick={handleDownVote}>
                                <i className="fas fa-arrow-down font-size-h5 fa-fw"></i>
                            </span>
                            <span>{props.UsersVoted.filter(e => e.comment_vote_state == 0).length}</span>
                        </span>
                    </span>
                    <span onClick={() => { props.handleRepl(props.index, props.parent_index, props.repl, props.parentComment) }} className="comment-repl" href="">Trả lời</span>
                    <span className="comment-datetime">{moment(props.Time).fromNow()}</span>
                </div>
            </div>
        </div>
    );
}
function Chapter(props) {
    return (
        <div className="playplist-wrapper-header">
            <h2 className="wrapper-header-title">{props.title}</h2>
            <p className="wrapper-header-detail">{props.learnt}/{props.totalLesson} | {props.Duration}</p>
        </div>
    );
}
function Lession({ title, duration, handleLesson, videoURL, lesson_id, status }) {
    return (

        <div onClick={() => handleLesson(videoURL, lesson_id, status)} className={"playlist-wrapper-item " + status}>
            <div className="wrapper-icon-status">
                <i className="fas fa-check"></i>
                <i className="fas fa-lock"></i>

            </div>
            <div className="wrapper-item-info">
                <p className="wrapper-item-title">{title}</p>
                <div className="wrapper-item-detail">
                    <i className="far fa-play-circle"></i>
                    <span>{duration}</span>
                </div>
            </div>
        </div>
    );
}
function RightHeader(props) {
    return (
        <header className="playlist-header" style={{ '--process': (props.learnt / props.totalLesson * 100).toFixed(2) + '%' }}>
            <div className="background-process">
            </div>
            <div className="playlist-header-content">
                <h1 className="playlist-title">{props.title}</h1>
                <div className="playlist-info">
                    <p className="playlist-description">
                        Hoàn thành
                        <strong> {props.learnt}</strong>/<strong>{props.totalLesson} </strong>
                        bài học (<strong>{(props.learnt / props.totalLesson * 100).toFixed(2)} %</strong>)
                    </p>
                </div>
            </div>
        </header>
    );
}