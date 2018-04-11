Received: from eggs.gnu.org ([2001:4830:134:3::10]:51329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6BMn-0002rL-Rs
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 04:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6BMm-0008Ey-Vp
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 04:44:33 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:45477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6BMm-0008Ek-Op
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 04:44:32 -0400
Received: by mail-oi0-x244.google.com with SMTP id 71-v6so952326oie.12
	for <qemu-devel@nongnu.org>; Wed, 11 Apr 2018 01:44:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180410150329.47586-1-dgilbert@redhat.com>
References: <20180410150329.47586-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Apr 2018 09:44:11 +0100
Message-ID: <CAFEAcA-BeAOBQ-EvFm3t=Dreu8Rxy+2PB_K1WGPn5OhaiZ843A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>

On 10 April 2018 at 16:03, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit df6378eb0e6cfd58a22a1c3ff8fa4a9039f1eaa8:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180410-pull-request' into staging (2018-04-10 14:04:27 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20180410a
>
> for you to fetch changes up to a18a73d7472e6ff5bc1e5f7fb9f7a42464295d03:
>
>   Revert "migration: Don't activate block devices if using -S" (2018-04-10 15:28:42 +0100)
>
> ----------------------------------------------------------------
> Migration reversion pull for 2.12
>
> One to revert after we decided it needs some more thinking.
>
> ----------------------------------------------------------------
> Dr. David Alan Gilbert (1):
>       Revert "migration: Don't activate block devices if using -S"
>
>  migration/migration.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
>

Applied, thanks.

-- PMM
