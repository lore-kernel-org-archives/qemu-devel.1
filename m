Received: from eggs.gnu.org ([209.51.188.92]:41173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmys8-0006pP-S5
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:38:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmys8-0003sZ-2A
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:38:04 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:39584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmys7-0003s3-Rp
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:38:03 -0500
Received: by mail-ot1-x331.google.com with SMTP id n8so8092759otl.6
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:38:03 -0800 (PST)
MIME-Version: 1.0
References: <20190124124906.16653-1-laurent@vivier.eu>
In-Reply-To: <20190124124906.16653-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Jan 2019 10:37:51 +0000
Message-ID: <CAFEAcA_BRPpz3mz+J-iAduVCnKrC-WajTdFWHdg65EQr9Jspvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] Trivial patches patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>, qemu-ppc <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

On Thu, 24 Jan 2019 at 12:52, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 6d809e7da943bb4b95b408fbf3d80d097c0f7d38:
>
>   Merge remote-tracking branch 'remotes/xtensa/tags/20190122-xtensa' into staging (2019-01-23 21:50:49 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/trivial-patches-pull-request
>
> for you to fetch changes up to 285816d76f37c412f391fa14a2b28a35b7cb134e:
>
>   hw/i386/pc.c: fix one typo in function name (2019-01-24 13:34:20 +0100)
>
> ----------------------------------------------------------------
> - Some typo and UTF-8 fixes
> - a ppc e6500 fix to remove duplicate SPR registering
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
