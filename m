Received: from eggs.gnu.org ([2001:4830:134:3::10]:57721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gG7az-00076i-Gj
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 15:16:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gG7ay-0002qr-HU
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 15:16:33 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gG7aw-0002mk-Nm
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 15:16:31 -0400
Received: by mail-oi1-x243.google.com with SMTP id j202-v6so1522313oih.10
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 12:16:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181025133301.16578-1-ehabkost@redhat.com>
References: <20181025133301.16578-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Oct 2018 20:16:04 +0100
Message-ID: <CAFEAcA-qe-Sa1-XtmBdokuwX36V2PAsacYNkv1guvXzoUfC1Jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/43] Machine queue, 2018-10-25
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, Libvirt <libvir-list@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Michael Walle <michael@walle.cc>, Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>

On 25 October 2018 at 14:32, Eduardo Habkost <ehabkost@redhat.com> wrote:
> Changes v1 -> v2:
> * Fix 'make check' warnings (Igor)
>
>
> The following changes since commit 13399aad4fa87b2878c49d02a5d3bafa6c966b=
a3:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-10-22=
' into staging (2018-10-23 17:20:23 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to 8fa922c241e63f018f5b55c03ac494ae3d5fe594:
>
>   net: xgmac: convert SysBus init method to a realize method (2018-10-24 =
06:44:59 -0300)
>
> ----------------------------------------------------------------
> Machine queue, 2018-10-25
>
> * sysbus init/realize cleanups
>   (C=C3=A9dric Le Goater, Philippe Mathieu-Daud=C3=A9)
> * memory-device refactoring (David Hildenbrand)
> * -smp: deprecate incorrect CPUs topology (Igor Mammedov)
> * -numa parsing cleanups (Markus Armbruster)
> * Fix hostmem-file memory leak (Zhang Yi)
> * Typo fix (Li Qiang)
>
> ----------------------------------------------------------------
>
> Queue for Machine Core patches
>

Applied, thanks.

-- PMM
