Received: from eggs.gnu.org ([2001:4830:134:3::10]:35462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e45ee-00036e-St
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e45ee-0001Ls-2z
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:42:04 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:55227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e45ed-0001LV-Ro
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:42:03 -0400
Received: by mail-wm0-x22d.google.com with SMTP id i124so3460640wmf.3
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 06:42:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <150815978220.15244.13378023945796441528.malone@soybean.canonical.com>
References: <150712892432.28170.15132413345734525245.malonedeb@gac.canonical.com>
	<150815978220.15244.13378023945796441528.malone@soybean.canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Oct 2017 14:41:42 +0100
Message-ID: <CAFEAcA9hMkJf4tKMoZbVzxKPzCSVOb+soN9_eSGO4OT1PbPNcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Bug 1721275] Re: Support more ARM CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1721275 <1721275@bugs.launchpad.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 16 October 2017 at 14:16, Christophe Lyon
<christophe.lyon+launchpad@gmail.com> wrote:
> Thanks for PS, I thought QEMU was stricter than that.

Well, I hope we get it right, and we'll treat cases where
we get it wrong as bugs, but we're not testing...

> Regarding v[68]M, are there any plans to add support for these variants
> to QEMU?

v8M we're working on. v6M we have no plans for currently.

thankns
-- PMM
