Received: from eggs.gnu.org ([2001:4830:134:3::10]:39340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cifBQ-0007v5-80
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:39:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cifBP-0001wM-C4
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:39:04 -0500
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:33105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cifBP-0001vy-5Q
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:39:03 -0500
Received: by mail-wr0-x230.google.com with SMTP id u48so5868719wrc.0
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 02:39:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170227163447.20428-1-stefanha@redhat.com>
References: <20170227163447.20428-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Feb 2017 10:38:41 +0000
Message-ID: <CAFEAcA-uDTmXMD4x3SVpkzGmo1jvqdHfLn_UqBtPLyQLdYBPNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/4] Block patches
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

On 27 February 2017 at 16:34, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit d992f2f1368ceb92e6bfd8efece174110f4236ff:
>
>   Merge remote-tracking branch 'remotes/artyom/tags/pull-sun4v-20170226' into staging (2017-02-26 22:40:23 +0000)
>
> are available in the git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 1ab17f9f5c63c2798d707aeb22588e4fcc17b2cd:
>
>   tests-aio-multithread: use atomic_read properly (2017-02-27 14:00:53 +0000)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Paolo Bonzini (4):
>   curl: do not use aio_context_acquire/release
>   nfs: do not use aio_context_acquire/release
>   iscsi: do not use aio_context_acquire/release
>   tests-aio-multithread: use atomic_read properly

Applied, thanks.

-- PMM
