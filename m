Received: from eggs.gnu.org ([2001:4830:134:3::10]:53603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elI6B-0008L9-Aj
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:41:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elI69-0006J3-S0
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:41:03 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:42431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1elI69-0006IZ-Mk
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:41:01 -0500
Received: by mail-oi0-x241.google.com with SMTP id u6so11788949oiv.9
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 09:41:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180212034054.23441-1-david@gibson.dropbear.id.au>
References: <20180212034054.23441-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Feb 2018 17:40:40 +0000
Message-ID: <CAFEAcA8hr5mhNfYAcmJZENo7v83W3ZYDk2oA=tNQrFYscRawiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/12] ppc-for-2.12 queue 20180212
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>

On 12 February 2018 at 03:40, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit c7b02d7d032d6022060e4b393827c963c93ce63f:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-travis-speedup-090218-1' into staging (2018-02-09 16:12:34 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180212
>
> for you to fetch changes up to 51f233ec92cdab7030cb7407dd7f009911c805b0:
>
>   misc: introduce new mos6522 VIA device and enable it for ppc builds (2018-02-11 10:18:52 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2018-02-12
>
> Here's the accumulatead ppc and pseries related patches for the last
> while.  Highlights are:
>     * A number of Macintosh / CUDA cleanups from Mark Cave-Ayland
>     * An important bug fix (missing "break;") for
>       H_GET_CPU_CHARACTERISTICS
>     * Yet another fix for SMT mode handling
>     * Assorted other cleanups and fixes

Applied, thanks.

-- PMM
