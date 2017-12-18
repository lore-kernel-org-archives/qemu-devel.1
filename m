Received: from eggs.gnu.org ([2001:4830:134:3::10]:54860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eQybC-0006Y0-D3
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 11:49:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eQybA-0004wM-LD
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 11:49:05 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:35869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eQybA-0004v5-Fk
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 11:49:04 -0500
Received: by mail-ot0-x243.google.com with SMTP id d5so13898113oti.3
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 08:49:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <cover.1513606137.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
	<cover.1513606137.git.mjt@msgid.tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Dec 2017 16:48:42 +0000
Message-ID: <CAFEAcA_qw3t5rC0_cj__7ax5FmYdD12e3FQSB3xBccVEH-x2Hw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v3 00/60] Trivial patches for 2017-12-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 18 December 2017 at 14:13, Michael Tokarev <mjt@tls.msk.ru> wrote:
> Here's another, 3rd, attempt for a pull request for the trivial-patches
> tree. Not resending whole thing once again.
>
> I've removed the patch that caused previous failure, which was
> =C2=ABhw/alpha/typhoon: simplify using the "unimplemented" sysbus device=
=C2=BB,
> and updated another patch, =C2=ABhw/tpm: remove old i386 dependency=C2=BB
> to resolve slight resolve conflicts, also rebased on top of current maste=
r.
>
> Please consider pulling.
>
> Thanks,
>
> /mjt
>
> The following changes since commit 411ad78115ebeb3411cf4b7622784b93dfabe2=
59:
>
>   Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2017-1=
2-15-1' into staging (2017-12-17 15:27:41 +0000)
>
> are available in the git repository at:
>
>   git://git.corpit.ru/qemu.git tags/trivial-patches-fetch
>
> for you to fetch changes up to c0578de60fcc3a07a881e9c4b7b8262faf6abbc7:
>
>   misc: drop old i386 dependency (2017-12-18 17:07:03 +0300)
>
> ----------------------------------------------------------------
> trivial patches for 2017-12-18

Applied, thanks.

-- PMM
