Received: from eggs.gnu.org ([2001:4830:134:3::10]:48368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e99i2-0005Gd-Oh
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:02:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e99hx-0006nF-9C
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:02:30 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:45583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e99hx-0006mx-27
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:02:25 -0400
Received: by mail-wm0-x233.google.com with SMTP id y80so8885688wmd.0
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 06:02:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171029130934.4555-1-quintela@redhat.com>
References: <20171029130934.4555-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Oct 2017 13:02:03 +0000
Message-ID: <CAFEAcA_dxC3nNKop4mVFo3sTpPe2q0itePbKdyaGh-a5PqbxLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] Migration pull request
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

On 29 October 2017 at 13:09, Juan Quintela <quintela@redhat.com> wrote:
> Hi
>
> This includes the patches reviewed form:
> - migrate_set_cache_size series (quintela)
> - migrate tests (quintela)
>
> Please apply.
>
> Later, Juan.
>
> The following changes since commit a93ece47fd9edbd4558db24300056c9a57d3bcd4:
>
>   Merge remote-tracking branch 'remotes/sstabellini/tags/xen-20171026-tag' into staging (2017-10-27 14:43:02 +0100)
>
> are available in the git repository at:
>
>   git://github.com/juanquintela/qemu.git tags/migration/20171029
>
> for you to fetch changes up to 56b4a42a2e0ae74cee629abcb82993e79deeb356:
>
>   tests: check that migration parameters are really assigned (2017-10-29 14:06:16 +0100)
>
> ----------------------------------------------------------------
> migration/next for 20171029
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
