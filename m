Received: from eggs.gnu.org ([2001:4830:134:3::10]:48477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSkNg-0007IE-DU
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 10:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSkNf-0002q5-FU
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 10:34:44 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:33690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fSkNf-0002pZ-6C
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 10:34:43 -0400
Received: by mail-oi0-x242.google.com with SMTP id c6-v6so20175900oiy.0
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 07:34:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180612064503.14282-1-david@gibson.dropbear.id.au>
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Jun 2018 15:34:22 +0100
Message-ID: <CAFEAcA85qHjDLBYxWW9i4T91m1uTS6TAY_y2A6_840n-_tDZKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/33] ppc-for-3.0 queue 20180612
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Greg Kurz <groug@kaod.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>

On 12 June 2018 at 07:44, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 2afc4e3df80d947dd1bd42ce80278f591b35c74a:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2018-06-11' into staging (2018-06-11 15:31:20 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-3.0-20180612
>
> for you to fetch changes up to 30f79dc13f116a79ff45d37ad0f5c035012064a7:
>
>   spapr_pci: Remove unhelpful pagesize warning (2018-06-12 10:44:36 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2018-06-12
>
> Here's another batch of ppc patches towards the 3.0 release.  There's
> a fair bit here, because I've been working through my mail backlog
> after a holiday.  There's not much of a central theme, amongst other
> things we have:
>     * ppc440 / sam460ex improvements
>     * logging and error cleanups
>     * 40p (PReP) bugfixes
>     * Macintosh fixes and cleanups
>     * Add emulation of the new POWER9 store-forwarding barrier
>       instruction variant
>     * Hotplug cleanups
>

Applied, thanks.

-- PMM
