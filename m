Received: from eggs.gnu.org ([209.51.188.92]:39722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDZes-0006W4-IZ
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDZeq-0002Gr-QX
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:10:18 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDZep-0002Fo-D5
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:10:16 -0400
Received: by mail-oi1-x241.google.com with SMTP id y84so11385101oia.12
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 12:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190408163439.18818-1-kwolf@redhat.com>
In-Reply-To: <20190408163439.18818-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Apr 2019 20:10:02 +0100
Message-ID: <CAFEAcA_MXn6LXD_P3iMka_1RvXctt+CmB=bZJPnf+-Pe1Dk_zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, 8 Apr 2019 at 17:35, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit f55a585d1037e5de6088f25e75443c2776786e29:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2019-04-07 14:54:55 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to ab63817119b03b95f7dce6fae036e6d063ad63fb:
>
>   hmp: Fix drive_add ... format=help crash (2019-04-08 17:42:06 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - hmp: Fix drive_add ... format=help crash
> - block: Forward 'discard' to temporary overlay
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
