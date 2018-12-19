Received: from eggs.gnu.org ([2001:4830:134:3::10]:54402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1gZdad-0004df-Qx
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:16:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1gZdac-0007Wk-Ot
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:16:51 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:34167)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1gZdac-0007WE-IW
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:16:50 -0500
Received: by mail-ot1-x331.google.com with SMTP id t5so19467074otk.1
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 07:16:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181122141741.11108-1-marcandre.lureau@redhat.com>
References: <20181122141741.11108-1-marcandre.lureau@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 19 Dec 2018 16:16:48 +0100
Message-ID: <CAL1e-=h_YXP8Y-narAHaoB5GU9s3U8ehEO+mqQUAbuqFjGp6Kw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docs: apply some qemu.org-like CSS style
 to HTML
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: pbonzini@redhat.com, sw@weilnetz.de, qemu-devel@nongnu.org

On Nov 22, 2018 3:18 PM, "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.=
com>
wrote:
>
> Style a bit the HTML documents, to make them look like qemu.org pages.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  Makefile                     |   2 +
>  docs/texinfo-extra-head.html |   7 ++
>  docs/texinfo.css             | 226 +++++++++++++++++++++++++++++++++++
>  3 files changed, 235 insertions(+)
>  create mode 100644 docs/texinfo-extra-head.html
>  create mode 100644 docs/texinfo.css
>

Marc-Andr=C3=A9,

I salute these effort, and also my eyes say thank you to you.

I just have a suggestion that command line examples, like this one:

qemu-system-i386 [options] [disk_image]

have a little larger letters. (maybe it is just my system, I see them as if
their size is almost twice smaller than regular text size)

Thanks again!
Aleksandar
