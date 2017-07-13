Received: from eggs.gnu.org ([2001:4830:134:3::10]:35529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVi5r-0002f8-NC
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:40:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVi5q-0000lf-Km
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:40:03 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:36387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dVi5q-0000km-DE
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:40:02 -0400
Received: by mail-wr0-x233.google.com with SMTP id y28so4861383wrd.3
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 10:40:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1499875776-12688-1-git-send-email-armbru@redhat.com>
References: <1499875776-12688-1-git-send-email-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jul 2017 18:39:40 +0100
Message-ID: <CAFEAcA_3mJLWWeVx_0YFFXbf51avUFwqfxs43=Z_M=1LoNpDeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/3] QAPI patches for 2017-07-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 12 July 2017 at 17:09, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit aa916e409c04cb614ec2fee8b6b33836bf5998=
bb:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.10-2017071=
1' into staging (2017-07-11 16:34:09 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-07-12
>
> for you to fetch changes up to 086ee7a6200fa5ad795b12110b5b3d5a93dcac3e:
>
>   scripts: use build_ prefix for string not piped through cgen() (2017-07=
-12 17:51:54 +0200)
>
> ----------------------------------------------------------------
> QAPI patches for 2017-07-12
>
> ----------------------------------------------------------------
> Eric Blake (2):
>       qobject: Catch another straggler for use of qdict_put_str()
>       qobject: Update coccinelle script to catch Q{INC, DEC}REF
>
> Marc-Andr=C3=A9 Lureau (1):
>       scripts: use build_ prefix for string not piped through cgen()
>

Applied, thanks.

-- PMM
