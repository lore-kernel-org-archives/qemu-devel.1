Received: from eggs.gnu.org ([209.51.188.92]:43699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDpqV-00021O-Kw
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 08:27:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDpqU-0004nX-GW
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 08:27:23 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36985)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDpqU-0004nG-9o
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 08:27:22 -0400
Received: by mail-oi1-x243.google.com with SMTP id v84so13360623oif.4
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 05:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190409070830.22430-1-david@gibson.dropbear.id.au>
In-Reply-To: <20190409070830.22430-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2019 13:27:10 +0100
Message-ID: <CAFEAcA-NnK6gm6H9bNKxopjFHbigebr9XRCFR+4=OOEgGLkjfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] ppc-for-4.0 queue 20190409
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>, spopovyc@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, clg@redhat.com

On Tue, 9 Apr 2019 at 08:08, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 5263724b78f89cdea2354c8e92c53bac1b4641a3:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-04-08 17:53:18 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-4.0-20190409
>
> for you to fetch changes up to 5cf0d326a0fec9ebac2d47c42b5f08e6bc2f686c:
>
>   spapr_pci: Fix extended config space accesses (2019-04-09 15:03:10 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2019-04-09
>
> This is a small, hard freeze, pull request which fixes a regression on
> the pseries machine handling of PCI-E extended config space accesses.
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
