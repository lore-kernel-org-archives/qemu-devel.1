Received: from eggs.gnu.org ([209.51.188.92]:52605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1go0Jv-0006pY-Hq
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 01:23:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1go0Jv-0001EP-2E
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 01:22:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1go0Ju-0001E5-TF
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 01:22:59 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190125192719.15339-1-philmd@redhat.com>
	<20190125192719.15339-3-philmd@redhat.com>
Date: Mon, 28 Jan 2019 07:22:48 +0100
In-Reply-To: <20190125192719.15339-3-philmd@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri,
	25 Jan 2019 20:27:18 +0100")
Message-ID: <875zu9jo7b.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/3] XXX oslib-posix: Ignore
 fcntl("/dev/null", F_SETFL, O_NONBLOCK) failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>, Kamil Rytarowski <kamil@netbsd.org>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>, Li Qiang <liq3ea@163.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

Is the XXX in the subject meant to go on permanent record?
