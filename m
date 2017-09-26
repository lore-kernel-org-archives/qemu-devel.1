Received: from eggs.gnu.org ([2001:4830:134:3::10]:55709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dwx3b-0002gg-B0
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 17:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dwx3a-0005Z5-6y
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 17:06:19 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:43607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dwx3a-0005YX-0N
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 17:06:18 -0400
Received: by mail-wr0-x22c.google.com with SMTP id a43so14256539wrc.0
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 14:06:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1506406399.git.mjt@msgid.tls.msk.ru>
References: <cover.1506406399.git.mjt@msgid.tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Sep 2017 22:05:56 +0100
Message-ID: <CAFEAcA-RPHGo3-6ASrfFq5hoWLm_ETPLqOXAaLHr8MSStxTb=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/29] Trivial patches for 2017-09-26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 26 September 2017 at 07:14, Michael Tokarev <mjt@tls.msk.ru> wrote:
> This is a resend of yesterday's pull request, with two patches
> removed:
>   filter-mirror: segfault when specifying non existent device
>     (causes testsuite to fail)
>   dma/i82374: avoid double creation of i82374 device
>     (better version is in the work)
>
> and with one patch with additional R-b line:
>   remove trailing whitespace from qemu-options.hx
>
> Not resending any patches, just the cover letter.
>
> Please consider applying.
>
> Thanks,
>
> /mjt
>
> The following changes since commit 1e3ee834083227f552179f6e43902cba5a866e6b:
>
>   Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' into staging (2017-09-25 20:31:24 +0100)
>
> are available in the git repository at:
>
>   git://git.corpit.ru/qemu.git tags/trivial-patches-fetch
>
> for you to fetch changes up to 35deebb2327227d8c5f4816476befb06f6329de6:
>
>   hw/isa/pc87312: Mark the device with user_creatable = false (2017-09-26 09:11:23 +0300)
>
> ----------------------------------------------------------------
> trivial patches for 2017-09-26


Applied, thanks.

-- PMM
