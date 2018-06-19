Received: from eggs.gnu.org ([2001:4830:134:3::10]:44352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVKRG-0001iV-Ef
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 13:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVKRF-00024v-IC
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 13:29:06 -0400
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:41127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVKRF-00024G-9y
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 13:29:05 -0400
Received: by mail-ot0-x236.google.com with SMTP id d19-v6so554580oti.8
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 10:29:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180618174538.30092-1-mark.cave-ayland@ilande.co.uk>
References: <20180618174538.30092-1-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Jun 2018 18:28:43 +0100
Message-ID: <CAFEAcA-9OV_n9Br0CwG8qzyY5O6oGUjuE7yJMRW9B7gDt+EWEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] qemu-sparc queue 20180618
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 18 June 2018 at 18:45, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> The following changes since commit 2ef2f16781af9dee6ba6517755e9073ba5799fa2:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20180615a' into staging (2018-06-15 18:13:35 +0100)
>
> are available in the git repository at:
>
>   git://github.com/mcayland/qemu.git tags/qemu-sparc-20180618
>
> for you to fetch changes up to 46bb0137b8266ab8dedc3b9712f3d246bbd686ba:
>
>   SPARC64: add icount support (2018-06-17 11:13:06 +0100)
>
> ----------------------------------------------------------------
> qemu-sparc queue
>
> ----------------------------------------------------------------
> Mark Cave-Ayland (1):
>       SPARC64: add icount support
>
> Thomas Huth (2):
>       hw/sparc64/sun4u: Fix introspection by converting prom instance_init to realize
>       hw/sparc/sun4m: Fix problems with device introspection
>

Applied, thanks.

-- PMM
