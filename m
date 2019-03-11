Received: from eggs.gnu.org ([209.51.188.92]:54877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h3Nli-0004VK-1V
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:27:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h3Nlh-0006iZ-52
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:27:14 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:40298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h3Nlg-0006hr-TY
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:27:13 -0400
Received: by mail-ot1-x32c.google.com with SMTP id v20so4491247otk.7
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 09:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190311085024.13780-1-kraxel@redhat.com>
In-Reply-To: <20190311085024.13780-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Mar 2019 16:27:00 +0000
Message-ID: <CAFEAcA_JssV5iLJyJLjin7=fk-3BkpKRgxPr43zhu1dchxqZXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] Vga 20190311 v2 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On Mon, 11 Mar 2019 at 08:52, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit e2a18635a400b0e68679614132e9ef6316105590:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-03-08' into staging (2019-03-09 20:55:44 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20190311-v2-pull-request
>
> for you to fetch changes up to ff243cff11526c0703cefdd60467dfaa5c5803a0:
>
>   mips_fulong2e: Add on-board graphics chip (2019-03-11 08:04:55 +0100)
>
> ----------------------------------------------------------------
> vga: virtio reset fix, add ati emulation.
>
> ----------------------------------------------------------------
>
> BALATON Zoltan (2):
>   hw/display: Add basic ATI VGA emulation
>   mips_fulong2e: Add on-board graphics chip
>
> Gerd Hoffmann (3):
>   virtio: add class_size to VirtioPCIDeviceTypeInfo
>   virtio-vga: fix reset.
>   virtio-gpu: make virtio_gpu_reset static
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
