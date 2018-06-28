Received: from eggs.gnu.org ([2001:4830:134:3::10]:53585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYaAW-0002ys-4p
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:53:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYaAV-0001Pp-BV
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:53:16 -0400
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:45468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYaAV-0001OQ-30
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:53:15 -0400
Received: by mail-ot0-x22d.google.com with SMTP id k3-v6so6872460otl.12
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 09:53:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180627174435.31800-1-alistair.francis@wdc.com>
References: <20180627174435.31800-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Jun 2018 17:52:53 +0100
Message-ID: <CAFEAcA8rRRTYhS-JNBTeJfZDydYEdNpab_TPieyrKcV5cad0SA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] riscv-pull queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Alistair Francis <alistair23@gmail.com>

On 27 June 2018 at 18:44, Alistair Francis <alistair.francis@wdc.com> wrote:
> The following changes since commit 00928a421d47f49691cace1207481b7aad31b1f1:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180626' into staging (2018-06-26 18:23:49 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:alistair23/qemu.git tags/pull-riscv-pull-20180627
>
> for you to fetch changes up to e5f5e16b67dc8a342f937bc00ebb2a6475e35050:
>
>   hw/riscv/sifive_u: Connect the Cadence GEM Ethernet device (2018-06-27 10:35:19 -0700)
>

Something strange is up with the key used to sign this:

$ gpg --recv-keys 7048B74B4C1B39E4
gpg: requesting key 0x7048B74B4C1B39E4 from hkp server keys.gnupg.net
gpg: key 0xE48E3BC2C123ED93: no valid user IDs
gpg: this may be caused by a missing self-signature
gpg: Total number processed: 1
gpg:           w/o user IDs: 1

thanks
-- PMM
