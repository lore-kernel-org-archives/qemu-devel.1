Received: from eggs.gnu.org ([2001:4830:134:3::10]:58950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXrh9-00050w-Jg
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXrh8-0001dX-SO
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:23:59 -0400
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:36294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXrh8-0001dL-NK
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:23:58 -0400
Received: by mail-ot0-x229.google.com with SMTP id c15-v6so19919152otl.3
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 10:23:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180626162736.9749-1-kraxel@redhat.com>
References: <20180626162736.9749-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 18:23:37 +0100
Message-ID: <CAFEAcA_kPaGDtNxPLB8sWA8PyYxp64VmJuUwzQhX64gLYiCDCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Vga 20180626 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On 26 June 2018 at 17:27, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit e409d9a158c77c650651e8118f6c86c8dc76eba6:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2018-06-26 11:10:49 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20180626-pull-request
>
> for you to fetch changes up to fd1cfb875be551064a27d909edb406316f011f2c:
>
>   virtio-gpu-3d: Drop workaround for VIRTIO_GPU_CAPSET_VIRGL2 define (2018-06-26 16:04:17 +0200)
>
> ----------------------------------------------------------------
> vga: bugfix collection.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
