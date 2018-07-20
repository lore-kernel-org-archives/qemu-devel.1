Received: from eggs.gnu.org ([2001:4830:134:3::10]:42929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fgRGo-0007ei-0l
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 05:00:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fgRGn-0006ZW-81
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 05:00:14 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:45905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fgRGm-0006Yh-Qh
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 05:00:13 -0400
Received: by mail-oi0-x244.google.com with SMTP id q11-v6so20036580oic.12
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 02:00:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180719162501.32641-1-stefanha@redhat.com>
References: <20180719162501.32641-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Jul 2018 09:59:51 +0100
Message-ID: <CAFEAcA_yE9Y7dZCBAGJX6UcZhBaU0wue2S2Wp-oUxq4oRDTS0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-3.0 0/1] Tracing patches
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

On 19 July 2018 at 17:25, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit ea6abffa8a08d832feb759d359d5b935e3087cf7:
>
>   Update version for v3.0.0-rc1 release (2018-07-17 18:15:19 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to db817b8c500a60873eba80cbf047900ae5b32766:
>
>   tracing: Use double-dash spelling for trace option (2018-07-19 13:09:04 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> Contains a fix to use double-dash consistently with tracing command-line
> options in documentation and output.
>
> ----------------------------------------------------------------
>
> Yaowei Bai (1):
>   tracing: Use double-dash spelling for trace option
>
>  docs/devel/tracing.txt | 6 +++---
>  trace/control.h        | 4 ++--
>  trace/control.c        | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
>

Applied, thanks.

-- PMM
