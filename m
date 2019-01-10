Received: from eggs.gnu.org ([209.51.188.92]:56490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghcL1-0003fR-Dr
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:33:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghcL0-0008Sc-6M
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:33:43 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ghcKz-0008M3-Sz
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:33:42 -0500
Received: by mail-ot1-x341.google.com with SMTP id e12so10274094otl.5
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 07:33:20 -0800 (PST)
MIME-Version: 1.0
References: <20190109015240.2116-1-fam@euphon.net>
In-Reply-To: <20190109015240.2116-1-fam@euphon.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jan 2019 15:33:08 +0000
Message-ID: <CAFEAcA93b2UTyJTN9Atswf7P75ARQExv9OTgTpt+zk9pwRYZdg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] Block/testing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <fam@euphon.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, 9 Jan 2019 at 01:53, Fam Zheng <fam@euphon.net> wrote:
>
> The following changes since commit 147923b1a901a0370f83a0f4c58ec1baffef22=
f0:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20190108-pull-req=
uest' into staging (2019-01-08 16:07:32 +0000)
>
> are available in the git repository at:
>
>   https://github.com/famz/qemu.git tags/staging-pull-request
>
> for you to fetch changes up to 4ce58d861bf740bb893bd28b974675ad3d9f98b5:
>
>   docker: Use a stable snapshot for Debian Sid (2019-01-09 09:38:34 +0800=
)
>
> ----------------------------------------------------------------
> Block/testing patches
>
> v2: Fix URL.
>     Drop BSD patch.
>
> ----------------------------------------------------------------
>
> Li Feng (1):
>   block/nvme: optimize the performance of nvme driver based on vfio-pci
>
> Philippe Mathieu-Daud=C3=A9 (1):
>   docker: Use a stable snapshot for Debian Sid
Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
