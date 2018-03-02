Received: from eggs.gnu.org ([2001:4830:134:3::10]:45935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erihc-0004q4-Rx
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:18:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erihc-0001xB-1a
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:18:16 -0500
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:41207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erihb-0001wX-Rl
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:18:15 -0500
Received: by mail-oi0-x231.google.com with SMTP id g5so6779988oiy.8
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 03:18:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1519922735-29054-1-git-send-email-mst@redhat.com>
References: <1519922735-29054-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Mar 2018 11:17:54 +0000
Message-ID: <CAFEAcA-b7pLEEPcA1WQrQVAPKeQQvJAZn0jxkg09yqc=4tqwAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/13] virtio, vhost, pci, pc: features,
 fixes and cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 1 March 2018 at 16:45, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit 8cb340c613ee3e626b070e0429c589f8a60ac657:
>
>   Merge remote-tracking branch 'remotes/famz/tags/staging-pull-request' into staging (2018-03-01 12:32:31 +0000)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 0a9b9be9eb40055d2d1bb5b8fc4d4faefecb22c3:
>
>   cryptodev-vhost-user: set the key length (2018-03-01 18:26:17 +0200)
>
> ----------------------------------------------------------------
> virtio,vhost,pci,pc: features, fixes and cleanups
>
> - documentation updates
> - vhost fixes
> - new crypto vhost device
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>

Applied, thanks.

-- PMM
