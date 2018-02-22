Received: from eggs.gnu.org ([2001:4830:134:3::10]:42208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linus.walleij@linaro.org>) id 1eoswv-0001WO-Gp
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:38:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linus.walleij@linaro.org>) id 1eoswu-0006Bn-UR
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:38:21 -0500
Received: from mail-io0-x22a.google.com ([2607:f8b0:4001:c06::22a]:42207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
	id 1eoswu-0006Au-Oa
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:38:20 -0500
Received: by mail-io0-x22a.google.com with SMTP id u84so6422500iod.9
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 07:38:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1519053606-9817-3-git-send-email-minyard@acm.org>
References: <CACRpkda9B=frmS0QF429p-q+KoCKG=5NON-kQ0Rt-nba2powRA@mail.gmail.com>
	<1519053606-9817-1-git-send-email-minyard@acm.org>
	<1519053606-9817-3-git-send-email-minyard@acm.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 16:38:19 +0100
Message-ID: <CACRpkdZcdiPW5gWVxmQci48dUY1zseH=N=Tf7tj8EvzgDpeBUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/2] i2c: Move the bus class to i2c.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, Corey Minyard <cminyard@mvista.com>

On Mon, Feb 19, 2018 at 4:20 PM,  <minyard@acm.org> wrote:
> From: Corey Minyard <cminyard@mvista.com>
>
> Some devices need access to it.
>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
