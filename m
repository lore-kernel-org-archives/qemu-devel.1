Received: from eggs.gnu.org ([2001:4830:134:3::10]:58012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edb80-0002Iz-2Z
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:23:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edb7z-0001Zw-94
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:23:08 -0500
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:38966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1edb7z-0001Zq-3x
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:23:07 -0500
Received: by mail-ot0-x230.google.com with SMTP id d9so7264582oth.6
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 04:23:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180120200358.19991-1-marcandre.lureau@redhat.com>
References: <20180120200358.19991-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2018 12:22:46 +0000
Message-ID: <CAFEAcA-5sZNimPxeSabBXmJUd_C+NLnoXbDDQ9w0tSjtbrXCyg@mail.gmail.com>
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

On 20 January 2018 at 20:03, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> The following changes since commit b384cd95eb9c6f73ad84ed1bb0717a26e29cc7=
8f:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-r=
equest' into staging (2018-01-19 16:35:25 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/elmarco/qemu.git tags/dump-pull-request
>
> for you to fetch changes up to 6f49ec4034e55dfb675a56a62c9579384f7fb8cc:
>
>   dump-guest-memory.py: fix python 2 support (2018-01-20 20:59:00 +0100)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Marc-Andr=C3=A9 Lureau (1):
>   dump-guest-memory.py: fix python 2 support
>
>  scripts/dump-guest-memory.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- PMM
