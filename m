Received: from eggs.gnu.org ([2001:4830:134:3::10]:50819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb7Pr-0000lR-9X
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:15:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb7Pq-0000gt-Et
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:15:19 -0500
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:33270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eb7Pq-0000gc-9p
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:15:18 -0500
Received: by mail-ot0-x22d.google.com with SMTP id x15so11075475ote.0
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 08:15:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180115115309.23982-1-quintela@redhat.com>
References: <20180115115309.23982-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2018 16:14:57 +0000
Message-ID: <CAFEAcA-SxiJyKa84UwG8CESpkTXEM9AG5HqEgpPrzSFwrTPzYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/27] Migration pull
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

On 15 January 2018 at 11:52, Juan Quintela <quintela@redhat.com> wrote:
> Hi
> - rebase on top of lastest
> - fix compilation on 32bit machines
> - add Peter Xu cleanups
>
> Please, apply.
>
> The following changes since commit fd06527b80c88c8dde1b35fdc692685b68d2fd93:
>
>   Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' into staging (2018-01-15 10:39:29 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/juanquintela/qemu.git tags/migration/20180115
>
> for you to fetch changes up to 816306826a45f4d15352e32d157172af3a35899f:
>
>   migration: remove notify in fd_error (2018-01-15 12:48:13 +0100)
>
> ----------------------------------------------------------------
> migration/next for 20180115

Applied, thanks.

-- PMM
