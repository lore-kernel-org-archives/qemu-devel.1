Received: from eggs.gnu.org ([2001:4830:134:3::10]:53516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e49Cr-0005BD-Rx
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e49Cr-0005wK-5d
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:29:37 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:46371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e49Cq-0005vN-VW
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:29:37 -0400
Received: by mail-wm0-x232.google.com with SMTP id m72so5525097wmc.1
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 10:29:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1508036858-13479-1-git-send-email-mst@redhat.com>
References: <1508036858-13479-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Oct 2017 18:29:15 +0100
Message-ID: <CAFEAcA_ZHaPNaGqjsAuNES3t3Ytt+0Z30DoHRDRu8Fn-zFSfFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/26] pc, pci, virtio: fixes, features
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

On 15 October 2017 at 04:22, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit f90ea7ba7c5ae7010ee0ce062207ae42530f57d6:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20171012' into staging (2017-10-12 17:06:50 +0100)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to ab06ec43577177a442e8e5ca28d0154efe4ff60f:
>
>   tests/pxe: Test more NICs when running in SPEED=slow mode (2017-10-15 05:54:44 +0300)
>
> ----------------------------------------------------------------
> pc, pci, virtio: fixes, features
>
> A bunch of fixes all over the place.
> A new vmcore device - the user interface around it is still somewhat
> controversial, but I feel most of the code is fine, suggestions can be
> addressed by adding patches on top.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>

Applied, thanks.

-- PMM
