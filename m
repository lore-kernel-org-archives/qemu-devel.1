Received: from eggs.gnu.org ([2001:4830:134:3::10]:37284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frjCL-0004U9-B9
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:22:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frjCK-00033X-IL
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:22:17 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:36193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1frjCK-000333-62
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:22:16 -0400
Received: by mail-oi0-x241.google.com with SMTP id n21-v6so25421817oig.3
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 05:22:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180817183026.32662-1-ehabkost@redhat.com>
References: <20180817183026.32662-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 13:21:54 +0100
Message-ID: <CAFEAcA86Up026RstFvm87DzEA0mTK7vR+hW9ciPWi3RKNjpbBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Machine queue, 2018-08-17
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On 17 August 2018 at 19:30, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit bb16c0412a572c2c9cd44496deb3ad430bc49c1a:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180816' into staging (2018-08-16 14:35:50 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to 907aac2f6af6ef775367c368b87cc1720e39d407:
>
>   fw_cfg: ignore suffixes in the bootdevice list dependent on machine class (2018-08-16 22:27:43 -0300)
>
> ----------------------------------------------------------------
> Machine queue, 2018-08-17
>
> * Allow machine classes to specify if boot device suffixes should
>   be ignored by get_boot_devices_list()
> * Tiny coding style fixup
>
> ----------------------------------------------------------------
>
> Queue for Machine Core patches
>
>
> Dou Liyang (1):
>   machine: Fix coding style at machine_run_board_init()
>
> Mark Cave-Ayland (2):
>   sysbus: always allow explicit_ofw_unit_address() to override address
>     generation
>   fw_cfg: ignore suffixes in the bootdevice list dependent on machine
>     class

Applied, thanks.

-- PMM
