Received: from eggs.gnu.org ([2001:4830:134:3::10]:45650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ehdAe-0000a7-Vo
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:23:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ehd9a-00079d-TW
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:22:32 -0500
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:45475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ehd9a-000795-Hd
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:21:26 -0500
Received: by mail-ot0-x22d.google.com with SMTP id 73so11450985oti.12
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 07:21:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180201111605.7392-1-marcandre.lureau@redhat.com>
References: <20180201111605.7392-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Feb 2018 11:38:14 +0000
Message-ID: <CAFEAcA_Pf+ZZ-QZr74TK+Z7+Z+3aAsDVhWy-=21R0LrS03E3Bg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/1] Dump patches
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

On 1 February 2018 at 11:16, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> The following changes since commit b05631954d6dfe93340d516660397e2c1a2a5d=
d6:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-hppa-20180131' into=
 staging (2018-01-31 15:50:29 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/elmarco/qemu.git tags/dump-pull-request
>
> for you to fetch changes up to ce6b9e421a9ab45d7e6c97af092a07c049954444:
>
>   dump-guest-memory.py: skip vmcoreinfo section if not available (2018-02=
-01 12:13:52 +0100)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Marc-Andr=C3=A9 Lureau (1):
>   dump-guest-memory.py: skip vmcoreinfo section if not available
>
>  scripts/dump-guest-memory.py | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

-- PMM
