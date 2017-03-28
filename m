Received: from eggs.gnu.org ([2001:4830:134:3::10]:41143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csoZU-0004WM-6L
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:41:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csoZT-0008E4-9d
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:41:52 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:35785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1csoZT-0008Dq-1d
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:41:51 -0400
Received: by mail-wr0-x22d.google.com with SMTP id u1so98185948wra.2
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 03:41:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170328100713.28785-1-stefanha@redhat.com>
References: <20170328100713.28785-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Mar 2017 11:41:29 +0100
Message-ID: <CAFEAcA9eOuoYJV0J=2078hsmtONfDNfUEOwXBWYdVBUyca0Mig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL for-2.9 0/1] Block patches
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

On 28 March 2017 at 11:07, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit eb06c9e2d3c8f026a206e8402b0ffa201060ec8e:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-03-27 17:34:50 +0100)
>
> are available in the git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to dc62da88b5d17477227a3563a6ad466129d416d6:
>
>   parallels: wrong call to bdrv_truncate (2017-03-28 11:06:00 +0100)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Denis V. Lunev (1):
>   parallels: wrong call to bdrv_truncate
>
>  block/parallels.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

-- PMM
