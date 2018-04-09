Received: from eggs.gnu.org ([2001:4830:134:3::10]:34226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5ZfS-0006Wf-8E
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 12:29:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5ZfR-0001OQ-Eo
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 12:29:18 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:42728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f5ZfR-0001O3-9F
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 12:29:17 -0400
Received: by mail-ot0-x244.google.com with SMTP id h55-v6so9301877ote.9
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 09:29:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523284856-251254-1-git-send-email-mst@redhat.com>
References: <1523284856-251254-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Apr 2018 17:28:56 +0100
Message-ID: <CAFEAcA8cpubDp_P9u7-1O5LqSBARvkZmVG0G2LU3+Z4HWzOfUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] virtio,vhost: fixes
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

On 9 April 2018 at 15:42, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit 0e87fdc966d05f4e5ad868034fcd8ee2a08ca62d:
>
>   Update version for v2.12.0-rc2 release (2018-04-04 20:37:20 +0100)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to d434e5ac5d70e9da7d20e50246af9251a125bdad:
>
>   virtio-serial: fix heap-over-flow (2018-04-09 17:35:46 +0300)
>
> ----------------------------------------------------------------
> virtio,vhost: fixes
>
> Add a feature flag for new protocol messages.
> Misc fixes.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
