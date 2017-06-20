Received: from eggs.gnu.org ([2001:4830:134:3::10]:53409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNKem-0003vZ-JK
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:01:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNKed-0008Ft-Cy
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:01:28 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:34662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNKed-0008Fn-6f
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:01:19 -0400
Received: by mail-wr0-x229.google.com with SMTP id 77so94591706wrb.1
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 08:01:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2017 16:00:57 +0100
Message-ID: <CAFEAcA-svVKHf7VhPcKp7N-SpCqaKJhX0EX6RP_6zaNGZ7vEkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/41] Misc patches for 2017-06-15
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

On 15 June 2017 at 11:52, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 3f0602927b120a480b35dcf58cf6f95435b3ae=
91:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
70613' into staging (2017-06-13 15:49:07 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 49cc0340f8be18871319ffec6efc72147e73ff0b:
>
>   vhost-user-scsi: Introduce a vhost-user-scsi sample application (2017-0=
6-15 11:18:40 +0200)
>
> ----------------------------------------------------------------
> * nbd and qemu-nbd fixes (Eric, Max)
> * nbd refactoring (Vladimir)
> * vhost-user-scsi, take N+1 (Felipe)
> * replace memory_region_set_fd with memory_region_init_ram_from_fd (Marc-=
Andr=C3=A9)
> * docs/ movement (Paolo)
> * megasas TOCTOU fixes (Paolo)
> * make async_safe_run_on_cpu work on kvm/hax accelerators (Paolo)
> * Build system and poison.h improvements (Thomas)
> * -accel thread=3Dxxx fix (Thomas)
> * move files to accel/ (Yang Zhong)
>

Applied, thanks.

-- PMM
