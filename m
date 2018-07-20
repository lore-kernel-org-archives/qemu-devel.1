Received: from eggs.gnu.org ([2001:4830:134:3::10]:50615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fgWyG-00063Z-C5
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 11:05:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fgWyF-0000R0-LT
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 11:05:28 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:41509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fgWyF-0000Ql-GS
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 11:05:27 -0400
Received: by mail-oi0-x241.google.com with SMTP id k12-v6so21876969oiw.8
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 08:05:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180718061027.10980-1-sw@weilnetz.de>
References: <20180718061027.10980-1-sw@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Jul 2018 16:05:06 +0100
Message-ID: <CAFEAcA9GD5ApmZJUeCMfTZnQJsFaKbceP6G2Q_QXCWYm8mow2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.0] po: Don't include comments with
 location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: QEMU Developer <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Alexander Shopov <ash@kambanaria.org>, Kevin Wolf <kwolf@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?B?w4Frb3MgS292w6Fjcw==?= <akoskovacs@gmx.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>, Fam Zheng <famz@redhat.com>

On 18 July 2018 at 07:10, Stefan Weil <sw@weilnetz.de> wrote:
> Those comments change often when ui/gtk.c is changed and are not
> really useful.
>
> Add also a new translation for German (still to be done for all other
> languages).
>
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---

I think I agree with Philippe that we should split out the
mechanical change from the significant one.

thanks
-- PMM
