Received: from eggs.gnu.org ([209.51.188.92]:43632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ggv8Y-0005Lb-0F
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:25:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ggv8W-0003sV-F3
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:25:57 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:33087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ggv8V-0003bJ-8K
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:25:56 -0500
Received: by mail-wm1-x32c.google.com with SMTP id r24so8950766wmh.0
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 09:25:50 -0800 (PST)
References: <20190103172151.24706-1-philmd@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190103172151.24706-1-philmd@redhat.com>
Date: Tue, 08 Jan 2019 17:25:48 +0000
Message-ID: <87ftu3ukmb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker: Use stable git tag for
 virglrenderer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, Gerd Hoffmann <kraxel@redhat.com>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Use a stable tag instead of some random commit from mainstream
> development, to avoid unexpected build failures.
>
<snip>

Queued to testing/next, thanks.

--
Alex Benn=C3=A9e
