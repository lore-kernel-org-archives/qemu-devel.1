Received: from eggs.gnu.org ([209.51.188.92]:41049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1grky0-0003EN-VI
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:47:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1grky0-0000FG-2G
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:47:52 -0500
Received: from fanzine.igalia.com ([91.117.99.155]:44652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1grkxz-00085w-Df
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:47:51 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <CAJ+F1CKA_WuJog780XFWXG3VHTtUzjMw8e+X_GPoWdMrQygY1Q@mail.gmail.com>
References: <cover.1549545591.git.berto@igalia.com>
	<c741408825d01f5a186901c5a8248126ffebe9fd.1549545591.git.berto@igalia.com>
	<CAMxuvayhuXEWTvJqNyKFjuae3u47MnjN4NPQ_J+vVWLK9pM5Rg@mail.gmail.com>
	<CAMxuvawnNqvUYf2Z-+8zX63wRNFp+F_A7Uo==pY_9n1HDXumqQ@mail.gmail.com>
	<w51ftszhdwg.fsf@maestria.local.igalia.com>
	<CAJ+F1CKA_WuJog780XFWXG3VHTtUzjMw8e+X_GPoWdMrQygY1Q@mail.gmail.com>
Date: Thu, 07 Feb 2019 15:47:24 +0100
Message-ID: <w51d0o3hczn.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] main-loop: Don't leak GSources
 attached to a GMainContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Thu 07 Feb 2019 03:43:59 PM CET, Marc-Andr=C3=A9 Lureau wrote:

> Well, the series conflicts with the currently queued chardev series. I
> think I will send the pullreq and let you rebase.

I'll wait for it then

Berto
