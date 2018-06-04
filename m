Received: from eggs.gnu.org ([2001:4830:134:3::10]:36598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPlZl-0007bE-Pf
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:14:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPlZk-0002ji-QS
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:14:53 -0400
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:44151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fPlZk-0002j2-Kd
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:14:52 -0400
Received: by mail-ot0-x236.google.com with SMTP id w13-v6so9306321ote.11
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 02:14:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180601171521.1770-1-pbonzini@redhat.com>
References: <20180601171521.1770-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Jun 2018 10:14:31 +0100
Message-ID: <CAFEAcA_j6nu3KA6ObEQ19yCDi_AYui7-5Ua2V=UV8bMy99FYVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/56] Misc patches for 2018-05-31
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

On 1 June 2018 at 18:15, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 5a5c383b1373aeb6c87a0d6060f6c3dc7c5308=
2b:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-2.13-=
pull-request' into staging (2018-05-25 10:04:36 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to b5dfdb082fc350f3e68dfa61dc988d97cad28cfe:
>
>   hw: make virtio devices configurable via default-configs/ (2018-06-01 1=
5:14:31 +0200)
>
> ----------------------------------------------------------------
> * Linux header upgrade (Peter)
> * firmware.json definition (Laszlo)
> * IPMI migration fix (Corey)
> * QOM improvements (Alexey, Philippe, me)
> * Memory API cleanups (Jay, me, Tristan, Peter)
> * WHPX fixes and improvements (Lucian)
> * Chardev fixes (Marc-Andr=C3=A9)
> * IOMMU documentation improvements (Peter)
> * Coverity fixes (Peter, Philippe)
> * Include cleanup (Philippe)
> * -clock deprecation (Thomas)
> * Disable -sandbox unless CONFIG_SECCOMP (Yi Min Zhao)
> * Configurability improvements (me)
>

Applied, thanks.

-- PMM
