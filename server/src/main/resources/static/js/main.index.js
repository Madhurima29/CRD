(this.webpackJsonpNode_Interfaces = this.webpackJsonpNode_Interfaces || []).push([
    [0], {
        14: function(e, t, a) {},
        15: function(e, t, a) {},
        16: function(e, t) {
            e.exports.codeSystemConversion = {
                "http://www.ama-assn.org/go/cpt": "CPT",
                "https://bluebutton.cms.gov/resources/codesystem/hcpcs": "HCPCS",
                "http://www.nlm.nih.gov/research/umls/rxnorm": "RxNorm"
            }
        },
        20: function(e, t, a) {},
        28: function(e, t, a) {
            e.exports = a(50)
        },
        33: function(e, t, a) {},
        34: function(e, t, a) {
            e.exports = a.p + "static/media/logo.5d5d9eef.svg"
        },
        35: function(e, t, a) {},
        37: function(e, t, a) {},
        43: function(e, t, a) {},
        50: function(e, t, a) {
            "use strict";
            a.r(t);
            var n = a(0),
                s = a.n(n),
                i = a(21),
                r = a.n(i),
                o = (a(33), a(3)),
                c = a(4),
                l = a(6),
                u = a(5),
                d = a(7),
                h = (a(34), a(35), a(53)),
                m = a(10),
                p = a.n(m),
                f = a(13),
                v = a(1),
                b = (a(37), a(14), a(54)),
                y = (a(15), a(16)),
                g = function(e) {
                    function t(e) {
                        var a;
                        return Object(o.a)(this, t), (a = Object(l.a)(this, Object(u.a)(t).call(this, e))).state = {
                            requestInfo: {}
                        }, a
                    }
                    return Object(d.a)(t, e), Object(c.a)(t, [{
                        key: "componentDidMount",
                        value: function() {
                            var e = this.props.data;
                            this.setState({
                                requestInfo: {
                                    age: e.patientAge,
                                    gender: e.patientGender,
                                    "Patient State": e.patientAddressState,
                                    "Provider State": e.providerAddressState,
                                    code: e.code,
                                    codeSystem: y.codeSystemConversion[e.codeSystem]
                                }
                            })
                        }
                    }, {
                        key: "render",
                        value: function() {
                            var e = this;
                            return s.a.createElement("div", null, s.a.createElement("div", {
                                className: "healthInfoHeader"
                            }, "Request Info"), s.a.createElement("div", {
                                className: "healthInfo"
                            }, Object.keys(this.state.requestInfo).map((function(t) {
                                return s.a.createElement("div", {
                                    key: t,
                                    className: "infoEntry"
                                }, s.a.createElement("span", {
                                    className: "infoTitle"
                                }, t), ": ", e.state.requestInfo[t])
                            }))))
                        }
                    }]), t
                }(n.Component),
                E = a(24),
                w = a.n(E),
                j = function(e) {
                    function t(e) {
                        var a;
                        return Object(o.a)(this, t), (a = Object(l.a)(this, Object(u.a)(t).call(this, e))).state = {
                            events: {
                                Authorized: {
                                    status: !!a.props.timeline && a.props.timeline[0],
                                    hovertext: "CRD gained authorization to access all necessary services"
                                },
                                Parsed: {
                                    status: !!a.props.timeline && a.props.timeline[1],
                                    hovertext: "Request data parsed"
                                },
                                Hydrated: {
                                    status: !!a.props.timeline && a.props.timeline[2],
                                    hovertext: "Prefetched associated data and added to request data"
                                },
                                "CQL Fetched": {
                                    status: !!a.props.timeline && a.props.timeline[3],
                                    hovertext: "Retrieved relevant CQL"
                                },
                                "CQL Executed": {
                                    status: !!a.props.timeline && a.props.timeline[4],
                                    hovertext: "Executed CQL using prefetched and request data"
                                }
                            }
                        }, a
                    }
                    return Object(d.a)(t, e), Object(c.a)(t, [{
                        key: "render",
                        value: function() {
                            var e = this;
                            return s.a.createElement("div", null, s.a.createElement("div", {
                                className: "errorDetailBox"
                            }, Object.keys(this.state.events).map((function(t, a) {
                                return s.a.createElement("div", {
                                    key: t
                                }, s.a.createElement("div", {
                                    className: "singleRow withNode"
                                }, s.a.createElement("div", {
                                    className: "timelineEvent"
                                }, s.a.createElement("span", {
                                    className: "labelFormat"
                                }, s.a.createElement(w.a, {
                                    content: e.state.events[t].hovertext,
                                    direction: "right",
                                    tagName: "span",
                                    useDefaultStyles: "true"
                                }, t))), s.a.createElement("a", {
                                    className: "node circle " + [e.state.events[t].status ? "success" : "failure"]
                                }, 0 !== a ? s.a.createElement("span", {
                                    className: "topDivet"
                                }) : s.a.createElement("span", {
                                    className: "topDivet invis"
                                }), a !== Object.keys(e.state.events).length - 1 ? s.a.createElement("span", {
                                    className: "bottomDivet"
                                }) : null)), a !== Object.keys(e.state.events).length - 1 ? s.a.createElement("div", {
                                    className: "singleRow"
                                }, s.a.createElement("div", {
                                    className: "timelineEvent emptyEdge"
                                }), s.a.createElement("div", {
                                    className: "node edge"
                                }, " | ")) : null)
                            }))))
                        }
                    }]), t
                }(n.Component),
                k = function(e) {
                    function t(e) {
                        var a;
                        return Object(o.a)(this, t), (a = Object(l.a)(this, Object(u.a)(t).call(this, e))).state = {
                            responseInfo: {}
                        }, a
                    }
                    return Object(d.a)(t, e), Object(c.a)(t, [{
                        key: "render",
                        value: function() {
                            return s.a.createElement("div", null, s.a.createElement("div", {
                                className: "responseResults"
                            }, this.props.results.length ? this.props.results.map((function(e) {
                                return Object.keys(e).map((function(t) {
                                    return !0 === e[t] ? e[t] = "true" : !1 === e[t] && (e[t] = "false"), "id" == t ? s.a.createElement("div", {
                                        key: t,
                                        className: "ruleInfoHeader"
                                    }, "Rule Id: ", e[t]) : s.a.createElement("div", {
                                        key: t,
                                        className: "infoEntry " + [e[t] ? "" : "faded"]
                                    }, t, ": ", e[t])
                                }))
                            })) : "No rules found"))
                        }
                    }]), t
                }(n.Component),
                C = function(e) {
                    function t(e) {
                        var a;
                        return Object(o.a)(this, t), (a = Object(l.a)(this, Object(u.a)(t).call(this, e))).state = {
                            slideIn: "slideInStart",
                            requestInfo: {},
                            showRequestBody: !1,
                            showResults: !1
                        }, a.showRequestBody = a.showRequestBody.bind(Object(v.a)(a)), a.showResults = a.showResults.bind(Object(v.a)(a)), a
                    }
                    return Object(d.a)(t, e), Object(c.a)(t, [{
                        key: "showRequestBody",
                        value: function() {
                            this.setState((function(e) {
                                return {
                                    showRequestBody: !e.showRequestBody
                                }
                            }))
                        }
                    }, {
                        key: "showResults",
                        value: function() {
                            this.setState((function(e) {
                                return {
                                    showResults: !e.showResults
                                }
                            }))
                        }
                    }, {
                        key: "unfurlJson",
                        value: function(e) {
                            var t = this,
                                a = {
                                    marginLeft: 20
                                };
                            if (e) return Object.keys(e).map((function(n) {
                                return "access_token" === n ? s.a.createElement("div", {
                                    className: "jsonData",
                                    key: n,
                                    style: a
                                }, s.a.createElement("span", {
                                    className: "elementKey"
                                }, n), ": ", s.a.createElement("span", {
                                    className: "elementBody"
                                }, "-")) : s.a.createElement("div", {
                                    className: "jsonData",
                                    key: n,
                                    style: a
                                }, s.a.createElement("span", {
                                    className: "elementKey"
                                }, n), ": ", s.a.createElement("span", {
                                    className: "elementBody"
                                }, null === e[n] ? "null" : "object" === typeof e[n] ? t.unfurlJson(e[n]) : e[n]))
                            }))
                        }
                    }, {
                        key: "render",
                        value: function() {
                            var e = this;
                            return s.a.createElement("div", null, s.a.createElement("div", {
                                className: "detailWindow",
                                onClick: function() {
                                    e.state.showRequestBody && e.setState({
                                        showRequestBody: !1
                                    }), e.state.showResults && e.setState({
                                        showResults: !1
                                    })
                                }
                            }, s.a.createElement("div", {
                                className: "col1"
                            }, s.a.createElement("div", {
                                className: "healthInfoBox"
                            }, s.a.createElement(g, {
                                data: this.props.data
                            }))), s.a.createElement("div", {
                                className: "col1"
                            }, s.a.createElement(j, {
                                timeline: this.props.data.timeline
                            })), s.a.createElement("div", {
                                className: "col1 processTime"
                            }, s.a.createElement("div", {
                                className: "errorDetail " + [this.state.showRequestBody ? "filled" : "empty"],
                                onClick: this.showRequestBody
                            }, "Show Request Body"), s.a.createElement("div", {
                                className: "errorDetail " + [this.state.showResults ? "filled" : "empty"],
                                onClick: this.showResults
                            }, "CQL Results ", s.a.createElement("span", null, "[ ", this.props.data.rulesFound.length, " ]")))), this.state.showRequestBody ? s.a.createElement("div", {
                                className: "requestBody"
                            }, this.unfurlJson(JSON.parse(atob(this.props.data.requestBody)))) : null, this.state.showResults ? s.a.createElement("div", {
                                className: "requestBody"
                            }, s.a.createElement(k, {
                                results: this.props.data.rulesFound
                            })) : null)
                        }
                    }]), t
                }(n.Component),
                S = function(e) {
                    function t(e) {
                        var a;
                        Object(o.a)(this, t), a = Object(l.a)(this, Object(u.a)(t).call(this, e));
                        var n = e.data.timeStamp;
                        return n || (n = new Date), n = Object(b.a)(new Date(n), "yyyy-MM-dd   HH:mm:ss  O"), a.state = {
                            hookType: a.props.data.hookType,
                            fhirVersion: a.props.data.fhirVersion,
                            success: !!a.props.data.timeline && a.props.data.timeline[4],
                            timeStamp: n,
                            viewDetails: !1
                        }, a.openDetails = a.openDetails.bind(Object(v.a)(a)), a
                    }
                    return Object(d.a)(t, e), Object(c.a)(t, [{
                        key: "openDetails",
                        value: function() {
                            this.setState((function(e) {
                                return {
                                    viewDetails: !e.viewDetails
                                }
                            }))
                        }
                    }, {
                        key: "render",
                        value: function() {
                            return s.a.createElement("div", null, s.a.createElement("div", {
                                className: "requestEntry " + [this.state.success ? "successRequest " : "failureRequest "] + [this.state.viewDetails ? "active" : ""],
                                onClick: this.openDetails
                            }, s.a.createElement("div", {
                                className: "element timestamp"
                            }, this.state.timeStamp), s.a.createElement("div", {
                                className: "element fhirversion"
                            }, this.state.fhirVersion), s.a.createElement("div", {
                                className: "element hooktype"
                            }, this.state.hookType), s.a.createElement("div", {
                                className: "element successElement"
                            }, this.state.success ? "success" : "failure")), this.state.viewDetails ? s.a.createElement(C, {
                                data: this.props.data
                            }) : null)
                        }
                    }]), t
                }(n.Component),
                O = a(9),
                N = Object(O.getBaseUrl)(),
                D = function(e) {
                    function t(e) {
                        var a;
                        return Object(o.a)(this, t), (a = Object(l.a)(this, Object(u.a)(t).call(this, e))).state = {
                            data: [],
                            dataToShow: null,
                            page: 1,
                            view: 1
                        }, a.getPage = a.getPage.bind(Object(v.a)(a)), a.renderPageNumbers = a.renderPageNumbers.bind(Object(v.a)(a)), a.getData = a.getData.bind(Object(v.a)(a)), a.increaseView = a.increaseView.bind(Object(v.a)(a)), a
                    }
                    return Object(d.a)(t, e), Object(c.a)(t, [{
                        key: "componentDidMount",
                        value: function() {
                            this.getData(), this.getPage(1)
                        }
                    }, {
                        key: "getData",
                        value: function() {
                            var e = Object(f.a)(p.a.mark((function e() {
                                var t;
                                return p.a.wrap((function(e) {
                                    for (;;) switch (e.prev = e.next) {
                                        case 0:
                                            return e.next = 2, fetch(N + "api/requests", {
                                                method: "GET",
                                                headers: {
                                                    Accept: "application/json"
                                                }
                                            }).then((function(e) {
                                                return e.json()
                                            })).catch((function(e) {
                                                console.log("Couldn't load data, make sure the server is running."), console.log("error=", e)
                                            }));
                                        case 2:
                                            (t = e.sent) && (t.sort(this.compareTime), this.setState({
                                                data: t
                                            }), t.requestBody, this.getPage(1));
                                        case 4:
                                        case "end":
                                            return e.stop()
                                    }
                                }), e, this)
                            })));
                            return function() {
                                return e.apply(this, arguments)
                            }
                        }()
                    }, {
                        key: "getPage",
                        value: function(e) {
                            var t = 15 * (e - 1);
                            this.setState({
                                dataToShow: this.state.data.slice(t, t + 15)
                            }), this.setState({
                                page: e
                            })
                        }
                    }, {
                        key: "renderPageNumbers",
                        value: function() {
                            for (var e = [], t = 1; t <= Math.ceil(this.state.data.length / 15); t++) e.push(t);
                            return e
                        }
                    }, {
                        key: "compareTime",
                        value: function(e, t) {
                            return e.timestamp < t.timestamp ? 1 : e.timestamp > t.timestamp ? -1 : 0
                        }
                    }, {
                        key: "increaseView",
                        value: function(e) {
                            this.setState({
                                view: this.state.view + e
                            })
                        }
                    }, {
                        key: "render",
                        value: function() {
                            var e = this,
                                t = this.state.view + 9 - 1 < this.state.data.length / 15,
                                a = 1 != this.state.view;
                            return window.scrollTo(0, 0), s.a.createElement("div", {
                                className: "fontSetter"
                            }, s.a.createElement("div", null, s.a.createElement("div", {
                                className: "requestHeader fixed"
                            }, s.a.createElement("div", {
                                className: "element timestamp"
                            }, "Timestamp"), s.a.createElement("div", {
                                className: "element fhirversion"
                            }, "FHIR version"), s.a.createElement("div", {
                                className: "element hooktype"
                            }, "Hook Type"), s.a.createElement("div", {
                                className: "element successElement"
                            }, "Success Status"), s.a.createElement("div", {
                                className: "pageTab"
                            }, this.state.page)), s.a.createElement("div", {
                                className: "break"
                            }), s.a.createElement("div", {
                                className: "requestEntries"
                            }, this.state.dataToShow ? this.state.dataToShow.map((function(e) {
                                return s.a.createElement(S, {
                                    data: e,
                                    key: e.timestamp
                                })
                            })) : s.a.createElement("p", null))), s.a.createElement("div", {
                                className: "pageNumber"
                            }, s.a.createElement("span", null, s.a.createElement("button", {
                                className: "viewButton backwardView " + (a ? "" : "invisible"),
                                onClick: function() {
                                    e.increaseView(1 - e.state.view)
                                }
                            }, "<<"), s.a.createElement("button", {
                                className: "viewButton backwardView " + (a ? "" : "invisible"),
                                onClick: function() {
                                    e.increaseView(-1)
                                }
                            }, "<")), this.renderPageNumbers().map((function(t) {
                                if (t >= e.state.view && t < e.state.view + 9) return s.a.createElement("button", {
                                    key: t,
                                    className: "orderButton " + (t == e.state.view ? "firstButton " : "") + [e.state.page === t ? "active" : ""],
                                    onClick: function() {
                                        return e.getPage(t)
                                    }
                                }, t)
                            })), s.a.createElement("span", null, s.a.createElement("button", {
                                className: "viewButton forwardView " + (t ? "" : "invisible"),
                                onClick: function() {
                                    e.increaseView(1)
                                }
                            }, ">"), s.a.createElement("button", {
                                className: "viewButton forwardView " + (t ? "" : "invisible"),
                                onClick: function() {
                                    e.increaseView(Math.ceil(e.state.data.length / 15) - (e.state.view + 9 - 1))
                                }
                            }, ">>"))))
                        }
                    }]), t
                }(n.Component),
                I = a(27),
                R = a(12),
                B = (a(43), a(8)),
                x = a.n(B),
                q = function(e) {
                    function t(e) {
                        var a;
                        return Object(o.a)(this, t), (a = Object(l.a)(this, Object(u.a)(t).call(this, e))).state = {
                            animationClasses: "animated animatedFadeInUp fadeInUp keyEntry",
                            kid: a.props.kid,
                            jwt: a.props.jwt,
                            editMode: !1,
                            showContent: !0,
                            data: "text/json;charset=utf-8," + encodeURIComponent(a.props.jwt)
                        }, a.updateContent = a.updateContent.bind(Object(v.a)(a)), a.handleChange = a.handleChange.bind(Object(v.a)(a)), a.deleteContent = a.deleteContent.bind(Object(v.a)(a)), a
                    }
                    return Object(d.a)(t, e), Object(c.a)(t, [{
                        key: "componentDidMount",
                        value: function() {
                            try {
                                var e = JSON.parse(this.state.jwt)
                            } catch (n) {
                                e = this.state.jwt
                            }
                            try {
                                var t = B.KEYUTIL.getKey(e),
                                    a = B.KEYUTIL.getJWKFromKey(t);
                                this.setState({
                                    jwt: JSON.stringify(a)
                                }), this.setState({
                                    data: "text/json;charset=utf-8," + encodeURIComponent(JSON.stringify(a))
                                })
                            } catch (n) {}
                        }
                    }, {
                        key: "handleChange",
                        value: function(e) {
                            this.setState({
                                jwt: e.target.value
                            })
                        }
                    }, {
                        key: "updateContent",
                        value: function(e) {
                            e.preventDefault(), this.setState({
                                animationClasses: "keyEntry"
                            }), console.log(this.state.animationClasses);
                            try {
                                var t = JSON.parse(this.state.jwt)
                            } catch (i) {
                                t = this.state.jwt
                            }
                            try {
                                var a = B.KEYUTIL.getKey(t),
                                    n = B.KEYUTIL.getJWKFromKey(a);
                                this.setState({
                                    jwt: JSON.stringify(n)
                                });
                                var s = x.a.jws.JWS.getJWKthumbprint(n);
                                s != this.state.kid && (this.props.updateIdCB(this.state.kid, s, n), this.setState({
                                    kid: s
                                })), this.setState({
                                    data: "text/json;charset=utf-8," + encodeURIComponent(JSON.stringify(n))
                                })
                            } catch (i) {
                                this.props.updateIdCB(this.state.kid, this.state.kid, this.state.jwt)
                            }
                            this.state.editMode ? this.setState({
                                editMode: !1
                            }) : this.setState({
                                editMode: !0
                            })
                        }
                    }, {
                        key: "deleteContent",
                        value: function() {
                            this.props.deleteCB(this.state.kid)
                        }
                    }, {
                        key: "render",
                        value: function() {
                            var e = this,
                                t = {
                                    animationDelay: this.props.delay
                                };
                            return this.state.showContent ? s.a.createElement("div", null, s.a.createElement("div", {
                                className: this.state.animationClasses + " " + this.props.extraClass,
                                value: this.state.value,
                                style: t
                            }, s.a.createElement("div", {
                                className: "jwtContent"
                            }, s.a.createElement("form", {
                                onSubmit: this.updateContent,
                                className: "keyEntryForm"
                            }, s.a.createElement("div", {
                                className: "kidBox"
                            }, "ID: ", this.state.kid), this.state.editMode ? s.a.createElement("div", null, s.a.createElement("input", {
                                value: this.state.jwt,
                                className: "editInput",
                                onChange: function(t) {
                                    return e.handleChange(t)
                                }
                            })) : s.a.createElement("div", {
                                className: "keyData"
                            }, this.state.jwt))), s.a.createElement("div", {
                                className: "buttonContent"
                            }, s.a.createElement("button", {
                                className: "editingButton addButton " + this.props.extraClass,
                                onClick: this.state.editMode ? this.updateContent : function() {
                                    e.setState({
                                        editMode: !e.state.editMode
                                    })
                                }
                            }, this.state.editMode ? s.a.createElement("span", {
                                className: "glyphicon glyphicon-remove"
                            }) : s.a.createElement("span", {
                                className: "glyphicon glyphicon-pencil"
                            })), s.a.createElement("button", {
                                className: "editingButton deleteButton " + this.props.extraClass,
                                onClick: this.deleteContent
                            }, s.a.createElement("span", {
                                className: "glyphicon glyphicon-trash"
                            })), s.a.createElement("a", {
                                href: "data:" + this.state.data,
                                download: this.state.kid + ".json"
                            }, s.a.createElement("button", {
                                className: "editingButton downloadButton " + this.props.extraClass
                            }, s.a.createElement("span", {
                                className: "glyphicon glyphicon-download-alt"
                            })))))) : null
                        }
                    }]), t
                }(n.Component),
                T = function(e) {
                    function t(e) {
                        var a;
                        return Object(o.a)(this, t), (a = Object(l.a)(this, Object(u.a)(t).call(this, e))).state = {
                            kid: "",
                            jwt: "",
                            editMode: !0,
                            generateKeyID: !1,
                            uniqueKey: !0
                        }, a.updateContent = a.updateContent.bind(Object(v.a)(a)), a.handleChange = a.handleChange.bind(Object(v.a)(a)), a.deleteContent = a.deleteContent.bind(Object(v.a)(a)), a.generateKeyID = a.generateKeyID.bind(Object(v.a)(a)), a.submitContent = a.submitContent.bind(Object(v.a)(a)), a
                    }
                    return Object(d.a)(t, e), Object(c.a)(t, [{
                        key: "handleChange",
                        value: function(e, t) {
                            this.setState(Object(R.a)({}, t, e.target.value)), "jwt" === t & this.state.generateKeyID && this.setState({
                                kid: this.getKeyID(e.target.value)
                            })
                        }
                    }, {
                        key: "getKeyID",
                        value: function(e) {
                            var t = null;
                            try {
                                t = JSON.parse(e)
                            } catch (i) {
                                t = e
                            }
                            s = "";
                            try {
                                var a = B.KEYUTIL.getKey(t),
                                    n = B.KEYUTIL.getJWKFromKey(a),
                                    s = x.a.jws.JWS.getJWKthumbprint(n)
                            } catch (i) {
                                console.log(i)
                            }
                            return s
                        }
                    }, {
                        key: "generateKeyID",
                        value: function() {
                            this.state.generateKeyID || this.setState({
                                kid: this.getKeyID(this.state.jwt)
                            }), this.setState({
                                generateKeyID: !this.state.generateKeyID
                            })
                        }
                    }, {
                        key: "updateContent",
                        value: function(e) {
                            try {
                                var t = JSON.parse(this.state.jwt)
                            } catch (i) {
                                t = this.state.jwt
                            }
                            try {
                                var a = B.KEYUTIL.getKey(t),
                                    n = B.KEYUTIL.getJWKFromKey(a);
                                this.setState({
                                    jwt: JSON.stringify(n)
                                });
                                var s = x.a.jws.JWS.getJWKthumbprint(n);
                                this.setState({
                                    kid: s
                                })
                            } catch (i) {}
                            e.preventDefault(), this.state.editMode ? this.setState({
                                editMode: !1
                            }) : this.setState({
                                editMode: !0
                            })
                        }
                    }, {
                        key: "deleteContent",
                        value: function() {
                            console.log("deleting"), this.props.deleteCB(!1)
                        }
                    }, {
                        key: "submitContent",
                        value: function(e) {
                            e.preventDefault(), this.props.isUnique(this.state.kid) ? this.props.submitContent(this.state.kid, this.state.jwt) : alert("Key ID must be unique")
                        }
                    }, {
                        key: "render",
                        value: function() {
                            var e = this,
                                t = {
                                    animationDelay: this.props.delay
                                };
                            return s.a.createElement("div", {
                                id: "editEntry"
                            }, s.a.createElement("div", {
                                className: "animated animatedFadeInUp fadeInUp keyEntry editEntry",
                                value: this.state.value,
                                style: t
                            }, s.a.createElement("div", {
                                className: "jwtContent"
                            }, s.a.createElement("button", {
                                id: "editDeleteButton",
                                className: "editingButton",
                                onClick: this.deleteContent
                            }, "X"), s.a.createElement("form", {
                                onSubmit: this.submitContent
                            }, s.a.createElement("div", {
                                className: "kidBox"
                            }, s.a.createElement("div", {
                                className: "kidBox"
                            }, "Key ID: "), s.a.createElement("input", {
                                value: this.state.kid,
                                className: "editInput",
                                onChange: function(t) {
                                    return e.handleChange(t, "kid")
                                }
                            })), s.a.createElement("div", null, s.a.createElement("div", {
                                className: "kidBox"
                            }, "Public Key: "), s.a.createElement("textarea", {
                                value: this.state.jwt,
                                className: "editInput jwtTextArea",
                                onChange: function(t) {
                                    return e.handleChange(t, "jwt")
                                }
                            }))), s.a.createElement("span", null, "Generate Key ID: "), s.a.createElement("button", {
                                className: "editModeButton checkBox " + (this.state.generateKeyID ? "checkBoxPressed" : ""),
                                onClick: this.generateKeyID
                            }), s.a.createElement("button", {
                                className: "clickButton",
                                onClick: this.submitContent
                            }, "Submit"))))
                        }
                    }]), t
                }(n.Component),
                K = Object(O.getBaseUrl)(),
                L = function(e) {
                    function t(e) {
                        var a;
                        return Object(o.a)(this, t), (a = Object(l.a)(this, Object(u.a)(t).call(this, e))).deleteContent = function(e) {
                            a.setState((function(t) {
                                var a = t.jwtJson;
                                return console.log(a), {
                                    jwtJson: a.filter((function(t) {
                                        return Object.keys(t)[0] !== e
                                    }))
                                }
                            }), (function() {
                                a.deleteData(e)
                            }))
                        }, a.exitNewItem = function(e) {
                            a.setState({
                                createNew: !1
                            }), a.setState({
                                editing: ""
                            })
                        }, a.state = {
                            jwtJson: [],
                            createNew: !1,
                            editing: ""
                        }, a.deleteContent = a.deleteContent.bind(Object(v.a)(a)), a.newItem = a.newItem.bind(Object(v.a)(a)), a.exitNewItem = a.exitNewItem.bind(Object(v.a)(a)), a.isUnique = a.isUnique.bind(Object(v.a)(a)), a.updateIdCB = a.updateIdCB.bind(Object(v.a)(a)), a.returnItem = a.returnItem.bind(Object(v.a)(a)), a.submitContent = a.submitContent.bind(Object(v.a)(a)), a.saveData = a.saveData.bind(Object(v.a)(a)), a.initData = a.initData.bind(Object(v.a)(a)), a
                    }
                    return Object(d.a)(t, e), Object(c.a)(t, [{
                        key: "componentDidMount",
                        value: function() {
                            var e = Object(f.a)(p.a.mark((function e() {
                                var t;
                                return p.a.wrap((function(e) {
                                    for (;;) switch (e.prev = e.next) {
                                        case 0:
                                            if (!this.props.doFetch) {
                                                e.next = 5;
                                                break
                                            }
                                            return e.next = 3, fetch(K + "api/public", {
                                                method: "GET",
                                                headers: {
                                                    Accept: "application/json"
                                                }
                                            }).then((function(e) {
                                                return e.json()
                                            })).catch((function(e) {
                                                console.log("Could not load data, make sure the server is running.")
                                            }));
                                        case 3:
                                            t = e.sent, this.initData(t);
                                        case 5:
                                        case "end":
                                            return e.stop()
                                    }
                                }), e, this)
                            })));
                            return function() {
                                return e.apply(this, arguments)
                            }
                        }()
                    }, {
                        key: "saveData",
                        value: function() {
                            var e = Object(f.a)(p.a.mark((function e(t) {
                                var a, n, s;
                                return p.a.wrap((function(e) {
                                    for (;;) switch (e.prev = e.next) {
                                        case 0:
                                            if (a = Object.keys(t)[0], n = t[a], s = {
                                                    id: a,
                                                    key: n
                                                }, !this.props.doFetch) {
                                                e.next = 6;
                                                break
                                            }
                                            return e.next = 6, fetch(K + "api/public", {
                                                method: "POST",
                                                headers: {
                                                    Accept: "application/json",
                                                    Content: "application/json"
                                                },
                                                body: JSON.stringify(s)
                                            }).then((function(e) {
                                                console.log("Saved the data")
                                            })).catch((function(e) {
                                                console.log("Could not save data")
                                            }));
                                        case 6:
                                        case "end":
                                            return e.stop()
                                    }
                                }), e, this)
                            })));
                            return function(t) {
                                return e.apply(this, arguments)
                            }
                        }()
                    }, {
                        key: "deleteData",
                        value: function() {
                            var e = Object(f.a)(p.a.mark((function e(t) {
                                return p.a.wrap((function(e) {
                                    for (;;) switch (e.prev = e.next) {
                                        case 0:
                                            if (!this.props.doFetch) {
                                                e.next = 4;
                                                break
                                            }
                                            return e.next = 3, fetch(K + "api/public/" + t, {
                                                method: "DELETE",
                                                headers: {
                                                    Accept: "application/json",
                                                    Content: "application/json"
                                                }
                                            }).then((function(e) {
                                                console.log("Deleted the data")
                                            })).catch((function(e) {
                                                console.log("Could not save data")
                                            }));
                                        case 3:
                                        case 4:
                                        case "end":
                                            return e.stop()
                                    }
                                }), e, this)
                            })));
                            return function(t) {
                                return e.apply(this, arguments)
                            }
                        }()
                    }, {
                        key: "editData",
                        value: function() {
                            var e = Object(f.a)(p.a.mark((function e(t, a) {
                                var n, s, i;
                                return p.a.wrap((function(e) {
                                    for (;;) switch (e.prev = e.next) {
                                        case 0:
                                            if (n = Object.keys(a)[0], s = a[n], i = {
                                                    id: n,
                                                    key: JSON.stringify(s)
                                                }, !this.props.doFetch) {
                                                e.next = 7;
                                                break
                                            }
                                            return e.next = 6, fetch(K + "api/public/" + t, {
                                                method: "PUT",
                                                headers: {
                                                    Accept: "application/json",
                                                    Contetn: "application/json"
                                                },
                                                body: JSON.stringify(i)
                                            }).then((function(e) {
                                                console.log("Saved the data")
                                            })).catch((function(e) {
                                                console.log("Could not save data")
                                            }));
                                        case 6:
                                        case 7:
                                        case "end":
                                            return e.stop()
                                    }
                                }), e, this)
                            })));
                            return function(t, a) {
                                return e.apply(this, arguments)
                            }
                        }()
                    }, {
                        key: "initData",
                        value: function(e) {
                            if (e) {
                                var t = [];
                                Object.keys(e).map((function(a) {
                                    var n = e[a].id;
                                    t.push(Object(R.a)({}, n, e[a].key))
                                })), this.setState({
                                    jwtJson: t
                                })
                            }
                        }
                    }, {
                        key: "updateIdCB",
                        value: function(e, t, a) {
                            var n = this,
                                s = !0;
                            this.state.jwtJson.map((function(t) {
                                JSON.stringify(t[e]) == JSON.stringify(a) && (s = !1)
                            })), s && this.setState((function(n) {
                                return {
                                    jwtJson: n.jwtJson.map((function(n) {
                                        return Object.keys(n)[0] == e ? (console.log(a), console.log(n[e]), Object(R.a)({}, t, JSON.stringify(a))) : n
                                    }))
                                }
                            }), (function() {
                                return n.editData(e, Object(R.a)({}, t, a))
                            }))
                        }
                    }, {
                        key: "newItem",
                        value: function() {
                            this.setState({
                                createNew: !0
                            }), this.setState({
                                editing: "editing"
                            })
                        }
                    }, {
                        key: "isUnique",
                        value: function(e) {
                            return 0 === this.state.jwtJson.filter((function(t) {
                                return Object.keys(t)[0] == e
                            })).length
                        }
                    }, {
                        key: "submitContent",
                        value: function(e, t) {
                            var a = this;
                            this.setState({
                                createNew: !1
                            }), this.setState({
                                editing: ""
                            });
                            var n = Object(R.a)({}, e, t);
                            this.setState((function(e) {
                                return {
                                    jwtJson: [n].concat(Object(I.a)(e.jwtJson))
                                }
                            }), (function() {
                                a.saveData(Object(R.a)({}, e, t))
                            }))
                        }
                    }, {
                        key: "returnItem",
                        value: function() {
                            if (this.state.createNew) return s.a.createElement(T, {
                                deleteCB: this.exitNewItem,
                                isUnique: this.isUnique,
                                submitContent: this.submitContent
                            })
                        }
                    }, {
                        key: "render",
                        value: function() {
                            var e, t, a = this,
                                n = 0;
                            return s.a.createElement("div", {
                                className: "publicKeyInterface"
                            }, s.a.createElement("div", {
                                className: "button-wrapper"
                            }, s.a.createElement("button", {
                                id: "addButton",
                                className: "newEntryButton",
                                onClick: this.newItem
                            }, s.a.createElement("span", {
                                className: "glyphicon glyphicon-plus-sign"
                            }))), s.a.createElement("div", {
                                className: "button-wrapper"
                            }, s.a.createElement("button", {
                                className: "newEntryButton reloadButton",
                                onClick: this.initData
                            }, s.a.createElement("span", {
                                className: "glyphicon glyphicon-retweet"
                            }))), s.a.createElement("div", {
                                className: "borderDiv"
                            }), this.returnItem(), this.state.jwtJson.map((function(i) {
                                return e = Object.keys(i)[0], n += .2, t = i[e], s.a.createElement(q, {
                                    extraClass: a.state.editing,
                                    deleteCB: a.deleteContent,
                                    updateIdCB: a.updateIdCB,
                                    kid: e,
                                    delay: n + "s",
                                    jwt: t,
                                    key: e
                                })
                            })))
                        }
                    }]), t
                }(n.Component),
                J = (a(20), function(e) {
                    function t(e) {
                        var a;
                        return Object(o.a)(this, t), (a = Object(l.a)(this, Object(u.a)(t).call(this, e))).state = {
                            data: {},
                            edit: a.props.edit,
                            deleteConfirm: !1
                        }, a.handleRuleDeletePre = a.handleRuleDeletePre.bind(Object(v.a)(a)), a.handleRuleDelete = a.handleRuleDelete.bind(Object(v.a)(a)), a.handleRuleEdit = a.handleRuleEdit.bind(Object(v.a)(a)), a.handleUpdate = a.handleUpdate.bind(Object(v.a)(a)), a.handleEnter = a.handleEnter.bind(Object(v.a)(a)), a
                    }
                    return Object(d.a)(t, e), Object(c.a)(t, [{
                        key: "componentDidMount",
                        value: function() {
                            var e = this.props.data;
                            Object.keys(e).forEach((function(t) {
                                null == e[t] && (e[t] = "-")
                            })), this.setState({
                                data: e
                            })
                        }
                    }, {
                        key: "handleRuleDelete",
                        value: function() {
                            var e = this;
                            fetch("/api/data/" + this.state.data.id, {
                                method: "DELETE"
                            }).then((function(e) {
                                return e.json()
                            })).then((function(t) {
                                t >= 0 && e.props.handleDeleteCB(e.state.data.id)
                            })).catch((function(e) {
                                console.log(e)
                            }))
                        }
                    }, {
                        key: "handleRuleDeletePre",
                        value: function() {
                            this.setState({
                                deleteConfirm: !this.state.deleteConfirm
                            })
                        }
                    }, {
                        key: "handleRuleEdit",
                        value: function() {
                            console.log(this.state.data), this.state.edit && fetch("/api/data/" + this.state.data.id, {
                                method: "PUT",
                                body: JSON.stringify(this.state.data),
                                headers: {
                                    "Content-Type": "application/json"
                                }
                            }).then((function(e) {
                                console.log(e.body)
                            })).catch((function(e) {
                                console.log(e)
                            })), this.setState({
                                edit: !this.state.edit
                            })
                        }
                    }, {
                        key: "handleUpdate",
                        value: function(e, t) {
                            var a = this.state.data;
                            a[t] = e.target.value, this.setState({
                                data: a
                            })
                        }
                    }, {
                        key: "handleEnter",
                        value: function(e) {
                            "Enter" === e.key && this.handleRuleEdit()
                        }
                    }, {
                        key: "render",
                        value: function() {
                            var e = this;
                            return s.a.createElement("tr", null, s.a.createElement("td", null, this.state.edit ? s.a.createElement("input", {
                                onKeyPress: this.handleEnter,
                                onChange: function(t) {
                                    e.handleUpdate(t, "infoLink")
                                },
                                className: "informationInput formInput",
                                placeholder: this.state.data.infoLink
                            }) : this.state.data.payor), s.a.createElement("td", null, this.state.edit ? s.a.createElement("input", {
                                onKeyPress: this.handleEnter,
                                onChange: function(t) {
                                    e.handleUpdate(t, "equipmentCode")
                                },
                                className: "codeInput formInput",
                                placeholder: this.state.data.equipmentCode
                            }) : this.state.data.code), s.a.createElement("td", {
                                title: this.state.data.codeSystem
                            }, this.state.edit ? s.a.createElement("input", {
                                onKeyPress: this.handleEnter,
                                onChange: function(t) {
                                    e.handleUpdate(t, "codeSystem")
                                },
                                className: "formInput",
                                placeholder: this.state.data.codeSystem
                            }) : s.a.createElement("span", null, y.codeSystemConversion[this.state.data.codeSystem])), s.a.createElement("td", null, s.a.createElement("a", {
                                href: this.state.data.link
                            }, "download")), s.a.createElement("td", null, s.a.createElement("a", {
                                href: this.state.data.editLink
                            }, "edit")))
                        }
                    }]), t
                }(n.Component)),
                H = Object(O.getBaseUrl)(),
                M = function(e) {
                    function t(e) {
                        var a;
                        return Object(o.a)(this, t), (a = Object(l.a)(this, Object(u.a)(t).call(this, e))).state = {
                            rules: {},
                            editId: null
                        }, a.handleDeleteCB = a.handleDeleteCB.bind(Object(v.a)(a)), a.buttonStuff = a.buttonStuff.bind(Object(v.a)(a)), a
                    }
                    return Object(d.a)(t, e), Object(c.a)(t, [{
                        key: "componentDidMount",
                        value: function() {
                            var e = this;
                            document.body.style.backgroundColor = "white";
                            var t = fetch(H + "api/data", {
                                method: "GET",
                                headers: {
                                    Accept: "application/json"
                                }
                            }).then((function(e) {
                                return e.json()
                            })).then((function(t) {
                                console.log(t), e.setState({
                                    rules: t
                                })
                            })).catch((function(e) {
                                console.log(e), console.log("Couldn't load data, make sure the server is running.")
                            }));
                            console.log(t)
                        }
                    }, {
                        key: "handleDeleteCB",
                        value: function(e) {
                            console.log(e), this.setState({
                                rules: this.state.rules.filter((function(t) {
                                    return t.id !== e
                                }))
                            })
                        }
                    }, {
                        key: "buttonStuff",
                        value: function() {
                            var e = this,
                                t = this.state.rules,
                                a = {
                                    id: null,
                                    ageRangeLow: null,
                                    ageRangeHigh: null,
                                    genderCode: null,
                                    equipmentCode: "",
                                    codeSystem: "",
                                    patientAddressState: "",
                                    providerAddressState: "",
                                    noAuthNeeded: "",
                                    infoLink: ""
                                };
                            fetch(H + "api/data/", {
                                method: "POST",
                                body: JSON.stringify(a),
                                headers: {
                                    "Content-Type": "application/json"
                                }
                            }).then((function(e) {
                                return e.text()
                            })).then((function(e) {
                                return e
                            })).catch((function(e) {
                                console.log(e)
                            })).then((function(n) {
                                a.id = n, e.setState({
                                    editId: n
                                }), t.unshift(a), e.setState({
                                    rules: t
                                })
                            }))
                        }
                    }, {
                        key: "render",
                        value: function() {
                            var e = this;
                            return s.a.createElement("div", {
                                className: "dataTable"
                            }, s.a.createElement("div", null, s.a.createElement("table", {
                                className: "table-responsive table-striped table"
                            }, s.a.createElement("thead", null, s.a.createElement("tr", null, s.a.createElement("td", null, "Payor"), s.a.createElement("td", null, "Relevant Code"), s.a.createElement("td", null, "Code System URL"), s.a.createElement("td", null, "CQL"), s.a.createElement("td", null, "Edit"))), s.a.createElement("tbody", null, this.state.rules instanceof Array ? this.state.rules.map((function(t) {
                                return s.a.createElement(J, {
                                    data: t,
                                    handleDeleteCB: e.handleDeleteCB,
                                    key: t.id,
                                    edit: t.id === e.state.editId,
                                    home: e.props.home
                                })
                            })) : null))))
                        }
                    }]), t
                }(n.Component),
                P = Object(O.getBaseUrl)(),
                U = Object(O.getHostOrg)(),
                A = [{
                    name: "FHIR STU3 endpoint",
                    link: P + "crd/stu3/cds-services",
                    ui_link:"/stu3/cds-services",
                    description: "The provider systems would interact with the CDS Hooks endpoints. These endpoints provide the JSON descriptions of the CDS Hooks services."
                }, {
                    name: "FHIR R4 endpoint",
                    link: P + "crd/r4/cds-services",
                    ui_link:"/r4/cds-services",
                    description: "The provider systems would interact with the CDS Hooks endpoints. These endpoints provide the JSON descriptions of the CDS Hooks services."
                }, {
                    name: "Rules endpoint",
                    link: P + "crd/api/data",
                    ui_link:"/api/data",
                    description: "Endpoint for retrieving and manipulating rules."
                }, {
                    name: "Requests endpoint",
                    link: P + "crd/api/requests",
                    ui_link:"/api/requests",
                    description: "Endpoint for retrieving the requests made to the server as JSON."
                }, {
                    name: "Public Key endpoint",
                    link: P + "crd/api/public",
                    ui_link:"/api/public",
                    description: "Endpoint for retrieving keys from and adding keys to the server database"
                }],
                F = function(e) {
                    function t(e) {
                        var a;
                        return Object(o.a)(this, t), (a = Object(l.a)(this, Object(u.a)(t).call(this, e))).state = {
                            requestInfo: {}
                        }, a
                    }
                    return Object(d.a)(t, e), Object(c.a)(t, [{
                        key: "componentDidMount",
                        value: function() {
                            document.body.style.marginLeft = "15px"
                        }
                    }, {
                        key: "displayHostTest",
                        value: function() {
                            switch (U) {
                                case "AHRQ":
                                    return s.a.createElement("p", null, "This server hosts the prototype of the Documentation Requirement Lookup Service (DRLS) clinical decision support (CDS) service. The DRLS CDS Service is a software project that conforms to the implementation guides for ", s.a.createElement("a", {
                                        href: "http://build.fhir.org/ig/HL7/davinci-crd/"
                                    }, "Coverage Requirements Discovery (CRD)"), " and ", s.a.createElement("a", {
                                        href: "http://build.fhir.org/ig/HL7/davinci-dtr/"
                                    }, "Documentation Templates and Rules (DTR)"), " developed by the MITRE Corporation for the Centers for Medicare & Medicaid Services (CMS), and under the ", s.a.createElement("a", {
                                        href: "http://www.hl7.org/about/davinci/index.cfm?ref=common"
                                    }, "Da Vinci Project"), " within the ", s.a.createElement("a", {
                                        href: "http://www.hl7.org/"
                                    }, "HL7 standards developing organization"), ". It was developed in support of the ", s.a.createElement("a", {
                                        href: "https://www.cms.gov/Research-Statistics-Data-and-Systems/Monitoring-Programs/Medicare-FFS-Compliance-Programs/LookupServiceInitiative.html"
                                    }, "DRLS Initiative"), " led by CMS, with hosting provided by the ", s.a.createElement("a", {
                                        href: "https://www.ahrq.gov/"
                                    }, "Agency for Healthcare Research and Quality (AHRQ)"), " as part of an inter-agency collaboration. In addition, several DRLS CDS artifacts are being hosted on AHRQ\u2019s ", s.a.createElement("a", {
                                        href: "https://cds.ahrq.gov/"
                                    }, "CDS Connect"), " repository.", s.a.createElement("br", null), s.a.createElement("br", null), "CRD is implemented with ", s.a.createElement("a", {
                                        href: "https://cds-hooks.org/",
                                        target: "#"
                                    }, "CDS Hooks"), ". It returns responses to CRD queries based on a small database of example rules. The example rules can be managed through the ", s.a.createElement("a", {
                                        href: "/data"
                                    }, "administrative interface"), ".");
                                case "HSPC":
                                    return s.a.createElement("p", null, "This server hosts the prototype of the Documentation Requirement Lookup Service (DRLS) clinical decision support (CDS) service. The DRLS CDS Service is a software project that conforms to the implementation guides for ", s.a.createElement("a", {
                                        href: "http://build.fhir.org/ig/HL7/davinci-crd/"
                                    }, "Coverage Requirements Discovery (CRD)"), " and ", s.a.createElement("a", {
                                        href: "http://build.fhir.org/ig/HL7/davinci-dtr/"
                                    }, "Documentation Templates and Rules (DTR)"), " developed by the MITRE Corporation for the Centers for Medicare & Medicaid Services (CMS), and under the ", s.a.createElement("a", {
                                        href: "http://www.hl7.org/about/davinci/index.cfm?ref=common"
                                    }, "Da Vinci Project"), " within the ", s.a.createElement("a", {
                                        href: "http://www.hl7.org/"
                                    }, "HL7 standards developing organization"), ". It was developed in support of the ", s.a.createElement("a", {
                                        href: "https://www.cms.gov/Research-Statistics-Data-and-Systems/Monitoring-Programs/Medicare-FFS-Compliance-Programs/LookupServiceInitiative.html"
                                    }, "DRLS Initiative"), " led by CMS, with hosting provided by the ", s.a.createElement("a", {
                                        href: "https://www.hspconsortium.org/"
                                    }, "Healthcare Services Platform Consortium (HSPC)"), ". In addition, several DRLS CDS artifacts are being hosted on ", s.a.createElement("a", {
                                        href: "https://www.ahrq.gov/"
                                    }, "Agency for Healthcare Research and Quality (AHRQ)"), "\u2019s ", s.a.createElement("a", {
                                        href: "https://cds.ahrq.gov/"
                                    }, "CDS Connect"), " repository.", s.a.createElement("br", null), s.a.createElement("br", null), "CRD is implemented with ", s.a.createElement("a", {
                                        href: "https://cds-hooks.org/",
                                        target: "#"
                                    }, "CDS Hooks"), ". It returns responses to CRD queries based on a small database of example rules. The example rules can be managed through the ", s.a.createElement("a", {
                                        href: "/data"
                                    }, "administrative interface"), ".");
                                default:
                                    return s.a.createElement("p", null, "CRD is implemented with ", s.a.createElement("a", {
                                        href: "https://cds-hooks.org/",
                                        target: "#"
                                    }, "CDS Hooks"), ". It returns responses to CRD queries based on a small database of example rules. The example rules can be managed through the ", s.a.createElement("a", {
                                        href: "/data"
                                    }, "administrative interface"), ".")
                            }
                        }
                    }, {
                        key: "render",
                        value: function() {
                            return s.a.createElement("div", null, s.a.createElement("h1", {
                                className: "header",
                                id: "henlo"
                            }, "Coverage Requirements Discovery (CRD) Reference Implementation (RI)"), this.displayHostTest(), s.a.createElement("table", {
                                className: "table"
                            }, s.a.createElement("thead", null, s.a.createElement("tr", null, s.a.createElement("th", null), s.a.createElement("th", null, "URI"), s.a.createElement("th", null, "Description"))), s.a.createElement("tbody", null, A.map((function(e) {
                                return s.a.createElement("tr", {
                                    key: e.name
                                }, s.a.createElement("th", {
                                    scope: "row"
                                }, e.name), s.a.createElement("td", null, s.a.createElement("a", {
                                    href: e.link
                                }, e.ui_link)), s.a.createElement("td", null, e.description))
                            })))))
                        }
                    }]), t
                }(n.Component),
                W = a(56),
                V = function() {
                    return s.a.createElement("div", null, s.a.createElement(L, {
                        doFetch: !0
                    }))
                },
                Q = Object(O.getBaseUrl)(),
                Y = function(e) {
                    function t() {
                        return Object(o.a)(this, t), Object(l.a)(this, Object(u.a)(t).apply(this, arguments))
                    }
                    return Object(d.a)(t, e), Object(c.a)(t, [{
                        key: "render",
                        value: function() {
                        	//Q = Q+"crd/";
                            var e = Q,
                                t = Q+ "public",
                                a = Q +"requests",
                                n = Q+ "data";
                            console.log("E,t,a,n",e,t,a,n);
                            return s.a.createElement("div", null, s.a.createElement("nav", {
                                className: "navbar navbar-fixed-top headerEntry"
                            }, s.a.createElement("div", {
                                className: "container padHelp"
                            }, s.a.createElement("span", {
                                className: "navbar-brand headerIcon"
                            }, " ", s.a.createElement("span", {
                                className: "glyphicon glyphicon-fire"
                            })), s.a.createElement("a", {
                                className: "navbar-brand headerLink " + (this.props.location.pathname == e ? "active" : ""),
                                href: e
                            }, "Home"), s.a.createElement("a", {
                                className: "navbar-brand headerLink " + (this.props.location.pathname == t ? "active" : ""),
                                href: t
                            }, "Keys"), s.a.createElement("a", {
                                className: "navbar-brand headerLink " + (this.props.location.pathname == n ? "active" : ""),
                                href: n
                            }, "Rules"), s.a.createElement("a", {
                                className: "navbar-brand headerLink " + (this.props.location.pathname == a ? "active" : ""),
                                href: a
                            }, "Log"))), s.a.createElement(h.a, {
                                exact: !0,
                                path: e,
                                component: F
                            }), s.a.createElement(h.a, {
                                path: t,
                                component: V
                            }), s.a.createElement(h.a, {
                                path: a,
                                component: D
                            }), s.a.createElement(h.a, {
                                path: n,
                                component: M
                            }))
                        }
                    }]), t
                }(n.Component),
                G = Object(W.a)(Y),
                z = Boolean("localhost" === window.location.hostname || "[::1]" === window.location.hostname || window.location.hostname.match(/^127(?:\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}$/));

            function _(e) {
                navigator.serviceWorker.register(e).then((function(e) {
                    e.onupdatefound = function() {
                        var t = e.installing;
                        t.onstatechange = function() {
                            "installed" === t.state && (navigator.serviceWorker.controller ? console.log("New content is available; please refresh.") : console.log("Content is cached for offline use."))
                        }
                    }
                })).catch((function(e) {
                    console.error("Error during service worker registration:", e)
                }))
            }
            var X = a(55);
            r.a.render(s.a.createElement(X.a, null, s.a.createElement(G, null)), document.getElementById("root")),
                function() {
                    if ("serviceWorker" in navigator) {
                        if (new URL("", window.location).origin !== window.location.origin) return;
                        window.addEventListener("load", (function() {
                            var e = "".concat("", "/service-worker.js");
                            z ? (! function(e) {
                                fetch(e).then((function(t) {
                                    404 === t.status || -1 === t.headers.get("content-type").indexOf("javascript") ? navigator.serviceWorker.ready.then((function(e) {
                                        e.unregister().then((function() {
                                            window.location.reload()
                                        }))
                                    })) : _(e)
                                })).catch((function() {
                                    console.log("No internet connection found. App is running in offline mode.")
                                }))
                            }(e), navigator.serviceWorker.ready.then((function() {
                                console.log("This web app is being served cache-first by a service worker. To learn more, visit https://goo.gl/SC7cgQ")
                            }))) : _(e)
                        }))
                    }
                }()
        },
        9: function(e, t) {
            e.exports.getBaseUrl = function() {
                var e = document.querySelector("meta[name='ctx']").getAttribute("content");
                return "string" !== typeof e && (e = "/"), e.endsWith("/") || (e += "/"), e.startsWith("/") || (e = "/" + e), e
            }, e.exports.getHostOrg = function() {
                return document.querySelector("meta[name='hostorg']").getAttribute("content")
            }
        }
    },
    [
        [28, 1, 2]
    ]
]);
//# sourceMappingURL=main.7155e7d9.chunk.js.map