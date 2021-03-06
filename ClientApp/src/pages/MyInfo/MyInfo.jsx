import React, { useEffect, useState } from 'react';
import axios from 'axios';
import Swal from 'sweetalert2';
import './Myinfo.css';
import moment from 'moment'
function MyInfo({ User }) {

    //const history = useHistory();
    const [userInfo, setUserInfo] = useState({
        fullname: '',
        date_of_birth: "2021-01-01",
        city_id: '',
        phone: '',
        school: '',
        facebook: '',
        linkedln: '',
        bio: '',
    });

    const [password, setPassword] = useState({
        user_id: "",
        currentPassword: "",
        newPassword: "",
        confirmPassword: "",
    });

    const [errorInput, setError] = useState([]);
    // if (!userInfo.name) {

    //     setUserInfo({
    //         username: User.username,
    //         name: User.name,
    //         email: '',
    //         password: '',
    //     })
    // }
    useEffect(() => {
        setUserInfo({ ...User })
        console.log(User);
        // axios.get('/api/myinfo').then(res => {

        //     if (res.data.status === 200) {
        //         console.log(set.data.message);
        //         this.setUserInfo({
        //             name: res.data.user.name,
        //             email: res.data.user.email,
        //         });
        //     }
        //     else if (res.data.status === 404) {
        //         swal("Error", res.data.message, "error");
        //     }
        // });

    }, [User]);

    const handleInput = (e) => {
        setUserInfo({
            ...userInfo,
            [e.target.name]: e.target.value
        });
    }

    const handleDateOfBirthChange = (e) => {
        setUserInfo({
            ...userInfo,
            date_of_birth: e.target.value
        });
    }

    const handleCityChange = (e) => {
        setUserInfo({
            ...userInfo,
            city_id: e.target.value
        });
    }

    const handleSchoolIdChange = (e) => {
        setUserInfo({
            ...userInfo,
            school: e.target.value
        });
    }

    const handleAvatarChange = (e) => {
        let img = e.target.files[0];
        setUserInfo({
            ...userInfo,
            //avatar: e.target.files[0]
            avatar_img: URL.createObjectURL(img)
        });
    }
    const handleBackgroundImgChange = (e) => {
        let img = e.target.files[0];
        setUserInfo({
            ...userInfo,
            background_img: URL.createObjectURL(img)
        });
    }



    const handleUpdateMyInfo = async (e) => {
        try {
            e.preventDefault();

            var fd = new FormData(document.querySelector("#frm-info"))
            fd.append('data', JSON.stringify(userInfo))
            const res = await axios.post('https://localhost:7074/MyInfo/update-myinfo', fd)
            console.log(res);

            if (res.data.status === 200) {
                Swal.fire({
                    text: 'Th??nh c??ng',
                    icon: 'success',
                    confirmButtonText: 'OK'
                })
                setError([]);
                //history.push('/myinfo');
            }
            else if (res.data.status === 422) {
                Swal.fire({
                    text: 'Th???t b???i',
                    icon: 'warning',
                    confirmButtonText: 'Cancel'
                })
                //Swal("All fields are mandetory", "", "error");
                setError(res.data.validationErrors);
            }
            else if (res.data.status === 404) {
                Swal.fire({
                    text: 'Th???t b???i',
                    icon: 'error',
                    confirmButtonText: 'Cancel'
                })
                //Swal("Error", res.data.message, "error");
                //history.push('/myinfo');
            }
        } catch (error) {
            console.log(error.response.data);
        }

    }

    const handleCancle = (e) => {
        setUserInfo({ ...User });
        setError([]);
    }

    //change password
    const handlePasswordChange = (e) => {
        setPassword({
            ...password,
            user_id: User.user_id,
            [e.target.name]: e.target.value
        });
    }

    const handleUpdatePassword = (e) => {
        e.preventDefault();


        if (password.newPassword !== password.confirmPassword) {
            Swal.fire({
                text: 'M???t kh???u kh??ng h???p l???',
                icon: 'warning',
                confirmButtonText: 'Cancel'
            })
        }
        else if (password.newPassword == null || password.newPassword == '') {
            Swal.fire({
                text: 'New password is required!',
                icon: 'warning',
                confirmButtonText: 'Cancel'
            })
        }
        else {
            try {
                axios.put('https://localhost:7074/MyInfo/update-password', password).then(res => {
                    console.log(res);
                    if (res.data.status === 200) {
                        Swal.fire({
                            text: 'Th??nh c??ng',
                            icon: 'success',
                            confirmButtonText: 'OK'
                        })
                        setError([]);
                    }
                    else if (res.data.status === 422) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Oops...',
                            text: res.data.message,
                            confirmButtonText: 'Cancel'
                        })
                        setError(res.data.validationErrors);
                    }
                    else if (res.data.status === 404) {
                        Swal.fire({
                            text: 'Th???t b???i',
                            icon: 'error',
                            confirmButtonText: 'Cancel'
                        })
                    }
                });
            } catch (error) {
                console.log(error.response.data);
            }

        }
    }


    return (<>
        <div className="zone zone-content">
            <div className="container">
                <div className="user--profile">
                    <div className="row">
                        <div className="col-md-3">
                            <div className="user--profile-left">
                                <ul className="user--profile--list-function">
                                    <li className="active"><a href="#">Th??ng tin &amp; li??n h??? </a></li>
                                    {/* <li><a href="#change-userName">?????i t??n ng?????i d??ng </a></li> */}
                                    <li><a href="#change-password">?????i m???t kh???u</a></li>
                                </ul>
                            </div>
                        </div>
                        <div className="col-md-9 user--profile-right-container">
                            <div className="user--profile-right editing">
                                <div className="user--profile-group">
                                    <h2 className="user--profile-title-group">Th??ng tin</h2>
                                    <form id="frm-info" onSubmit={handleUpdateMyInfo}>
                                        <div className="row">

                                            <div className="col-md-6 col-xs-12">
                                                <div className="row myinfo-avt">
                                                    <img id="AvtPreview" src={userInfo.avatar_img ? (userInfo.avatar_img.substring(0, 3) == 'img' ? `/${userInfo.avatar_img}` : `${userInfo.avatar_img}`) : "https://genk.mediacdn.vn/thumb_w/600/2015/screen-shot-2015-07-30-at-2-31-57-pm-1438334096188.png"} className="no-img" />
                                                </div>
                                                <div className="row avatar-selector">
                                                    <div className="form-group UploadAvatar">
                                                        <label style={{ display: 'block' }}>???nh ?????i di???n c???a b???n</label>
                                                        <label htmlFor="Avatar" className="browse btn btn-primary input-sm" type="button" id="Upload-Ava" style={{ display: 'block' }}>Ch???n ???nh</label>
                                                        <input name="avatar_img" id="Avatar" className="file" type="file" onChange={handleAvatarChange} accept="image/png,image/x-png,image/gif,image/jpeg,image/jpg" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div className="col-md-6 col-xs-12">
                                                <div className="row myinfo-background">
                                                    <img id="BackGroundPreview" src={userInfo.background_img ? (userInfo.background_img.substring(0, 3) == 'img' ? `/${userInfo.background_img}` : `${userInfo.background_img}`) : "https://scontent.fsgn5-6.fna.fbcdn.net/v/t1.15752-9/265477733_1261787384297990_7861327918471454977_n.jpg?_nc_cat=106&ccb=1-5&_nc_sid=ae9488&_nc_ohc=TKEOtuPOWaEAX-_NLwH&tn=XQUZnIFZbTB2qDYS&_nc_ht=scontent.fsgn5-6.fna&oh=03_AVKv7IDaMciyI5YV2gu_5w3YZDkUXV98-fgz0iQ5MdWkFQ&oe=61E6E335"} className="no-img" />

                                                </div>
                                                <div className="row avatar-selector">
                                                    <div className="form-group UploadBackground">
                                                        <label style={{ display: 'block' }}>???nh n???n trang user c???a b???n</label>
                                                        <label htmlFor="Background" className="browse btn btn-primary input-sm" type="button" id="Upload-Ava" style={{ display: 'block' }}>Ch???n ???nh</label>
                                                        <input name="background_img" id="Background" className="file" type="file" onChange={handleBackgroundImgChange} accept="image/png,image/x-png,image/gif,image/jpeg,image/jpg" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                        <div className="row">
                                            <div className="col-md-12 ">
                                                <div className="row">
                                                    <div className="col-lg-3 col-sm-4 col-xs-12">
                                                        <div className="form-group">
                                                            <label htmlFor="name" className="required" aria-required="true">H??? v?? T??n</label>
                                                        </div>
                                                    </div>
                                                    <div className="col-lg-9 col-sm-8 col-xs-12">
                                                        <div className="form-group">
                                                            <span id="span-name" className="span-display" style={{ display: "none" }}></span>
                                                            <input name="fullname" type="text" onChange={handleInput} value={userInfo.fullname || ''} className="form-control is-required" id="name" autoComplete="family-name" aria-required="true" style={{ display: 'block' }} />
                                                            <label id="name-error" className="error" htmlFor="name">{errorInput.fullname}</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div className="row">
                                                    <div className="col-lg-3 col-sm-4 col-xs-12">
                                                        <div className="form-group">
                                                            <label htmlFor="BirthYear">Ng??y sinh</label>
                                                        </div>
                                                    </div>
                                                    <div className="col-lg-9 col-sm-8 col-xs-12">
                                                        <div className="form-group">
                                                            <span id="span-birthday" className="span-display" style={{ display: "none" }}></span>

                                                            <input name="birthyear" type="date" onChange={handleDateOfBirthChange} value={moment(userInfo.date_of_birth).format("yyyy-MM-DD") || ''} id="BirthYear" className="form-control" style={{ display: 'block' }} />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div className="row">
                                                    <div className="col-lg-3 col-sm-4 col-xs-12">
                                                        <div className="form-group">
                                                            <label htmlFor="text" className="required" aria-required="true">S??? ??i???n tho???i</label>
                                                        </div>
                                                    </div>
                                                    <div className="col-lg-9 col-sm-8 col-xs-12">
                                                        <div className="form-group">
                                                            <span id="span-phone" className="span-display" style={{ display: "none" }}></span>
                                                            <input name="phone" type="text" onChange={handleInput} value={userInfo.phone || ''} className="form-control is-required" id="PhoneNumber" placeholder="S??? ??i???n tho???i" autoComplete="tel-national" style={{ display: 'block' }} />
                                                            <label id="phone-error" className="error" htmlFor="phone">{errorInput.phone}</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div className="row">
                                                    <div className="col-lg-3 col-sm-4 col-xs-12">
                                                        <div className="form-group">
                                                            <label htmlFor="email" className="required" aria-required="true">Email</label>
                                                        </div>
                                                    </div>
                                                    <div className="col-lg-9 col-sm-8 col-xs-12">
                                                        <div className="form-group">
                                                            <span id="span-email" className="span-display" style={{ display: "none" }}></span>
                                                            <input name="email" type="email" value={userInfo.email || ''} disabled className="form-control" id="email" placeholder="Email" autoComplete="email" style={{ display: 'block' }} />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div className="row">
                                                    <div className="col-lg-3 col-sm-4 col-xs-12">
                                                        <div className="form-group">
                                                            <label htmlFor="GraduatedSchool" aria-required="true">Tr?????ng</label>
                                                        </div>
                                                    </div>
                                                    <div className="col-lg-9 col-sm-8 col-xs-12">
                                                        <div className="form-group">
                                                            <span id="span-school" className="span-display" style={{ display: "none" }}></span>
                                                            <input name="graduatedschool" type="text" onChange={handleSchoolIdChange} value={userInfo.school || ''} className="form-control" id="GraduatedSchool" autoComplete="graduated-school" aria-required="true" style={{ display: 'block' }} />
                                                        </div>
                                                    </div>
                                                </div>

                                                <div className="row">
                                                    <div className="col-lg-3 col-sm-4 col-xs-12">
                                                        <div className="form-group">
                                                            <label htmlFor="StateId" aria-required="true">Th??nh ph???</label>
                                                        </div>
                                                    </div>
                                                    <div className="col-lg-9 col-sm-8 col-xs-12">
                                                        <div className="form-group">
                                                            <select className="form-select" id="StateSelect" name="stateselect" onChange={handleCityChange} value={userInfo.city_id || "-1"}>
                                                                <option value="-1" defaultValue="selected">Ch???n th??nh ph???</option>
                                                                <option value="1">H??? Ch?? Minh</option>
                                                                <option value="2">Ha?? N????i</option>
                                                                <option value="3">???? N???ng</option>
                                                                <option value="4">B??nh D????ng</option>
                                                                <option value="5">?????ng Nai</option>
                                                                <option value="6">Kh??nh H??a</option>
                                                                <option value="7">H???i Ph??ng</option>
                                                                <option value="8">Long An</option>
                                                                <option value="9">Qu???ng Nam</option>
                                                                <option value="10">B?? R???a V??ng T??u</option>
                                                                <option value="11">?????k L???k</option>
                                                                <option value="12">C???n Th??</option>
                                                                <option value="13">B??nh Thu???n  </option>
                                                                <option value="14">L??m ?????ng</option>
                                                                <option value="15">Th???a Thi??n Hu???</option>
                                                                <option value="16">Ki??n Giang</option>
                                                                <option value="17">B???c Ninh</option>
                                                                <option value="18">Qu???ng Ninh</option>
                                                                <option value="19">Thanh H??a</option>
                                                                <option value="20">Ngh??? An</option>
                                                                <option value="21">H???i D????ng</option>
                                                                <option value="22">Gia Lai</option>
                                                                <option value="23">B??nh Ph?????c</option>
                                                                <option value="24">H??ng Y??n</option>
                                                                <option value="25">B??nh ?????nh</option>
                                                                <option value="26">Ti???n Giang</option>
                                                                <option value="27">Th??i B??nh</option>
                                                                <option value="28">B???c Giang</option>
                                                                <option value="29">H??a B??nh</option>
                                                                <option value="30">An Giang</option>
                                                                <option value="31">V??nh Ph??c</option>
                                                                <option value="32">T??y Ninh</option>
                                                                <option value="33">Th??i Nguy??n</option>
                                                                <option value="34">L??o Cai</option>
                                                                <option value="35">Nam ?????nh</option>
                                                                <option value="36">Qu???ng Ng??i</option>
                                                                <option value="37">B???n Tre</option>
                                                                <option value="38">?????k N??ng</option>
                                                                <option value="39">C?? Mau</option>
                                                                <option value="40">V??nh Long</option>
                                                                <option value="41">Ninh B??nh</option>
                                                                <option value="42">Ph?? Th???</option>
                                                                <option value="43">Ninh Thu???n</option>
                                                                <option value="44">Ph?? Y??n</option>
                                                                <option value="45">H?? Nam</option>
                                                                <option value="46">H?? T??nh</option>
                                                                <option value="47">?????ng Th??p</option>
                                                                <option value="48">S??c Tr??ng</option>
                                                                <option value="49">Kon Tum</option>
                                                                <option value="50">Qu???ng B??nh</option>
                                                                <option value="51">Qu???ng Tr???</option>
                                                                <option value="52">Tr?? Vinh</option>
                                                                <option value="53">H???u Giang</option>
                                                                <option value="54">S??n La</option>
                                                                <option value="55">B???c Li??u</option>
                                                                <option value="56">Y??n B??i</option>
                                                                <option value="57">Tuy??n Quang</option>
                                                                <option value="58">??i???n Bi??n</option>
                                                                <option value="59">Lai Ch??u</option>
                                                                <option value="60">L???ng S??n</option>
                                                                <option value="61">H?? Giang</option>
                                                                <option value="62">B???c K???n</option>
                                                                <option value="63">Cao B???ng</option>
                                                            </select>
                                                            <label id="StateSelect-error" className="error" htmlFor="StateSelect">{errorInput.city_id}</label>
                                                        </div>
                                                    </div>
                                                </div>

                                                {/* <div className="row">
                                                    <div className="col-lg-3 col-sm-4 col-xs-12">
                                                        <div className="form-group">
                                                            <label htmlFor="CityName">?????a ch???</label>
                                                        </div>
                                                    </div>
                                                    <div className="col-lg-9 col-sm-8 col-xs-12">
                                                        <div className="form-group">
                                                            <span id="span-cityName" className="span-display" style={{ display: "none" }}></span>
                                                            <textarea name="CityName" type="text" className="form-control" id="CityName" placeholder="T???nh/Th??nh ph??? b???n ??ang s???ng" style={{ display: 'block' }}></textarea>
                                                        </div>
                                                    </div>
                                                </div> */}

                                                <div className="row">
                                                    <div className="col-lg-3 col-sm-4 col-xs-12">
                                                        <div className="form-group">
                                                            <label>Facebook</label>
                                                        </div>
                                                    </div>
                                                    <div className="col-lg-9 col-sm-8 col-xs-12">
                                                        <div className="form-group">
                                                            <span id="span-facebook" className="span-display" style={{ display: "none" }} title=""></span>
                                                            <input type="text" name="facebook" onChange={handleInput} value={userInfo.facebook || ''} className="form-control" id="facebook" placeholder="Your profile link" style={{ display: 'block' }} />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div className="row">
                                                    <div className="col-lg-3 col-sm-4 col-xs-12">
                                                        <div className="form-group">
                                                            <label>LinkedIn</label>
                                                        </div>
                                                    </div>
                                                    <div className="col-lg-9 col-sm-8 col-xs-12">
                                                        <div className="form-group">
                                                            <span id="span-linkedIn" className="span-display" style={{ display: "none" }} title=""></span>
                                                            <input type="text" name="linkedin" onChange={handleInput} value={userInfo.linkedin || ''} className="form-control" id="linkedIn" placeholder="Your profile link" style={{ display: 'block' }} />
                                                        </div>
                                                    </div>
                                                </div>

                                                <div className="row">
                                                    <div className="col-lg-3 col-sm-4 col-xs-12">
                                                        <div className="form-group">
                                                            <label>Bio</label>
                                                        </div>
                                                    </div>
                                                    <div className="col-lg-9 col-sm-8 col-xs-12">
                                                        <div className="form-group">
                                                            <p id="span-Bio" style={{ display: "none" }}></p>
                                                            <textarea rows="5" name="bio" onChange={handleInput} value={userInfo.bio || ''} type="text" className="form-control" id="bio" style={{ display: 'block' }}></textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                                {/* <div className="row">
                                                    <div className="col-lg-3 col-sm-4 col-xs-12">
                                                        <div className="form-group">
                                                            <label>Th??nh t??ch</label>
                                                        </div>
                                                    </div>
                                                    <div className="col-lg-9 col-sm-8 col-xs-12">
                                                        <div className="form-group">
                                                            <ul id="span-achievement" style={{ display: "none" }}></ul>
                                                            <textarea rows="5" name="Achievement" type="text" className="form-control" id="achievement" style={{ display: 'block' }}></textarea>
                                                        </div>
                                                    </div>
                                                </div> */}
                                                <div className="row">
                                                    <div className="form-group pull-right">
                                                        <button className="btn btn-sm pull-right btn-save save-info-button my--cus-button" type="submit" id="btnSaveInfo" >L??u</button>
                                                        <button className="btn btn-sm pull-right btn-cancel my--cus-button" type="button" id="btnCancelInfo" onClick={handleCancle}>H???y</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                    </form>
                                    <h2 className="user--profile-title-group">?????i m???t kh???u</h2>
                                    <div className="row">
                                        <div className="col-md-12">
                                            <div className="form-group">
                                                <div id="change-password" className="tab-pane active">
                                                    <form id="frmChangePassword" onSubmit={handleUpdatePassword}>
                                                        <div className="form-group">
                                                            <label htmlFor="currentPassword">M???t kh???u</label>
                                                            <input name="currentPassword" type="password" onChange={handlePasswordChange} className="form-control" placeholder="M???t kh???u" autoComplete="current-password" />
                                                            <label id="currentPassword-error" className="error" htmlFor="currentPassword">{errorInput.currentPassword}</label>
                                                        </div>
                                                        <p>
                                                            {/* <!--link cho form qu??n m???t kh???u ??i???n sau--> */}
                                                            <a href="#" className="pull-right">Qu??n m???t kh???u?</a>
                                                        </p>
                                                        <div className="form-group">
                                                            <label htmlFor="newPassword">M???t kh???u m???i</label>
                                                            <input name="newPassword" type="password" onChange={handlePasswordChange} className="form-control" placeholder="M???t kh???u m???i" />
                                                            <label id="newPassword-error" className="error" htmlFor="newPassword">{errorInput.newPassword}</label>
                                                        </div>
                                                        <div className="form-group">
                                                            <label htmlFor="confirmPassword">M???t kh???u x??c nh???n</label>
                                                            <input name="confirmPassword" type="password" onChange={handlePasswordChange} className="form-control" placeholder="M???t kh???u x??c nh???n" />
                                                            <label id="confirmPassword-error" className="error" htmlFor="confirmPassword">{errorInput.confirmPassword}</label>
                                                        </div>
                                                        <div className="form-group">
                                                            <button className="btn btn-sm pull-right btn-save save-info-button my--cus-button" type="submit" id="btnSavePass" >Thay ?????i</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>


                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


        </div >
    </>);
}

export default MyInfo;