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
                    text: 'Thành công',
                    icon: 'success',
                    confirmButtonText: 'OK'
                })
                setError([]);
                //history.push('/myinfo');
            }
            else if (res.data.status === 422) {
                Swal.fire({
                    text: 'Thất bại',
                    icon: 'warning',
                    confirmButtonText: 'Cancel'
                })
                //Swal("All fields are mandetory", "", "error");
                setError(res.data.validationErrors);
            }
            else if (res.data.status === 404) {
                Swal.fire({
                    text: 'Thất bại',
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
                text: 'Mật khẩu không hợp lệ',
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
                            text: 'Thành công',
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
                            text: 'Thất bại',
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
                                    <li className="active"><a href="#">Thông tin &amp; liên hệ </a></li>
                                    {/* <li><a href="#change-userName">Đổi tên người dùng </a></li> */}
                                    <li><a href="#change-password">Đổi mật khẩu</a></li>
                                </ul>
                            </div>
                        </div>
                        <div className="col-md-9 user--profile-right-container">
                            <div className="user--profile-right editing">
                                <div className="user--profile-group">
                                    <h2 className="user--profile-title-group">Thông tin</h2>
                                    <form id="frm-info" onSubmit={handleUpdateMyInfo}>
                                        <div className="row">

                                            <div className="col-md-6 col-xs-12">
                                                <div className="row myinfo-avt">
                                                    <img id="AvtPreview" src={userInfo.avatar_img ? (userInfo.avatar_img.substring(0, 3) == 'img' ? `/${userInfo.avatar_img}` : `${userInfo.avatar_img}`) : "https://genk.mediacdn.vn/thumb_w/600/2015/screen-shot-2015-07-30-at-2-31-57-pm-1438334096188.png"} className="no-img" />
                                                </div>
                                                <div className="row avatar-selector">
                                                    <div className="form-group UploadAvatar">
                                                        <label style={{ display: 'block' }}>Ảnh đại diện của bạn</label>
                                                        <label htmlFor="Avatar" className="browse btn btn-primary input-sm" type="button" id="Upload-Ava" style={{ display: 'block' }}>Chọn ảnh</label>
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
                                                        <label style={{ display: 'block' }}>Ảnh nền trang user của bạn</label>
                                                        <label htmlFor="Background" className="browse btn btn-primary input-sm" type="button" id="Upload-Ava" style={{ display: 'block' }}>Chọn ảnh</label>
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
                                                            <label htmlFor="name" className="required" aria-required="true">Họ và Tên</label>
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
                                                            <label htmlFor="BirthYear">Ngày sinh</label>
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
                                                            <label htmlFor="text" className="required" aria-required="true">Số điện thoại</label>
                                                        </div>
                                                    </div>
                                                    <div className="col-lg-9 col-sm-8 col-xs-12">
                                                        <div className="form-group">
                                                            <span id="span-phone" className="span-display" style={{ display: "none" }}></span>
                                                            <input name="phone" type="text" onChange={handleInput} value={userInfo.phone || ''} className="form-control is-required" id="PhoneNumber" placeholder="Số điện thoại" autoComplete="tel-national" style={{ display: 'block' }} />
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
                                                            <label htmlFor="GraduatedSchool" aria-required="true">Trường</label>
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
                                                            <label htmlFor="StateId" aria-required="true">Thành phố</label>
                                                        </div>
                                                    </div>
                                                    <div className="col-lg-9 col-sm-8 col-xs-12">
                                                        <div className="form-group">
                                                            <select className="form-select" id="StateSelect" name="stateselect" onChange={handleCityChange} value={userInfo.city_id || "-1"}>
                                                                <option value="-1" defaultValue="selected">Chọn thành phố</option>
                                                                <option value="1">Hồ Chí Minh</option>
                                                                <option value="2">Hà Nội</option>
                                                                <option value="3">Đà Nẵng</option>
                                                                <option value="4">Bình Dương</option>
                                                                <option value="5">Đồng Nai</option>
                                                                <option value="6">Khánh Hòa</option>
                                                                <option value="7">Hải Phòng</option>
                                                                <option value="8">Long An</option>
                                                                <option value="9">Quảng Nam</option>
                                                                <option value="10">Bà Rịa Vũng Tàu</option>
                                                                <option value="11">Đắk Lắk</option>
                                                                <option value="12">Cần Thơ</option>
                                                                <option value="13">Bình Thuận  </option>
                                                                <option value="14">Lâm Đồng</option>
                                                                <option value="15">Thừa Thiên Huế</option>
                                                                <option value="16">Kiên Giang</option>
                                                                <option value="17">Bắc Ninh</option>
                                                                <option value="18">Quảng Ninh</option>
                                                                <option value="19">Thanh Hóa</option>
                                                                <option value="20">Nghệ An</option>
                                                                <option value="21">Hải Dương</option>
                                                                <option value="22">Gia Lai</option>
                                                                <option value="23">Bình Phước</option>
                                                                <option value="24">Hưng Yên</option>
                                                                <option value="25">Bình Định</option>
                                                                <option value="26">Tiền Giang</option>
                                                                <option value="27">Thái Bình</option>
                                                                <option value="28">Bắc Giang</option>
                                                                <option value="29">Hòa Bình</option>
                                                                <option value="30">An Giang</option>
                                                                <option value="31">Vĩnh Phúc</option>
                                                                <option value="32">Tây Ninh</option>
                                                                <option value="33">Thái Nguyên</option>
                                                                <option value="34">Lào Cai</option>
                                                                <option value="35">Nam Định</option>
                                                                <option value="36">Quảng Ngãi</option>
                                                                <option value="37">Bến Tre</option>
                                                                <option value="38">Đắk Nông</option>
                                                                <option value="39">Cà Mau</option>
                                                                <option value="40">Vĩnh Long</option>
                                                                <option value="41">Ninh Bình</option>
                                                                <option value="42">Phú Thọ</option>
                                                                <option value="43">Ninh Thuận</option>
                                                                <option value="44">Phú Yên</option>
                                                                <option value="45">Hà Nam</option>
                                                                <option value="46">Hà Tĩnh</option>
                                                                <option value="47">Đồng Tháp</option>
                                                                <option value="48">Sóc Trăng</option>
                                                                <option value="49">Kon Tum</option>
                                                                <option value="50">Quảng Bình</option>
                                                                <option value="51">Quảng Trị</option>
                                                                <option value="52">Trà Vinh</option>
                                                                <option value="53">Hậu Giang</option>
                                                                <option value="54">Sơn La</option>
                                                                <option value="55">Bạc Liêu</option>
                                                                <option value="56">Yên Bái</option>
                                                                <option value="57">Tuyên Quang</option>
                                                                <option value="58">Điện Biên</option>
                                                                <option value="59">Lai Châu</option>
                                                                <option value="60">Lạng Sơn</option>
                                                                <option value="61">Hà Giang</option>
                                                                <option value="62">Bắc Kạn</option>
                                                                <option value="63">Cao Bằng</option>
                                                            </select>
                                                            <label id="StateSelect-error" className="error" htmlFor="StateSelect">{errorInput.city_id}</label>
                                                        </div>
                                                    </div>
                                                </div>

                                                {/* <div className="row">
                                                    <div className="col-lg-3 col-sm-4 col-xs-12">
                                                        <div className="form-group">
                                                            <label htmlFor="CityName">Địa chỉ</label>
                                                        </div>
                                                    </div>
                                                    <div className="col-lg-9 col-sm-8 col-xs-12">
                                                        <div className="form-group">
                                                            <span id="span-cityName" className="span-display" style={{ display: "none" }}></span>
                                                            <textarea name="CityName" type="text" className="form-control" id="CityName" placeholder="Tỉnh/Thành phố bạn đang sống" style={{ display: 'block' }}></textarea>
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
                                                            <label>Thành tích</label>
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
                                                        <button className="btn btn-sm pull-right btn-save save-info-button my--cus-button" type="submit" id="btnSaveInfo" >Lưu</button>
                                                        <button className="btn btn-sm pull-right btn-cancel my--cus-button" type="button" id="btnCancelInfo" onClick={handleCancle}>Hủy</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                    </form>
                                    <h2 className="user--profile-title-group">Đổi mật khẩu</h2>
                                    <div className="row">
                                        <div className="col-md-12">
                                            <div className="form-group">
                                                <div id="change-password" className="tab-pane active">
                                                    <form id="frmChangePassword" onSubmit={handleUpdatePassword}>
                                                        <div className="form-group">
                                                            <label htmlFor="currentPassword">Mật khẩu</label>
                                                            <input name="currentPassword" type="password" onChange={handlePasswordChange} className="form-control" placeholder="Mật khẩu" autoComplete="current-password" />
                                                            <label id="currentPassword-error" className="error" htmlFor="currentPassword">{errorInput.currentPassword}</label>
                                                        </div>
                                                        <p>
                                                            {/* <!--link cho form quên mật khẩu điền sau--> */}
                                                            <a href="#" className="pull-right">Quên mật khẩu?</a>
                                                        </p>
                                                        <div className="form-group">
                                                            <label htmlFor="newPassword">Mật khẩu mới</label>
                                                            <input name="newPassword" type="password" onChange={handlePasswordChange} className="form-control" placeholder="Mật khẩu mới" />
                                                            <label id="newPassword-error" className="error" htmlFor="newPassword">{errorInput.newPassword}</label>
                                                        </div>
                                                        <div className="form-group">
                                                            <label htmlFor="confirmPassword">Mật khẩu xác nhận</label>
                                                            <input name="confirmPassword" type="password" onChange={handlePasswordChange} className="form-control" placeholder="Mật khẩu xác nhận" />
                                                            <label id="confirmPassword-error" className="error" htmlFor="confirmPassword">{errorInput.confirmPassword}</label>
                                                        </div>
                                                        <div className="form-group">
                                                            <button className="btn btn-sm pull-right btn-save save-info-button my--cus-button" type="submit" id="btnSavePass" >Thay đổi</button>
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