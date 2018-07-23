Received: from eggs.gnu.org ([2001:4830:134:3::10]:60394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhXVX-0001tL-6f
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 05:52:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhXVW-0002xV-J0
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 05:51:59 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:46586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fhXVW-0002x0-DS
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 05:51:58 -0400
Received: by mail-oi0-x241.google.com with SMTP id y207-v6so19115oie.13
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 02:51:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180720212509.18339-1-sw@weilnetz.de>
References: <20180720212509.18339-1-sw@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jul 2018 10:51:36 +0100
Message-ID: <CAFEAcA-ML2PVG6y4OESWBt-Ac2uNwvPK8Ucb5ggxJ4vcQ=ZYGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 for-3.0] po: Don't include comments with
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
Cc: QEMU Developer <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Alexander Shopov <ash@kambanaria.org>, Kevin Wolf <kwolf@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?B?w4Frb3MgS292w6Fjcw==?= <akoskovacs@gmx.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 20 July 2018 at 22:25, Stefan Weil <sw@weilnetz.de> wrote:
> Those comments change often when ui/gtk.c is changed and are not
> really useful.
>
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>
> CC'ing all translators because of the new string which still needs
> translations.
>
> v2: Only automatically created content, no new German translation.
>

Applied to master, thanks.

-- PMM
