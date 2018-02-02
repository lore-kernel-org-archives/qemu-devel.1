Received: from eggs.gnu.org ([2001:4830:134:3::10]:33981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ehgTf-0005sV-MK
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 13:54:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ehgTe-0001Ab-Qy
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 13:54:23 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:39582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ehgTe-0001AE-Md
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 13:54:22 -0500
Received: by mail-oi0-x241.google.com with SMTP id j188so15381097oib.6
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 10:54:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180202083229.6681-1-kraxel@redhat.com>
References: <20180202083229.6681-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Feb 2018 18:54:01 +0000
Message-ID: <CAFEAcA9LZZNOrxiGdSRDCfJk7WhADTarB_8-JBjiWq=g+T2FBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Vga 20180202 patches
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

On 2 February 2018 at 08:32, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit b05631954d6dfe93340d516660397e2c1a2a5dd6:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-hppa-20180131' into staging (2018-01-31 15:50:29 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20180202-pull-request
>
> for you to fetch changes up to 34e304e97576a9e17680c868c00ff524a981007b:
>
>   virtio-gpu: disallow vIOMMU (2018-02-02 08:53:22 +0100)
>
> ----------------------------------------------------------------
> virtio-gpu: disallow vIOMMU
>
> ----------------------------------------------------------------
>
> Peter Xu (1):
>   virtio-gpu: disallow vIOMMU
>
>  hw/display/virtio-gpu-pci.c | 8 +++++++-
>  hw/display/virtio-gpu.c     | 5 +++++
>  2 files changed, 12 insertions(+), 1 deletion(-)

Applied, thanks.

-- PMM
