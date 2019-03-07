Received: from eggs.gnu.org ([209.51.188.92]:35625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1h1rWh-00077a-Ro
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:49:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1h1rWg-0002Aa-9x
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:49:27 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1h1rWg-00029j-3Q
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:49:26 -0500
Received: by mail-wm1-x342.google.com with SMTP id a188so8870713wmf.3
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 03:49:25 -0800 (PST)
MIME-Version: 1.0
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<9fb589af-a78e-6eeb-ca1c-a5049c5ac5ab@redhat.com>
	<CAFEAcA_RQU+HYczN4Z=vEL8U31---GTi_HOxg8y50pzX8p+p7Q@mail.gmail.com>
	<20190307112933.GA2853@work-vm>
In-Reply-To: <20190307112933.GA2853@work-vm>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 7 Mar 2019 12:49:12 +0100
Message-ID: <CAJ+F1CKkhfazv9ZpTj79mBLdFrEM-+6KJptywR9vC8H+rOAgTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

Hi

On Thu, Mar 7, 2019 at 12:29 PM Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:

> Having said that, the counterpoint in Meson is that it's build
> directories seem tobe exact-meson version dependent; doing a minor
> host update and you find you have to nuke your build directories.
>

I have heard from meson developers at FOSDEM that this kind
meson-version problems were recently addressed (sorry, I don't have
any pointers)

--=20
Marc-Andr=C3=A9 Lureau
