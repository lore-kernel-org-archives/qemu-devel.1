Received: from eggs.gnu.org ([2001:4830:134:3::10]:53621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXVyZ-0006SY-7l
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXVyY-0005Rv-52
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:47 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:43758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXVyX-0005Mw-Ll
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:45 -0500
Received: by mail-ot1-x336.google.com with SMTP id a11so2882210otr.10
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 10:44:45 -0800 (PST)
MIME-Version: 1.0
References: <20181212101632.2600-1-stefanha@redhat.com>
In-Reply-To: <20181212101632.2600-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 18:44:31 +0000
Message-ID: <CAFEAcA_iWcvvtBKcVUYaqb5uQ6Te74FWaBP3TBKMGZz5vjynog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 12 Dec 2018 at 10:16, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit bb9bf94b3e8926553290bc9a7cb84315af422086:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2018-12-11 19:18:58 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to 7ff5920717d413d8b7c3ba13d9a0805291b9e6ec:
>
>   trace: simple style changes (2018-12-12 10:04:59 +0000)
>
> ----------------------------------------------------------------
> Pull request
>
> Minor tracing improvements.
>
> ----------------------------------------------------------------
>
> Fabiano Rosas (1):
>   tracetool: Include thread id information in log backend
>
> Larry Dewey (1):
>   trace: simple style changes
>
>  trace/simple.c                   | 4 ++--
>  scripts/tracetool/backend/log.py | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
