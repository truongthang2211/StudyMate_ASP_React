import React, { useEffect, memo } from 'react';
import SignUpForm from '../../components/SignUpForm';
import Footer from '../../components/Footer';
import ScrollReveal from 'scrollreveal';
import './Login.css'
function Login() {

    const revealAnimations = () => {
        const sr = window.sr = ScrollReveal()
        sr.reveal('.feature', {
            duration: 600,
            distance: '20px',
            easing: 'cubic-bezier(0.215, 0.61, 0.355, 1)',
            origin: 'right',
            viewFactor: 0.2
        })
    }
    const LoginLoad = () => {
        const body = document.getElementById('root2')
        if (!body.classList.contains('is-loaded')) {
            body.classList.add('is-loaded')
            revealAnimations()

        }
    }
    const FocusSignUp = () => {
        document.getElementsByName('username')[0].focus()

    }
    useEffect(() => {
        LoginLoad();
    })
    console.log('render login-page')
    return (
        <>
            <div className="is-boxed has-animations" id="root2">
                <div className="body-wrap boxed-container">
                    <header className="site-header">
                        <div className="container">
                            <div className="site-header-inner">
                                <div className="brand header-brand">
                                    <h1 className="m-0">
                                        <a href="#">
                                            <img className="header-logo-image asset-light" src="img/login/logo-light.svg"
                                                alt="Logo" />

                                        </a>
                                    </h1>
                                </div>
                            </div>
                        </div>
                    </header>

                    <main>
                        <section className="hero">
                            <div className="container">
                                <div className="hero-inner">
                                    <SignUpForm />
                                    <div className="hero-media">
                                        <div className="header-illustration">
                                            <img className="header-illustration-image asset-light"
                                                src="img/login/header-illustration-light.svg" alt="Header illustration" />
                                        </div>
                                        <div className="hero-media-illustration">
                                            <img className="hero-media-illustration-image asset-light"
                                                src="img/login/hero-media-illustration-light.svg"
                                                alt="Hero media illustration" />
                                        </div>
                                        <div className="hero-media-container">
                                            <img className="hero-media-image asset-light" src="\img\courses\register.PNG"
                                                alt="Hero media" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>

                        <section className="features section">
                            <div className="container">
                                <div className="features-inner section-inner has-bottom-divider">
                                    <div className="features-header text-center">
                                        <div className="container-sm">
                                            <h2 className="section-title mt-0">Studymate - T????ng lai t???t h??n b???t ?????u t??? ????y</h2>
                                            <p className="section-paragraph">Studymate ph??t tri???n m???t m??i tr?????ng h???c tr???c tuy???n cung c???p c??c kh??a h???c ??? nhi???u l??nh v???c kh??c nhau.
                                                K???t n???i nh???ng ng?????i c?? c??ng chung ni???m ??am m?? ????? c??ng nhau x??y d???ng m???t c???ng ?????ng l???n m???nh.</p>
                                            <div className="features-image">


                                                <img className="features-illustration asset-light"
                                                    src="img/login/features-illustration-light.svg"
                                                    alt="Feature illustration" />
                                                {/* <img className="features-box asset-light" src="img/login/features-box-light.svg"
                                                    alt="Feature box" /> */}
                                                <img className="features-box asset-light" src="https://thumbs.dreamstime.com/b/join-us-hand-drawn-illustration-cartoon-style-holding-sign-red-white-join-us-hand-drawn-illustration-cartoon-style-holding-153300538.jpg"
                                                    alt="Feature box" />
                                                <img className="features-illustration asset-light"
                                                    src="img/login/features-illustration-top-light.svg"
                                                    alt="Feature illustration top" />
                                            </div>
                                        </div>
                                    </div>
                                    <div className="features-wrap">
                                        <div className="feature is-revealing">
                                            <div className="feature-inner">
                                                <div className="feature-icon">
                                                    <img className="asset-light" src="img/login/feature-01-light.svg"
                                                        alt="Feature 01" />

                                                </div>
                                                <div className="feature-content">
                                                    <h3 className="feature-title mt-0">C???ng ?????ng l???n</h3>
                                                    <p className="text-sm mb-0">C??c kh??a h???c StudyMate d???a tr??n s??? ????ng g??p c???a m???i c?? nh??n.
                                                        B???t k??? ai c??ng c?? th??? chia s??? nh???ng ki???n th???c b??? ??ch c???a m??nh ?????n v???i m???i ng?????i.</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div className="feature is-revealing">
                                            <div className="feature-inner">
                                                <div className="feature-icon">
                                                    <img className="asset-light" src="img/login/feature-02-light.svg"
                                                        alt="Feature 02" />

                                                </div>
                                                <div className="feature-content">
                                                    <h3 className="feature-title mt-0">B??i gi???ng ch???t l?????ng</h3>
                                                    <p className="text-sm mb-0">M???i kh??a h???c ?????u ???????c ph?? duy???t ch???t ch???, ?????m b??o ch???t l?????ng tr?????c khi ???????c ????ng t???i.</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div className="feature is-revealing">
                                            <div className="feature-inner">
                                                <div className="feature-icon">
                                                    <img className="asset-light" src="img/login/feature-03-light.svg"
                                                        alt="Feature 03" />

                                                </div>
                                                <div className="feature-content">
                                                    <h3 className="feature-title mt-0">Tr???c tuy???n</h3>
                                                    <p className="text-sm mb-0">H???c m???i l??c, m???i n??i. Mi???n l?? b???n c?? k???t n???i m???ng.</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>

                        <section className="cta section">
                            <div className="container-sm">
                                <div className="cta-inner section-inner">
                                    <div className="cta-header text-center">
                                        <h2 className="section-title mt-0">????ng k?? ngay</h2>
                                        <p className="section-paragraph">N???u ta kh??ng gieo tr???ng tri th???c khi c??n tr???, n?? s??? kh??ng cho ta b??ng r??m khi ta v??? gi??.</p>
                                        <div className="cta-cta">

                                            <a className="button button-primary" onClick={FocusSignUp}>????ng k??</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </main>


                </div>
            </div>
            <Footer></Footer>
        </>
    );
}

export default memo(Login);