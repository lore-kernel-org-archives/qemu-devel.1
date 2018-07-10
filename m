Received: from eggs.gnu.org ([2001:4830:134:3::10]:58640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcvV9-0007yT-NC
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 12:28:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcvV8-0008Dz-T8
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 12:28:31 -0400
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:35637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fcvV8-0008Df-N8
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 12:28:30 -0400
Received: by mail-oi0-x22a.google.com with SMTP id i12-v6so43783900oik.2
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 09:28:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180710153016.131258-1-dgilbert@redhat.com>
References: <20180710153016.131258-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Jul 2018 17:28:09 +0100
Message-ID: <CAFEAcA_4t4O6v+4rqCb40pTcuXAFQdznFvHXDfXfbAmNNS8YMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/15] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>

On 10 July 2018 at 16:30, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 2b83714d4ea659899069a4b94aa2dfadc847a013:
>
>   target/arm: Use correct mmu_idx for exception-return unstacking (2018-07-10 10:54:40 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20180710a
>
> for you to fetch changes up to 858b6d62249a9a9510fae6c808a3d2de80e689b5:
>
>   migration: reorder MIG_CMD_POSTCOPY_RESUME (2018-07-10 15:23:23 +0100)
>
> ----------------------------------------------------------------
> Migration pull 2018-07-10 (for 3.0)
>
> Migration fixes and migration test fixes, mostly
> around postcopy and postcopy recovery
>
Applied, thanks.

-- PMM
