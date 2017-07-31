Received: from eggs.gnu.org ([2001:4830:134:3::10]:35802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dc75O-0003X9-6I
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:34:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dc75N-0000OV-Bd
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:34:02 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:35538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dc75N-0000O1-2V
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:34:01 -0400
Received: by mail-wr0-x231.google.com with SMTP id k71so123124243wrc.2
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 02:34:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170731042710.19924-1-david@gibson.dropbear.id.au>
References: <20170731042710.19924-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 31 Jul 2017 10:33:39 +0100
Message-ID: <CAFEAcA8iKib1VgcPRFd1H_ppx1NCBnZWve7KdAL9go+uyC0EWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] ppc-for-2.10 queue 20170731
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Greg Kurz <groug@kaod.org>, Alexander Graf <agraf@suse.de>

On 31 July 2017 at 05:27, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit a588c4985eff363154d65aee8607d0a4601655f7:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2017-07-28' into staging (2017-07-28 18:17:44 +0100)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170731
>
> for you to fetch changes up to fc7e0765fc385eed08c19a8823a970f4e98379b0:
>
>   Revert "spapr: populate device tree depending on XIVE_EXPLOIT option" (2017-07-29 16:22:14 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2017-07-31
>
> This has a couple of last minute bugfixes for qemu 2.10.
>
> ----------------------------------------------------------------
> David Gibson (1):
>       Revert "spapr: populate device tree depending on XIVE_EXPLOIT option"
>
> Greg Kurz (1):
>       spapr_drc: fix realize and unrealize

Applied, thanks.

-- PMM
