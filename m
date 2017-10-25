Received: from eggs.gnu.org ([2001:4830:134:3::10]:37319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e7NlJ-0005rF-Ji
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e7NlI-0003Fg-OK
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:38:33 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:54411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e7NlI-0003Dq-Fk
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:38:32 -0400
Received: by mail-wm0-x233.google.com with SMTP id r68so2789156wmr.3
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 08:38:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171023160800.20540-1-quintela@redhat.com>
References: <20171023160800.20540-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Oct 2017 16:38:10 +0100
Message-ID: <CAFEAcA-PfdD+qQhhepEDFzGD0oqdRDFz62cYHX_cNuykedht1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/21] Migration pull request
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

On 23 October 2017 at 17:07, Juan Quintela <quintela@redhat.com> wrote:
> Hi
>
> This includes:
>
> - Postocpy bitmap on destination (alexey)
> - pre-switchover patches (dave)
> - ram_state cleanup (peter)
> - reviewed part of set_migrate_state (me)
> - grammar fix from eric
> - patch reviewed from multifd
>
> Please, Apply.
>
> The following changes since commit e822e81e350825dd94f41ee2538ff1432b812eb9:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2017-10-20 15:04:00 +0100)
>
> are available in the git repository at:
>
>   git://github.com/juanquintela/qemu.git tags/migration/20171023
>
> for you to fetch changes up to 87db1a7d89677e3dbc8b3763e417b9376009bdbb:
>
>   migration: Improve migration thread error handling (2017-10-23 18:03:43 +0200)
>
> ----------------------------------------------------------------
> migration/next for 20171023
>

Applied, thanks.

-- PMM
