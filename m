Received: from eggs.gnu.org ([2001:4830:134:3::10]:37898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dehrn-0006z1-Td
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 09:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dehri-0006Eb-Tc
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 09:14:43 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:35283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dehri-0006Dy-OY
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 09:14:38 -0400
Received: by mail-wm0-x231.google.com with SMTP id m85so6925333wma.0
	for <qemu-devel@nongnu.org>; Mon, 07 Aug 2017 06:14:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170807110407.15511-1-stefanha@redhat.com>
References: <20170807110407.15511-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Aug 2017 14:14:17 +0100
Message-ID: <CAFEAcA_6tLv8cC1+ZXupgcjQ2711jB4mEp9qFfyb+=+mnrdeGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 7 August 2017 at 12:04, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit ac44ed2afb7c60255e989b163301479f5b4ecd04:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-pull-request' into staging (2017-08-04 13:46:22 +0100)
>
> are available in the git repository at:
>
>   git://github.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to f42cf447e2310e84e119b99f7f13c8dc7a6cf3d6:
>
>   block: move trace probes into bdrv_co_preadv|pwritev (2017-08-07 09:39:35 +0100)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Daniel P. Berrange (1):
>   block: move trace probes into bdrv_co_preadv|pwritev
>
>  block/io.c         | 8 ++++----
>  block/trace-events | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)

Applied, thanks.

-- PMM
