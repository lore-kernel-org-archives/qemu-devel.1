Received: from eggs.gnu.org ([2001:4830:134:3::10]:41764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezr7Q-0002Bp-Il
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 17:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezr6M-0003O0-Kr
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 17:54:32 -0400
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:46627)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ezr6M-0003Md-F0
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 17:53:26 -0400
Received: by mail-ot0-x22a.google.com with SMTP id g97-v6so16902020otg.13
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 14:53:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180323202344.70640-1-dgilbert@redhat.com>
References: <20180323202344.70640-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 24 Mar 2018 21:53:05 +0000
Message-ID: <CAFEAcA80C_FTimPARit4bdbFRh9PPvONkmKow3QibqArx+fVZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Lieven <pl@kamp.de>, lidongchen@tencent.com, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>

On 23 March 2018 at 20:23, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 4c2c1015905fa1d616750dfe024b4c0b35875950:
>
>   Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20180323' into staging (2018-03-23 10:20:54 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20180323a
>
> for you to fetch changes up to 09576e74dbe697c5f0a7bc2ad7b59601457a2ff4:
>
>   migration: Fix block migration flag case (2018-03-23 18:24:11 +0000)
>
> ----------------------------------------------------------------
> Migration fixes for 2.12
>
> All small fixes.  Dan's is a missing piece
> of a cleanup that finally completes something,
> and between Paolo, Dan and myself we recon it's
> still on the edge of being a bug fix.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
