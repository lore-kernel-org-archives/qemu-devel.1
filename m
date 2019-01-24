Received: from eggs.gnu.org ([209.51.188.92]:58544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmfFn-0005mN-Ke
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmf0h-0002ko-Gt
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:25:36 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:34188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmf0d-0002gl-KO
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:25:32 -0500
Received: by mail-oi1-x236.google.com with SMTP id r62so4820693oie.1
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 05:25:30 -0800 (PST)
MIME-Version: 1.0
References: <20190123183352.11025-1-stefanha@redhat.com>
In-Reply-To: <20190123183352.11025-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Jan 2019 13:25:18 +0000
Message-ID: <CAFEAcA8PaYpHLq9ZEwQES3a3RLKSdN3KD0YfxCwGtN8b3mrA2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] MAINTAINERS: update microbit ARM board
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, Thomas Huth <thuth@redhat.com>

On Wed, 23 Jan 2019 at 18:36, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> New source files were added without corresponding ./MAINTAINERS file
> entries.  Let's get things up to date.
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
>  * Simplify using wildcard patterns [Thomas]
> ---
>  MAINTAINERS | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>



Applied to target-arm.next, thanks.

-- PMM
