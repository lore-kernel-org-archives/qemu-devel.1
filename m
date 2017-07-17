Received: from eggs.gnu.org ([2001:4830:134:3::10]:56084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX9Hx-0007cB-GB
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:54:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX9Ht-0002D7-1j
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:54:29 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:34878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dX9Hs-0002Cf-RM
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:54:24 -0400
Received: by mail-wm0-x22b.google.com with SMTP id w126so81962249wme.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 09:54:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170717094159.16447-1-kraxel@redhat.com>
References: <20170717094159.16447-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 17:54:03 +0100
Message-ID: <CAFEAcA9=fzu1JqtfBWjWH4gSmYWpyfAKs4J1GCc89LB9BakcQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Vga 20170717 patches
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

On 17 July 2017 at 10:41, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 6e2c46334385c7e295ac883c801c81b4925fb54f:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170711' into staging (2017-07-13 10:47:10 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20170717-pull-request
>
> for you to fetch changes up to 10750ee0d67eeebbf05822b2249969ba05b5ff4b:
>
>   virtio-gpu: skip update cursor in post_load if we don't have one (2017-07-17 11:41:23 +0200)
>
> ----------------------------------------------------------------
> virtio-gpu migration fix for 2.10
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (1):
>   virtio-gpu: skip update cursor in post_load if we don't have one
>
>  hw/display/virtio-gpu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Applied, thanks.

-- PMM
