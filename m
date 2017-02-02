Received: from eggs.gnu.org ([2001:4830:134:3::10]:53512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZHsR-0001LD-8Q
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 08:56:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZHsQ-0006Cx-HL
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 08:56:43 -0500
Received: from mail-vk0-x22e.google.com ([2607:f8b0:400c:c05::22e]:32833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZHsQ-0006Ck-DD
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 08:56:42 -0500
Received: by mail-vk0-x22e.google.com with SMTP id k127so11039955vke.0
	for <qemu-devel@nongnu.org>; Thu, 02 Feb 2017 05:56:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485893872-26524-1-git-send-email-mst@redhat.com>
References: <1485893872-26524-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Feb 2017 13:56:21 +0000
Message-ID: <CAFEAcA9zEaATTwGLNCB=X_mhqjapC-0jxPpv8OjDt=zqaFBnjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v5 00/22] virtio, vhost, pci: fixes, features
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

On 31 January 2017 at 20:18, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit a0def594286d9110a6035e02eef558cf3cf5d847:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-01-30 10:23:20 +0000)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 4f81928e550032f758c9b5207e403b3671da0eed:
>
>   arm: add trailing ; after MISMATCH_CHECK (2017-01-31 22:16:39 +0200)
>
> ----------------------------------------------------------------
> virtio, vhost, pci: fixes, features
>
> generic pci root port support
> disable shpc by default
> safer version of ARRAY_SIZE and QEMU_BUILD_BUG_ON
> fixes and cleanups all over the place
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>

Applied, thanks.

-- PMM
