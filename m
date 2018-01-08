Received: from eggs.gnu.org ([2001:4830:134:3::10]:56465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYUTt-0003is-Qb
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 05:16:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYUTs-0006QD-W7
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 05:16:37 -0500
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:34386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYUTs-0006Pz-Qi
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 05:16:36 -0500
Received: by mail-oi0-x230.google.com with SMTP id a70so674696oib.1
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 02:16:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
References: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2018 10:16:15 +0000
Message-ID: <CAFEAcA_4ZBLNcJXqJ78TmEZz1FqGVqvFuL1NdR2WaWNWxhVLVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/18] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Ed Swierk <eswierk@skyportsystems.com>

On 22 December 2017 at 02:15, Jason Wang <jasowang@redhat.com> wrote:
> The following changes since commit 43ab9a5376c95c61ae898a222c4d04bdf60e239b:
>
>   hw/i386/vmport: fix missing definitions with non-log trace backends (2017-12-21 22:52:28 +0000)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 0065e915192cdf83c2700bb377e5323c2649476e:
>
>   qemu-doc: Update the deprecation information of -tftp, -bootp, -redir and -smb (2017-12-22 10:06:05 +0800)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------

Applied, thanks.

PS: just noticed, but "Ed Swierk via Qemu-devel <qemu-devel@nongnu.org>"
is a bit of an odd Author string to end up in git commit logs, so you
and/or Ed might like to fix that up for any future patches.

thanks
-- PMM
