Received: from eggs.gnu.org ([2001:4830:134:3::10]:40213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cr4YT-0001fl-03
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 11:21:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cr4YS-0007Pc-23
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 11:21:36 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:33552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cr4YR-0007PB-Ru
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 11:21:35 -0400
Received: by mail-wr0-x22d.google.com with SMTP id y90so32130426wrb.0
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 08:21:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170323095929.20140-1-cornelia.huck@de.ibm.com>
References: <20170323095929.20140-1-cornelia.huck@de.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Mar 2017 15:21:14 +0000
Message-ID: <CAFEAcA-XkrE583bh73ysEanKG=RxHw-rQ_S_K+Y0rtfUm09BUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL for-2.9 0/1] another s390x bugfix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>

On 23 March 2017 at 09:59, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> The following changes since commit 55a19ad8b2d0797e3a8fe90ab99a9bb713824059:
>
>   Update version for v2.9.0-rc1 release (2017-03-21 17:13:29 +0000)
>
> are available in the git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20170323
>
> for you to fetch changes up to a352aa62a75fcb1db35a0c71a10af3b2c1f8b89f:
>
>   target/s390x: Fix broken user mode (2017-03-23 10:49:13 +0100)
>
> ----------------------------------------------------------------
> Fix linux-user vs. cpu models.
>
> ----------------------------------------------------------------
>
> Stefan Weil (1):
>   target/s390x: Fix broken user mode
>
>  target/s390x/cpu_models.c | 2 --
>  1 file changed, 2 deletions(-)

Applied, thanks.

-- PMM
