Received: from eggs.gnu.org ([2001:4830:134:3::10]:44366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGRR6-0005rU-6v
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGRR5-00038u-8R
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:50:52 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:37450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dGRR5-00035l-2K
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:50:51 -0400
Received: by mail-wm0-x22b.google.com with SMTP id d127so63471287wmf.0
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 07:50:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170531091538.21626-1-quintela@redhat.com>
References: <20170531091538.21626-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Jun 2017 15:50:27 +0100
Message-ID: <CAFEAcA9O1cQRLV69TgNH6ezk3vckRXe4+WRK_HD0Ed9yk=mjvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] Migration pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

On 31 May 2017 at 10:15, Juan Quintela <quintela@redhat.com> wrote:
> Hi
>
> This are the migration patches ready for inclusion:
> - autoconverge improvements: (felipe franciosi)
> - create savem.h
>
> Please, Apply.
>
> The following changes since commit 0748b3526e8cb78b9cd64208426bfc3d54a72b04:
>
>   Merge remote-tracking branch 'kwolf/tags/for-upstream' into staging (2017-05-30 14:15:15 +0100)
>
> are available in the git repository at:
>
>   git://github.com/juanquintela/qemu.git tags/migration/20170531
>
> for you to fetch changes up to b4a3c64b16856a018869bfd4a9ed3b2a74554541:
>
>   migration: use dirty_rate_high_cnt more aggressively (2017-05-31 09:39:20 +0200)
>
> ----------------------------------------------------------------
> migration/next for 20170531
>
> ----------------------------------------------------------------
> Felipe Franciosi (4):
>       migration: keep bytes_xfer_prev init'd to zero
>       migration: set dirty_pages_rate before autoconverge logic
>       migration: set bytes_xfer_* outside of autoconverge logic
>       migration: use dirty_rate_high_cnt more aggressively
>
> Juan Quintela (1):
>       migration: Create savevm.h for functions exported from savevm.c

Applied, thanks.

-- PMM
