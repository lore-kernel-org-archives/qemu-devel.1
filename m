Received: from eggs.gnu.org ([209.51.188.92]:56767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghzwR-0006lJ-8M
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:45:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghzwQ-0001bo-AQ
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:45:55 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:34539)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ghzwP-0001ZM-RQ
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:45:54 -0500
Received: by mail-oi1-x22d.google.com with SMTP id r62so12728770oie.1
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 08:45:53 -0800 (PST)
MIME-Version: 1.0
References: <20190111145058.26715-1-pbonzini@redhat.com>
In-Reply-To: <20190111145058.26715-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Jan 2019 16:45:41 +0000
Message-ID: <CAFEAcA8fgEJ9TqNb99ax3saW01fdVKAt3A7SLivkVtD_3Qq6RA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v8 00/35] Misc patches for 2018-12-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, 11 Jan 2019 at 14:52, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit a311f891abf3833c1e4c5a62a6e5b0f1b81f22=
c3:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.0-p=
ull-request' into staging (2019-01-10 17:49:54 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 7d37435bd5801bb49e1c4b550fedd1c5fe143131:
>
>   avoid TABs in files that only contain a few (2019-01-11 15:46:56 +0100)
>
> ----------------------------------------------------------------
> * HAX support for Linux hosts (Alejandro)
> * esp bugfixes (Guenter)
> * Windows build cleanup (Marc-Andr=C3=A9)
> * checkpatch logic improvements (Paolo)
> * coalesced range bugfix (Paolo)
> * switch testsuite to TAP (Paolo)
> * QTAILQ rewrite (Paolo)
> * block/iscsi.c cancellation fixes (Stefan)
> * improve selection of the default accelerator (Thomas)
>
> ----------------------------------------------------------------
> v7->v8: dropped Debian dockerfile changes altogether
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
