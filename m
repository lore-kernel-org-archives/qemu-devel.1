Received: from eggs.gnu.org ([2001:4830:134:3::10]:52913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGnQG-00059H-3Z
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:19:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGnQF-0000kX-9o
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:19:28 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:36393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dGnQF-0000kA-1p
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:19:27 -0400
Received: by mail-wm0-x22d.google.com with SMTP id 7so26913464wmo.1
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 07:19:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170601192327.29712-1-quintela@redhat.com>
References: <20170601192327.29712-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Jun 2017 15:19:05 +0100
Message-ID: <CAFEAcA-9LUfJO9Nq0k9FH1O7C1hpCeTzudeGJuEmr0iXgGuYeQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/15] Migration PULL request
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

On 1 June 2017 at 20:23, Juan Quintela <quintela@redhat.com> wrote:
> Hi
>         This pull requset includes:
>         - fd leaks for return patch (peter)
>         - remove loadvm_handlers
>         - cleanup of include files for migration
>
> Please, apply.
>
> Thanks, Juan.
>
>
> The following changes since commit c077a998eb3fcae2d048e3baeb5bc592d30fddde:
>
>   Merge remote-tracking branch 'remotes/riku/tags/pull-linux-user-20170531' into staging (2017-06-01 15:50:40 +0100)
>
> are available in the git repository at:
>
>   git://github.com/juanquintela/qemu.git tags/migration/20170601
>
> for you to fetch changes up to 2c9e6fec89ff032a3f75a5a1caccc31901fb4056:
>
>   migration: Move include/migration/block.h into migration/ (2017-06-01 18:49:24 +0200)
>
> ----------------------------------------------------------------
> migration/next for 20170601

Applied, thanks.

-- PMM
