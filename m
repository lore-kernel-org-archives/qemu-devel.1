Received: from eggs.gnu.org ([209.51.188.92]:33020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzgE7-0001Z6-8F
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 06:21:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzgDR-0003kG-EQ
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 06:20:34 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:45569)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzgDR-0003jg-0W
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 06:20:33 -0500
Received: by mail-oi1-x22f.google.com with SMTP id t82so19138220oie.12
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 03:20:32 -0800 (PST)
MIME-Version: 1.0
References: <20190228173439.8013-1-anthony.perard@citrix.com>
In-Reply-To: <20190228173439.8013-1-anthony.perard@citrix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Mar 2019 11:20:21 +0000
Message-ID: <CAFEAcA-VyFkC3CLenqYJmssM7Keg+cMW7eenh1i=G6t8JgMTFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] xen queue 2019-02-28
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

On Thu, 28 Feb 2019 at 17:34, Anthony PERARD <anthony.perard@citrix.com> wrote:
>
> The following changes since commit 711d13d5e2e160c1c3bcbd302af6df3980a99469:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-feb-27-2019' into staging (2019-02-28 12:59:49 +0000)
>
> are available in the Git repository at:
>
>   https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20190228
>
> for you to fetch changes up to 156ac94463b42b0b9beea263af9866dfcd3683e0:
>
>   xen-block: stop leaking memory in xen_block_drive_create() (2019-02-28 17:21:12 +0000)
>
> ----------------------------------------------------------------
> Xen queue
>
> * xen-block fixes
>
> ----------------------------------------------------------------
> Paul Durrant (4):
>       dataplane/xen-block: remove dead code
>       xen-block: remove redundant assignment
>       xen-block: report error condition from vbd_name_to_disk()
>       xen-block: stop leaking memory in xen_block_drive_create()

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
