Received: from eggs.gnu.org ([209.51.188.92]:36925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guJPo-00061Y-2I
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:59:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guJPm-0003l6-Vz
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:59:07 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:45247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guJPm-0003kb-RQ
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:59:06 -0500
Received: by mail-ot1-x334.google.com with SMTP id 32so11224074ota.12
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 07:59:06 -0800 (PST)
MIME-Version: 1.0
References: <20190213183153.23746-1-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190213183153.23746-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 15:58:54 +0000
Message-ID: <CAFEAcA_6XzAfm51sGKPptGcrX+hkohv2eMfQqtbtTy6qnNU=DQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] Fix slirp on windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>

On Wed, 13 Feb 2019 at 18:31, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
>
> The following changes since commit 0b5e750bea635b167eb03d86c3d9a09bbd43bc=
06:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2019-02-12 10:53:37 +0000)
>
> are available in the Git repository at:
>
>   https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to adf1add2927c7bb652a168f5be627102921cf35f:
>
>   slirp: wrap the remaining socket functions (2019-02-12 20:49:13 +0100)
>
> ----------------------------------------------------------------
> Fix slirp on windows
>
> Marc-Andr=C3=A9 Lureau (2):
>   slirp: remove slirp_ prefix for socket wrappers
>   slirp: wrap the remaining socket functions
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
