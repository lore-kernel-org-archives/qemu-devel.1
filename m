Received: from eggs.gnu.org ([2001:4830:134:3::10]:51577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKQM5-0000BZ-MO
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKQM5-0000uF-0L
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:30:09 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:33010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dKQM4-0000so-Oe
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:30:08 -0400
Received: by mail-wr0-x234.google.com with SMTP id v104so98274310wrb.0
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 07:30:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170607185540.12767-1-stefanha@redhat.com>
References: <20170607185540.12767-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Jun 2017 15:29:45 +0100
Message-ID: <CAFEAcA-Ud7FdY9RkfAfQYhQ96E5cmATfX_-p=F=ezX_pxM_8YQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Tracing patches
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

On 7 June 2017 at 19:55, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit 0db1851becbefe3e50cfc03776fb1f75817376af:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.10-pull-request' into staging (2017-06-07 11:56:00 +0100)
>
> are available in the git repository at:
>
>   git://github.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to 249e9f792c4c6e52058570e83b550ec8310f621e:
>
>   simpletrace: Improve the error message if event is not declared (2017-06-07 14:34:19 +0100)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Jose Ricardo Ziviani (1):
>   simpletrace: Improve the error message if event is not declared
>
>  scripts/simpletrace.py | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Applied, thanks.

-- PMM
