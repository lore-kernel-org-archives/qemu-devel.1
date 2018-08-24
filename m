Received: from eggs.gnu.org ([2001:4830:134:3::10]:55167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftFWZ-0005z5-0E
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 13:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftFWY-0000Lc-1F
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 13:05:26 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:47018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ftFWX-0000In-5Q
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 13:05:25 -0400
Received: by mail-oi0-x244.google.com with SMTP id y207-v6so16453359oie.13
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 10:05:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180822120050.12694-1-quintela@redhat.com>
References: <20180822120050.12694-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 18:05:03 +0100
Message-ID: <CAFEAcA9xowHzaeN=N-EsUdP8rqMtGsJR2dNerQ_59Q+32ySWsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/20] Migration pull requset
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

On 22 August 2018 at 13:00, Juan Quintela <quintela@redhat.com> wrote:
> The following changes since commit 13b7b188501d419a7d63c016e00065bcc693b7d4:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20180821-pull-request' into staging (2018-08-21 15:57:56 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/juanquintela/qemu.git tags/migration/20180822-1
>
> for you to fetch changes up to ae526e32bd36cfb84045c8d2fd34e0b9e39a52f8:
>
>   migration: hold the lock only if it is really needed (2018-08-22 12:36:18 +0200)
>
> ----------------------------------------------------------------
> migration/next for 20180822
>
> All pending patches that are reviewed:
> - doc for pr_load (dave)
> - postcopy + rdma is nearer (lidong chen)
> - compression fixes (xiao)
> - silent warning for pcc tests (Thomas)
> - fix subsection without .needed function (pmaydell)
>
> Please apply, Juan.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
