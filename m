Received: from eggs.gnu.org ([2001:4830:134:3::10]:46538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJdbK-0002Dm-SX
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 05:58:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJdbK-0003Wt-1r
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 05:58:54 -0500
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:43377)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eJdbJ-0003WY-So
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 05:58:53 -0500
Received: by mail-ot0-x233.google.com with SMTP id 105so27028495oth.10
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 02:58:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511841669-14505-1-git-send-email-jasowang@redhat.com>
References: <1511841669-14505-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Nov 2017 10:58:32 +0000
Message-ID: <CAFEAcA_yZUmQ1uTovghcLwDX7cN1nfjzJH=iQ75CU31+DV4WBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 28 November 2017 at 04:01, Jason Wang <jasowang@redhat.com> wrote:
> The following changes since commit 5e19aed59ab48ca3c7f1e2da203eed27b91bef2d:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.11-20171127' into staging (2017-11-27 11:16:20 +0000)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 70e53e6e4da3db4b2c31981191753a7e974936d0:
>
>   virtio-net: don't touch virtqueue if vm is stopped (2017-11-28 11:54:50 +0800)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
> Jason Wang (1):
>       virtio-net: don't touch virtqueue if vm is stopped
>
>  hw/net/virtio-net.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

-- PMM
