Received: from eggs.gnu.org ([2001:4830:134:3::10]:34128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evTJY-0002nD-Ng
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 15:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evTJY-00009K-5L
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 15:40:56 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:34930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evTJY-000091-0M
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 15:40:56 -0400
Received: by mail-ot0-x241.google.com with SMTP id r30so16549024otr.2
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 12:40:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180312105941.15439-1-kraxel@redhat.com>
References: <20180312105941.15439-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Mar 2018 19:40:34 +0000
Message-ID: <CAFEAcA9wup-UsdKv8bgaDCjC1yS=3q-BhJwLPfNT1fG7TmFaxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Vga 20180312 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 12 March 2018 at 10:59, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit e4ae62b802cec437f877f2cadc4ef059cc0eca76:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2018-03-09 17:28:16 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20180312-pull-request
>
> for you to fetch changes up to 7cdc61becd095b64a786b2625f321624e7111f3d:
>
>   vga: fix region calculation (2018-03-12 11:45:21 +0100)
>
> ----------------------------------------------------------------
> 7cdc61becd vga: fix region calculation
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (1):
>   vga: fix region calculation
>
>  hw/display/vga.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> --

Applied, thanks.

-- PMM
