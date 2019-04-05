Received: from eggs.gnu.org ([209.51.188.92]:60157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hCFsp-0006Dc-N8
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 23:51:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hCFso-0005G4-FT
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 23:51:15 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:33298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hCFsn-0005E3-V3
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 23:51:14 -0400
Received: by mail-ot1-x329.google.com with SMTP id j10so4441924otq.0
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 20:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190404170722.4492-1-anthony.perard@citrix.com>
In-Reply-To: <20190404170722.4492-1-anthony.perard@citrix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Apr 2019 10:51:01 +0700
Message-ID: <CAFEAcA8RUYXrFM0vFBh+Om_60g3SW0RZDGC7UT6UQ26mk3uJjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] xen queue for 4.0-rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "open list:X86" <xen-devel@lists.xenproject.org>

On Fri, 5 Apr 2019 at 00:07, Anthony PERARD <anthony.perard@citrix.com> wrote:
>
> The following changes since commit f4b37171378b0b1782570060c3411a504375d1bc:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190403' into staging (2019-04-03 13:13:30 +0100)
>
> are available in the Git repository at:
>
>   https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20190404
>
> for you to fetch changes up to 2bcd05cf24a7de34e7e265247c010977e43f40bc:
>
>   xen-block: scale sector based quantities correctly (2019-04-04 18:00:07 +0100)
>
> ----------------------------------------------------------------
> Xen queue
>
> xen-block fixes
>
> ----------------------------------------------------------------
> Paul Durrant (2):
>       xen-block: only advertize discard to the frontend when it is enabled...
>       xen-block: scale sector based quantities correctly
>
Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
