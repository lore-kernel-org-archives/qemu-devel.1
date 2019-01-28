Received: from eggs.gnu.org ([209.51.188.92]:53951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1go4Zx-0007LE-92
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:55:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1go4Zw-0007N2-Jv
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:55:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1go4Zu-0007JM-Gn
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:55:46 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so13354712wmc.5
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 02:55:46 -0800 (PST)
References: <20190125192719.15339-1-philmd@redhat.com>
	<20190125192719.15339-3-philmd@redhat.com>
	<875zu9jo7b.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3d254f09-898e-3cf3-30e3-b232ffe9114a@redhat.com>
Date: Mon, 28 Jan 2019 11:55:44 +0100
MIME-Version: 1.0
In-Reply-To: <875zu9jo7b.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>, Kamil Rytarowski <kamil@netbsd.org>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>, Li Qiang <liq3ea@163.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 1/28/19 7:22 AM, Markus Armbruster wrote:
> Is the XXX in the subject meant to go on permanent record?

The original plan was to rename it as NOTFORMERGE before sending but I
forgot (late Friday). So the whole content of this patch isn't meant to
go on perm record ;)
