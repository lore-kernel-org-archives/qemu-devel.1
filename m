Received: from eggs.gnu.org ([209.51.188.92]:37399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gjqII-0008Ev-0y
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:52:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gjq9z-0008TX-0D
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:43:32 -0500
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:35221)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gjq9x-0008PO-0w
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:43:29 -0500
Received: by mail-qt1-x843.google.com with SMTP id v11so8424516qtc.2
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 10:43:24 -0800 (PST)
MIME-Version: 1.0
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-12-yang.zhong@intel.com>
In-Reply-To: <20190115141108.934-12-yang.zhong@intel.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 16 Jan 2019 10:43:12 -0800
Message-ID: <CAMo8BfK15Z==gwZaLz_d64m+L2rz1L7S0+X4SktDDAbdjMwzew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 11/37] hw/xtensa/Makefile.objs:
 Build xtensa_sim and xtensa_fpga conditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, sameo@linux.intel.com, =?UTF-8?B?w4Frb3MgS292w6Fjcw==?= <akoskovacs@gmx.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Tue, Jan 15, 2019 at 6:38 AM Yang Zhong <yang.zhong@intel.com> wrote:
>
> From: =C3=81kos Kov=C3=A1cs <akoskovacs@gmx.com>
>
> Add the new CONFIG_* values to default-config/xtensa*-softmmu.mak.
>
> Signed-off-by: =C3=81kos Kov=C3=A1cs <akoskovacs@gmx.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/xtensa-softmmu.mak   | 3 +++
>  default-configs/xtensaeb-softmmu.mak | 3 +++
>  hw/xtensa/Makefile.objs              | 4 ++--
>  3 files changed, 8 insertions(+), 2 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max
