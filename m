Received: from eggs.gnu.org ([2001:4830:134:3::10]:54542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffRpj-0001zq-RI
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffRpj-0002Fc-1d
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:24:11 -0400
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:36216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffRpi-0002FJ-Ra
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:24:10 -0400
Received: by mail-oi0-x232.google.com with SMTP id r16-v6so2769284oie.3
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 08:24:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180705182001.16537-15-mdavidsaver@gmail.com>
References: <20180705182001.16537-1-mdavidsaver@gmail.com>
	<20180705182001.16537-15-mdavidsaver@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jul 2018 16:23:49 +0100
Message-ID: <CAFEAcA87DkMMeuvHB=NdtPmuMJ0QUOy73s9fe1V3zFYjZvysZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 14/14] tests: drop ds1338-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Antoine Mathys <barsamin@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>

On 5 July 2018 at 19:20, Michael Davidsaver <mdavidsaver@gmail.com> wrote:
> redundant to ds-rtc-*-test.c
>
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> ---
>  tests/Makefile.include |  2 --
>  tests/ds1338-test.c    | 75 --------------------------------------------------
>  2 files changed, 77 deletions(-)
>  delete mode 100644 tests/ds1338-test.c
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
