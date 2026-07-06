/**
 * 로그 수집 클라이언트
 *
 * | DATE       | NAME   | DESC     |
 * |------------|--------|----------|
 * | 2025.06.27 | 윤창기 | 최초생성 |
 */
/* **********************************************
	Logger.init(); //로그수집 초기화
	Logger.captureMessage("[Logger] 메세지 호출");
	try {
		throw new Error("[Logger] 예외 호출");
	} catch (e) {
		Logger.captureException(e);
	}
********************************************** */
//TODO: SIWEB/webapp/siw/common/biz/common.js 에 추가

class Logger { // 로그 분석용 스트립트
	static sessionId = Logger.getOrCreateSessionId();
	static endpoint = '/common/logger/Logger.jsp';
	static isInitialized = false;
	static breadcrumbs = [];
	static maxBreadcrumbs = 50;
	static lastUrl = location.pathname + location.search + location.hash;
	static userName = "";
	static menuTitle = "";

	static init(config = {}) {
		console.log('[Logger] 초기화');
		if (Logger.isInitialized) return;
		if (config.endpoint) Logger.endpoint = config.endpoint;

		// TODO: TEXT입력 EventListener추가
		window.addEventListener('load', Logger.handleLoad.bind(this));
		window.addEventListener('click', Logger.handleClick);
		window.addEventListener('error', Logger.handleError);
		window.addEventListener('unhandledrejection', Logger.handlePromiseRejection);

		Logger.hookXHR();
		Logger.hookNavigation();
		Logger.isInitialized = true;
	}

	// 웹페이지 모든 객체가 로드된 후 이벤트 핸들
	static handleLoad(event) {
		Logger.getUserName();
		Logger.getMenuTitle();
	}

	// TODO: SIWEB 사용자명 추출
	static getUserName() {
		if (typeof SIDATA !== 'undefined') {
			Logger.userName = SIDATA[1]; // 사용자명
		}
	}

	// TODO: SIWEB Gnb 메뉴 타이틀 추출
	static getMenuTitle() {
		const sGnbList = document.querySelector('.sGnbList');
		if (!sGnbList) return;

		const links = sGnbList.querySelectorAll('a');
		if (!links) return;

		// Gnb 메뉴 타이틀 추출
		const depths = Array.from(links).map(link => link.innerText);
		Logger.menuTitle = depths.join(' > ');
	}

	// 클릭 이벤트 핸들
	static handleClick(event) {
		const target = event.target;
		let isAdded = false;
		let valueInfo = "";

		// TODO: 폼컨트롤 객체만 추가
		if (target.tagName === 'INPUT') {
			const type = target.type;
			if (['text', 'password', 'email', 'number', 'search'].includes(type)) {
				valueInfo = `value="${target.value}"`;
			} else if (type === 'checkbox') {
				valueInfo = `checked=${target.checked} ${Logger.getLabel(target)}`;
			} else if (type === 'radio') {
				valueInfo = `selected=${target.checked} ${Logger.getLabel(target)}`;
			} else if (type === 'submit' || type === 'button') {
				valueInfo = `value="${target.value}"`;
			}
			isAdded = true;
		} else if (target.tagName === 'TEXTAREA') {
			valueInfo = `value="${target.value}"`;
			isAdded = true;
		} else if (target.tagName === 'SELECT') {
			const selectedOption = target.options[target.selectedIndex];
			valueInfo = `selected="${selectedOption?.value}"`;
			isAdded = true;
		} else if (['BUTTON', 'A', 'SPAN'].includes(target.tagName)) {
			// SPAN: SELECT박스를 SPAN처리하므로 추가 (계좌콤보...)
			valueInfo = `text="${target.innerText.trim()}"`;
			isAdded = true;
		}

		if (isAdded) {
			const idStr = target.id ? `#${target.id}` : '';
			const classStr = target.className ? `.${target.className}` : '';
			
			Logger.addBreadcrumb({
				type: 'click',
				category: 'ui.click',
				message: `${target.tagName}${idStr}${classStr} ${valueInfo}`,
				timestamp: new Date().toISOString()
			});
		}
	}

	// TODO: checkbox, radio의 label 정보
	static getLabel(target) {
		if (!target.id) return "";
		const label = document.querySelector(`label[for="${target.id}"]`);
		return label ? `label=${label.textContent}` : "";
	}

	// 에러 핸들 (일반 스크립트/네트워크 오류 감지)
	static handleError(event) {
		Logger.captureException(event.error || {
			message: event.message,
			stack: `at ${event.filename}:${event.lineno}:${event.colno}`
		});
	}

	// Promise가 Rejected 경우 에러 핸들 (ajax 오류)
	static handlePromiseRejection(event) {
		console.dir("handlePromiseRejection");
		const reason = event.reason || {};
		Logger.captureException({
			message: reason.message || String(reason),
			stack: reason.stack || null
		});
	}

	// breadcrumbs 추가
	static addBreadcrumb(breadcrumb) {
		if (Logger.breadcrumbs.length >= Logger.maxBreadcrumbs) {
			Logger.breadcrumbs.shift();
		}
		Logger.breadcrumbs.push(breadcrumb);
	}

	// breadcrumbs 초기화
	static clearBreadcrumb() {
		Logger.breadcrumbs.length = 0;
	}

