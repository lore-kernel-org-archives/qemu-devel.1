Received: from eggs.gnu.org ([2001:4830:134:3::10]:48842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drV88-000220-Su
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 16:16:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drV88-0004uI-6C
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 16:16:28 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:45489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1drV87-0004tz-VI
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 16:16:28 -0400
Received: by mail-wm0-x22a.google.com with SMTP id f199so48167570wme.0
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 13:16:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170911200002.4511-1-n54@gmx.com>
References: <20170911200002.4511-1-n54@gmx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2017 21:16:06 +0100
Message-ID: <CAFEAcA-5uT+vMfoNRDkHadGo-O3S-_LOmgj5_7dQgCS8NVzfvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Rename round_page() to round_pageq()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 11 September 2017 at 21:00, Kamil Rytarowski <n54@gmx.com> wrote:
> This change fixes conflict with the DragonFly BSD headers.
>
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>

What's the rationale for calling it round_pageq()
in particular?

thanks
-- PMM
