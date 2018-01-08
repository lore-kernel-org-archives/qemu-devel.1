Received: from eggs.gnu.org ([2001:4830:134:3::10]:45247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYf8J-0000NW-PO
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:39:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYf8I-0004yo-Qc
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:39:03 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:34308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYf8I-0004yF-Kn
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:39:02 -0500
Received: by mail-oi0-x244.google.com with SMTP id a70so2373048oib.1
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 13:39:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180102140625.14477-1-marcandre.lureau@redhat.com>
References: <20180102140625.14477-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2018 21:38:41 +0000
Message-ID: <CAFEAcA8OTcO=OhgU-KFoQSophwWB_iuk0NVK=o=164c=w17exQ@mail.gmail.com>
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

On 2 January 2018 at 14:06, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> The following changes since commit 281f327487c9c9b1599f93c589a408bbf4a651=
b8:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.12-pull-re=
quest' into staging (2017-12-22 00:11:36 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/elmarco/qemu.git tags/dump-pull-request
>
> for you to fetch changes up to c3b1642b9b6b3ba4314d6be3be509d396372cfd5:
>
>   dump-guest-memory.py: fix "You can't do that without a process to debug=
" (2018-01-02 14:49:54 +0100)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Marc-Andr=C3=A9 Lureau (2):
>   dump: fix note_name_equal()
>   dump-guest-memory.py: fix "You can't do that without a process to
>     debug"
>
>  scripts/dump-guest-memory.py | 3 +--
>  dump.c                       | 7 +------
>  hw/misc/vmcoreinfo.c         | 3 +++
>  3 files changed, 5 insertions(+), 8 deletions(-)

Applied, thanks.

-- PMM
