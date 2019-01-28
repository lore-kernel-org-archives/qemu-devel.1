Received: from eggs.gnu.org ([209.51.188.92]:55466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go8pC-00032i-O1
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:27:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go8p7-0008Bo-MI
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:27:49 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:46676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1go8p7-00084Z-Dd
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:27:45 -0500
Received: by mail-ot1-x335.google.com with SMTP id w25so14899777otm.13
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 07:27:31 -0800 (PST)
MIME-Version: 1.0
References: <20190125220648.28164-1-jsnow@redhat.com>
In-Reply-To: <20190125220648.28164-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 15:27:18 +0000
Message-ID: <CAFEAcA9BUy6crxUB-W617Fkm9Fxpd6NdAHPLf=KVvbq+qV1w=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] Ide patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, 25 Jan 2019 at 22:06, John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit ad7a21e81231ae64540310384fb0f87ac8758b02:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2019-01-25 17:22:20 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/jnsnow/qemu.git tags/ide-pull-request
>
> for you to fetch changes up to 4ea98d317eb442c738f898f16cfdd47a18b7ca49:
>
>   ide/via: Implement and use native PCI IDE mode (2019-01-25 14:52:12 -0500)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