	// 메세지 호출
	static captureMessage(message, level = 'info') {
		Logger.send({
			type: 'message',
			message,
			level,
			breadcrumbs: Logger.breadcrumbs.slice(),
			timestamp: new Date().toISOString(),
			sessionId: Logger.sessionId,
			userAgent: navigator.userAgent,
			path: window.location.pathname,
			userName: Logger.userName,
			menuTitle: Logger.menuTitle
		});
	}

	// 예외 호출
	static captureException(error) {
		Logger.send({
			type: 'exception',
			message: error.message || String(error),
			stack: error.stack || null,
			breadcrumbs: Logger.breadcrumbs.slice(),
			timestamp: new Date().toISOString(),
			sessionId: Logger.sessionId,
			userAgent: navigator.userAgent,
			path: window.location.pathname,
			userName: Logger.userName,
			menuTitle: Logger.menuTitle
		});
	}

	// payload 전송
	static send(payload) {
		try {
			console.log("[Logger] 로그전송", payload);
			const xhr = new XMLHttpRequest();
			xhr.open('POST', Logger.endpoint, true);
			xhr.setRequestHeader('Content-Type', 'application/json; charset=UTF-8');
			xhr.send(JSON.stringify(payload));
		} catch (e) {
			console.warn('[Logger] 전송오류:', e);
		}
	}

	// 고유ID 추출 (TODO: id 또는 uuid로 수정)
	static getOrCreateSessionId() {
		const key = 'logger_session_id';
		let id = localStorage.getItem(key);
		if (!id) {
			id = `${Date.now()}-${Math.random().toString(36).slice(2, 10)}`;
			localStorage.setItem(key, id);
		}
		return id;
	}

	// XHR 요청 추적
	static hookXHR() {
		const originalOpen = XMLHttpRequest.prototype.open;
		const originalSend = XMLHttpRequest.prototype.send;

		XMLHttpRequest.prototype.open = function(method, url, ...rest) {
			this._loggerMethod = method; // Logger 대신 인스턴스에 저장
			this._loggerUrl = url;
			return originalOpen.apply(this, [method, url, ...rest]);
		};

		XMLHttpRequest.prototype.send = function(...args) {
			const startTime = Date.now();
			const xhr = this;

			xhr.addEventListener('loadend', () => {
				const duration = Date.now() - startTime;
				
				Logger.addBreadcrumb({
					type: 'http',
					category: 'xhr',
					data: {
						method: xhr._loggerMethod,
						url: xhr._loggerUrl,
						status: xhr.status,
						success: xhr.status >= 200 && xhr.status < 400,
						duration: duration
					},
					timestamp: new Date().toISOString()
				});

				// TODO: 자동 오류 판단
				try {
					if (xhr.status < 200 || xhr.status >= 400) {
						Logger.captureException({
							message: `XHR HTTP Error: ${xhr.status} ${xhr.statusText}`,
							stack: new Error().stack
						});
						return;
					}

					const regex = /siw.*data\.do(\?.*)?$/;
					if (regex.test(xhr._loggerUrl)) {
						console.dir("감지:" + xhr._loggerUrl);
						const contentType = xhr.getResponseHeader('Content-Type') || '';
						
						if (contentType.includes('application/json')) {
							const data = JSON.parse(xhr.responseText);
							console.dir(data);

							if (data?.body?.ErrType !== undefined && data?.body?.errorCode !== undefined) {
								const { ErrType: errType, errorCode } = data.body;
								
								if (errType !== 0 && !['Z0001', 'Z0002', 'Z0004', 'Z0037'].includes(errorCode)) {
									Logger.captureException({
										message: JSON.stringify(data.body) || 'ErrType or errorCode is false',
										stack: new Error().stack
									});
								}
							}
						}
					}
				} catch (e) {
					console.warn('[Logger] error while inspecting XHR response', e);
				}
			});

			return originalSend.apply(this, args);
		};
	}

	// Navigation 추적
	static hookNavigation() {
		const captureNav = (to) => {
			const from = Logger.lastUrl;
			if (from !== to) {
				Logger.addBreadcrumb({
					type: 'navigation',
					category: 'navigation',
					data: { from, to },
					timestamp: new Date().toISOString()
				});
				Logger.lastUrl = to;
			}
		};

		const wrapHistoryMethod = (methodName) => {
			const original = history[methodName];
			history[methodName] = function (...args) {
				const result = original.apply(this, args);
				captureNav(location.pathname + location.search + location.hash);
				return result;
			};
		};

		// 1. pushState / replaceState
		wrapHistoryMethod('pushState');
		wrapHistoryMethod('replaceState');

		// 2. popstate (뒤로/앞으로)
		window.addEventListener('popstate', () => {
			captureNav(location.pathname + location.search + location.hash);
		});

		// 3. hashchange (선택적)
		window.addEventListener('hashchange', () => {
			captureNav(location.pathname + location.search + location.hash);
		});

		// 4. 최초 진입 breadcrumb
		Logger.addBreadcrumb({
			type: 'navigation',
			category: 'navigation',
			data: { from: null, to: Logger.lastUrl },
			timestamp: new Date().toISOString()
		});
	}
}