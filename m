Received: from eggs.gnu.org ([209.51.188.92]:34719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hD8G2-00075S-Me
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 09:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hD8G1-0000dr-M2
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 09:54:50 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hD8G1-0000dY-5P
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 09:54:49 -0400
Received: by mail-ot1-x343.google.com with SMTP id u15so9639551otq.10
	for <qemu-devel@nongnu.org>; Sun, 07 Apr 2019 06:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190405154934.18664-1-dgilbert@redhat.com>
In-Reply-To: <20190405154934.18664-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 7 Apr 2019 14:54:36 +0100
Message-ID: <CAFEAcA8xXxtEkBe_brLMv+TTxuRAwhfHZXntd3d5bpZ2un57ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Zhang Chen <chen.zhang@intel.com>, Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>

On Fri, 5 Apr 2019 at 16:51, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 10546e09e174e0bb185b66a4c397aa845efcd36e:
>
>   Merge remote-tracking branch 'remotes/palmer/tags/riscv-for-master-4.0-rc3-v2' into staging (2019-04-05 04:50:30 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20190405a
>
> for you to fetch changes up to d013283a46e1f197594e76ed320f867067ab80b3:
>
>   migration: Fix migrate_set_parameter (2019-04-05 15:32:13 +0100)
>
> ----------------------------------------------------------------
> Migration fixes pull for 4.0
>
> A couple of fixes for crashes in colo and
> migration parameters.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
