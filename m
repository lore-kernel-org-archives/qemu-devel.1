Received: from eggs.gnu.org ([2001:4830:134:3::10]:35587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEYLo-00074u-DE
	for qemu-devel@nongnu.org; Fri, 04 May 2018 06:54:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEYLn-0007m2-E8
	for qemu-devel@nongnu.org; Fri, 04 May 2018 06:54:08 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:35480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEYLn-0007jd-9k
	for qemu-devel@nongnu.org; Fri, 04 May 2018 06:54:07 -0400
Received: by mail-oi0-x244.google.com with SMTP id a6-v6so18751419oia.2
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 03:54:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180504055930.3786-1-david@gibson.dropbear.id.au>
References: <20180504055930.3786-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 May 2018 11:53:45 +0100
Message-ID: <CAFEAcA-_g7O67gH_z8+E-1t-TQfQ=7YhGEoq=Jrnud8LpPxnzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/17] ppc-for-2.13 queue 20180504
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Laurent Vivier <lvivier@redhat.com>

On 4 May 2018 at 06:59, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 59255887e6cafeff747250d2613003a41d1d9dff:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180502' into staging (2018-05-03 11:25:14 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.13-20180504
>
> for you to fetch changes up to 0550b1206a91d66051a21441a02c4ff126b531fe:
>
>   spapr: don't advertise radix GTSE if max-compat-cpu < power9 (2018-05-04 15:00:37 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2018-05-04
>
> Second patch of patches for qemu-2.13 (or whatever the version ends up
> being called).  Highlights are:
>   * Preliminary patches for POWER9 hash MMU support for powernv
>   * A number of cleanups fo pseries startup and LPCR handling
>   * Remove support for explicitly allocated RMAs (which require kernel
>     support that's been gone for 3+ years)
>   * Some mac_newworld cleanups
>   * A few bugfixes

Applied, thanks.

-- PMM
