Received: from eggs.gnu.org ([2001:4830:134:3::10]:35224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cr161-0005hC-G8
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:40:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cr160-0008Oc-Lk
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:40:01 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:36552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cr160-0008OI-Fi
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:40:00 -0400
Received: by mail-wr0-x234.google.com with SMTP id u108so145362325wrb.3
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 04:40:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490198476-12244-1-git-send-email-mst@redhat.com>
References: <1490198476-12244-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Mar 2017 11:39:38 +0000
Message-ID: <CAFEAcA9Hnqsc5fNX7SeVjazRrhe451crAfKEHHPAPP7NqgM1Sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/4] virtio, pc: fixes
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

On 22 March 2017 at 16:01, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit 55a19ad8b2d0797e3a8fe90ab99a9bb713824059:
>
>   Update version for v2.9.0-rc1 release (2017-03-21 17:13:29 +0000)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 807211b76603b094c46a0cd95a3c785f47f3ab73:
>
>   hw/acpi/vmgenid: prevent more than one vmgenid device (2017-03-22 17:56:00 +0200)
>
> ----------------------------------------------------------------
> virtio, pc: fixes
>
> virtio and misc fixes for 2.9.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
