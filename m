Received: from eggs.gnu.org ([2001:4830:134:3::10]:48723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cdZox-0000Bh-Be
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 04:54:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cdZow-0001cg-BK
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 04:54:51 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:36232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cdZow-0001bS-4W
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 04:54:50 -0500
Received: by mail-wm0-x22b.google.com with SMTP id c85so13274578wmi.1
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 01:54:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170213162940.13428-1-stefanha@redhat.com>
References: <20170213162940.13428-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Feb 2017 09:54:27 +0000
Message-ID: <CAFEAcA9Hq16jN+f010mRo7JYVYD=+9E06+H6cmgRjd15QkU3eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/2] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 13 February 2017 at 16:29, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit 6311b19b5c650388745aafe1269489bd5afe4f2d:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170210' into staging (2017-02-10 18:54:30 +0000)
>
> are available in the git repository at:
>
>   git://github.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to 6eab3544f47207e976df37a85c5855bf55754713:
>
>   Makefile: Make "install" depend on "trace-events-all" (2017-02-13 13:38:31 +0000)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Fam Zheng (1):
>   Makefile: Make "install" depend on "trace-events-all"
>
> Philipp Gesang (1):
>   docs: update manpage for stderr->log rename
>
>  Makefile               | 2 +-
>  qemu-option-trace.texi | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>

Applied, thanks.

-- PMM
