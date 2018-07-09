Received: from eggs.gnu.org ([2001:4830:134:3::10]:49029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcco1-0007vo-39
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 16:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcco0-0004ob-8H
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 16:30:45 -0400
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:44873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fccnz-0004o4-Qh
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 16:30:44 -0400
Received: by mail-oi0-x229.google.com with SMTP id s198-v6so38358720oih.11
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 13:30:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180709172206.6334-1-ehabkost@redhat.com>
References: <20180709172206.6334-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jul 2018 21:30:22 +0100
Message-ID: <CAFEAcA_WUkekKogZ5EFino1vzS=SyZ4KfWMuGfzzY7oVwAJX+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] x86 fix for -rc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>

On 9 July 2018 at 18:22, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit 43a473993fd9378bf850dcafa68eb6dee8c300f8:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-07-06 18:18:08 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-next-pull-request
>
> for you to fetch changes up to 97e50dd013fbf2643a3b3f693a72159de5d25b50:
>
>   pc: Fix typo on PC_COMPAT_2_12 (2018-07-09 14:20:57 -0300)
>
> ----------------------------------------------------------------
> x86 fix for -rc0
>
> * Fix EPYC-IBPB compat code
>
> ----------------------------------------------------------------
>
> Eduardo Habkost (1):
>   pc: Fix typo on PC_COMPAT_2_12
>
>  include/hw/i386/pc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
Applied, thanks.

-- PMM
