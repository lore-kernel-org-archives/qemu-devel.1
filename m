Received: from eggs.gnu.org ([209.51.188.92]:39880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMAa1-00066k-4n
	for qemu-devel@nongnu.org; Thu, 02 May 2019 08:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMAa0-0004vp-3f
	for qemu-devel@nongnu.org; Thu, 02 May 2019 08:12:49 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:43207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMAZz-0004vK-Tb
	for qemu-devel@nongnu.org; Thu, 02 May 2019 08:12:48 -0400
Received: by mail-ot1-x334.google.com with SMTP id e108so1795511ote.10
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 05:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190501202506.13875-1-jsnow@redhat.com>
In-Reply-To: <20190501202506.13875-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 May 2019 13:12:35 +0100
Message-ID: <CAFEAcA9etUEg3E8VGTMqcfNM+5oxqnY9x8zdU_mHN+AN1og+5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Bitmaps patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

On Wed, 1 May 2019 at 21:25, John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit 46316f1dfffc6be72e94e89f7b0e9162e7dcdcf1:
>
>   Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-20190311.0' into staging (2019-03-12 13:37:29 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/jnsnow/qemu.git tags/bitmaps-pull-request
>
> for you to fetch changes up to 90edef80a0852cf8a3d2668898ee40e8970e4314:
>
>   docs/interop/bitmaps: rewrite and modernize doc (2019-05-01 16:21:24 -0400)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------
>
> John Snow (2):
>   Makefile: add nit-picky mode to sphinx-build
>   docs/interop/bitmaps: rewrite and modernize doc
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM
