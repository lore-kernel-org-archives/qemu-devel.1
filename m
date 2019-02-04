Received: from eggs.gnu.org ([209.51.188.92]:58622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqg8L-0000P3-Gi
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:26:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqg8E-0002Ma-NE
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:25:59 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:32850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gqg8B-0001qX-Al
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:25:55 -0500
Received: by mail-ot1-x331.google.com with SMTP id i20so436376otl.0
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 07:25:17 -0800 (PST)
MIME-Version: 1.0
References: <20190204112803.11645-1-anthony.perard@citrix.com>
In-Reply-To: <20190204112803.11645-1-anthony.perard@citrix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Feb 2019 15:25:05 +0000
Message-ID: <CAFEAcA_9qzj7Pg0OQ5Q2Fy7YL-M4Fm7zutJJP3QB3jXxB+S9_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] Xen queue 20190204
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

On Mon, 4 Feb 2019 at 11:28, Anthony PERARD <anthony.perard@citrix.com> wrote:
>
> The following changes since commit b3fc0af1ff5e922d4dd7c875394dbd26dc7313b4:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-02-01 17:58:27 +0000)
>
> are available in the Git repository at:
>
>   https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20190204
>
> for you to fetch changes up to 3149f183d7ca448b1dc30fe3d4acb9e367de01bf:
>
>   xen-block: handle resize callback (2019-02-04 11:04:49 +0000)
>
> ----------------------------------------------------------------
> Xen queue
>
> * xen-block, the Xen PV backend, now handles resize.
> * configure cleanup.
> * xen-bus fix.

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
