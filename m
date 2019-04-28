Received: from eggs.gnu.org ([209.51.188.92]:56155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hKhGu-0000io-Ep
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 06:43:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hKhGs-0000fH-HM
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 06:43:00 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:44362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hKhGq-0000eP-3p
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 06:42:56 -0400
Received: by mail-ot1-x32a.google.com with SMTP id d24so6246580otl.11
	for <qemu-devel@nongnu.org>; Sun, 28 Apr 2019 03:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 28 Apr 2019 11:42:42 +0100
Message-ID: <CAFEAcA-Psn1mhZBfO7de01VL6FfWZC8C87O1qvG0Vn_u31bZew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/36] ppc-for-4.1 queue 20190426
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: gkurz@kaod.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>

On Fri, 26 Apr 2019 at 07:06, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 3284aa128153750f14a61e8a96fd085e6f2999b6:
>
>   Merge remote-tracking branch 'remotes/lersek/tags/edk2-pull-2019-04-22' into staging (2019-04-24 13:19:41 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-4.1-20190426
>
> for you to fetch changes up to aaef873b130f4f9c78f8e97b69c235c81b8b8b88:
>
>   target/ppc: improve performance of large BAT invalidations (2019-04-26 11:37:57 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2019-04-26
>
> Here's the first ppc target pull request for qemu-4.1.  This has a
> number of things that have accumulated while qemu-4.0 was frozen.
>
>  * A number of emulated MMU improvements from Ben Herrenschmidt
>
>  * Assorted cleanups fro Greg Kurz
>
>  * A large set of mostly mechanical cleanups from me to make target/ppc
>    much closer to compliant with the modern coding style
>
>  * Support for passthrough of NVIDIA GPUs using NVLink2
>
> As well as some other assorted fixes.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM
