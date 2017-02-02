Received: from eggs.gnu.org ([2001:4830:134:3::10]:45839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZJ5e-0000Tg-92
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:14:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZJ5d-00070B-9C
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:14:26 -0500
Received: from mail-vk0-x236.google.com ([2607:f8b0:400c:c05::236]:34765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZJ5d-0006zq-63
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:14:25 -0500
Received: by mail-vk0-x236.google.com with SMTP id r136so12694530vke.1
	for <qemu-devel@nongnu.org>; Thu, 02 Feb 2017 07:14:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170201053440.26002-1-jcody@redhat.com>
References: <20170201053440.26002-1-jcody@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Feb 2017 15:14:04 +0000
Message-ID: <CAFEAcA-eBBuqvn2OUXdujN9GVU4dtwM3y=uTD7p0XPEDMtUBQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/5] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 1 February 2017 at 05:34, Jeff Cody <jcody@redhat.com> wrote:
> The following changes since commit a0def594286d9110a6035e02eef558cf3cf5d847:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-01-30 10:23:20 +0000)
>
> are available in the git repository at:
>
>   https://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request
>
> for you to fetch changes up to acf6e5f0962c4be670d4a93ede77423512521876:
>
>   sheepdog: reorganize check for overlapping requests (2017-02-01 00:17:20 -0500)
>
> ----------------------------------------------------------------
> Block patches
> ----------------------------------------------------------------
>
> Paolo Bonzini (5):
>   sheepdog: remove unused cancellation support
>   sheepdog: reorganize coroutine flow
>   sheepdog: do not use BlockAIOCB
>   sheepdog: simplify inflight_aio_head management
>   sheepdog: reorganize check for overlapping requests

Applied, thanks.

-- PMM
