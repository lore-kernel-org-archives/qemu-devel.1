Received: from eggs.gnu.org ([2001:4830:134:3::10]:58314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX6cC-0006HN-Jc
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:30:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX6cB-0007nR-Fx
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:30:56 -0500
Received: from mail-ua0-x22f.google.com ([2607:f8b0:400c:c08::22f]:35341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cX6cB-0007n5-Bi
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:30:55 -0500
Received: by mail-ua0-x22f.google.com with SMTP id y9so206090087uae.2
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:30:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170126101954.21236-1-stefanha@redhat.com>
References: <20170126101954.21236-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 13:30:34 +0000
Message-ID: <CAFEAcA-do0fspBc1-Nig4JWVdc+ut53NtK5de1TrEPoScUfA6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/1] Block patches
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

On 26 January 2017 at 10:19, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit c7f1cf01b8245762ca5864e835d84f6677ae8b1f:
>
>   Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into staging (2017-01-25 17:54:14 +0000)
>
> are available in the git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 59c9f437c59a4bf0594ed300d28fb24c645963a5:
>
>   aio-posix: honor is_external in AioContext polling (2017-01-26 10:02:33 +0000)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Stefan Hajnoczi (1):
>   aio-posix: honor is_external in AioContext polling
>
>  aio-posix.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> --

Applied, thanks.

-- PMM
