Received: from eggs.gnu.org ([2001:4830:134:3::10]:34178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fHAx9-00080o-Bw
	for qemu-devel@nongnu.org; Fri, 11 May 2018 12:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fHAx8-0004MX-G9
	for qemu-devel@nongnu.org; Fri, 11 May 2018 12:31:31 -0400
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:38751)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fHAx8-0004M8-Bw
	for qemu-devel@nongnu.org; Fri, 11 May 2018 12:31:30 -0400
Received: by mail-ot0-x230.google.com with SMTP id n3-v6so6894495ota.5
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 09:31:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180509175458.15642-1-richard.henderson@linaro.org>
References: <20180509175458.15642-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 May 2018 17:30:38 +0100
Message-ID: <CAFEAcA_Muga-rMERftcQREnmgXxVHYOoF6dNJYsffvggbemwFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/28] Bulk target patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, Stafford Horne <shorne@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Walle <michael@walle.cc>, Max Filippov <jcmvbkbc@gmail.com>, Richard Henderson <rth@twiddle.net>, Michael Clark <mjc@sifive.com>, Eduardo Habkost <ehabkost@redhat.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, qemu-s390x <qemu-s390x@nongnu.org>, Artyom Tarasenko <atar4qemu@gmail.com>, Palmer Dabbelt <palmer@sifive.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc <qemu-ppc@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 9 May 2018 at 18:54, Richard Henderson <richard.henderson@linaro.org> wrote:
> This contains two related patch sets from Emilio Cota, both
> touching the translation loop for these 13 targets.
>
> I promised Emilio that we'd get these merged early in this
> next development cycle to avoid conflicts.
>
>
> r~
>
>
> The following changes since commit e5cd695266c5709308aa95b1baae499e4b5d4544:
>
>   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2018-05-08 17:05:58 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/cota-target-pull-request
>
> for you to fetch changes up to 5b4f1d2db9fb0e24549054ee58c7a7d8f84ddd6e:
>
>   target/riscv: convert to TranslatorOps (2018-05-09 10:12:21 -0700)
>
> ----------------------------------------------------------------
> * Fix all next_page checks for overflow.
> * Convert six targets to the translator loop.
>

Applied, thanks.

-- PMM
