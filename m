Received: from eggs.gnu.org ([2001:4830:134:3::10]:45556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e7J9C-0001Sg-MY
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 06:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e7J9B-0003lb-TA
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 06:42:54 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:47842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e7J9B-0003l1-LT
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 06:42:53 -0400
Received: by mail-wr0-x244.google.com with SMTP id y39so23543807wrd.4
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 03:42:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1508006342-5304-8-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1508006342-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1508006342-5304-8-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Oct 2017 11:42:32 +0100
Message-ID: <CAFEAcA-S8ZYzYmNO1_hq17XQx0U65z-3+WeJPcS5e9+5pGd17Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCHv3 07/13] esp: move TYPE_ESP and
 SysBusESPState from esp.c to esp.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Artyom Tarasenko <atar4qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On 14 October 2017 at 19:38, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> This enables them to be used outside of esp.c.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> CC: Paolo Bonzini <pbonzini@redhat.com>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
