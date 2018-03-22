Received: from eggs.gnu.org ([2001:4830:134:3::10]:53951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ez0mq-0003mQ-5O
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 10:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ez0me-0003HI-Q6
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 10:01:48 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:34833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ez0me-0003Gs-Hf
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 10:01:36 -0400
Received: by mail-ot0-x243.google.com with SMTP id r30-v6so9535338otr.2
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 07:01:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180321143754.5606-1-marcandre.lureau@redhat.com>
References: <20180321143754.5606-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Mar 2018 14:01:13 +0000
Message-ID: <CAFEAcA-ycz9aJCdbcYK0WdmAYrk9h0Tps0tYh4PvCd4ew5RRuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] Dump patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 March 2018 at 14:37, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> The following changes since commit f1a63fcfcd92c88be8942b5ae71aef9749a4f1=
35:
>
>   Update version for v2.12.0-rc0 release (2018-03-20 19:04:22 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/elmarco/qemu.git tags/dump-pull-request
>
> for you to fetch changes up to 4b17bc933fc26f7a4a306a43597f4d97e3c2dc38:
>
>   dump-guest-memory: more descriptive lookup_type failure (2018-03-21 15:=
02:00 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------
>
> Andrew Jones (1):
>   dump-guest-memory: more descriptive lookup_type failure
>
> Yasmin Beatriz (1):
>   dump.c: allow fd_write_vmcore to return errno on failure
>
>  scripts/dump-guest-memory.py |  7 ++++++-
>  dump.c                       | 23 ++++++++++++++---------
>  2 files changed, 20 insertions(+), 10 deletions(-)
>
> --
> 2.16.2.521.g9aa15f885a

Applied, thanks.

-- PMM
