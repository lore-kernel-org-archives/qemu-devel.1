Received: from eggs.gnu.org ([2001:4830:134:3::10]:35965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ga6L2-0005kU-Vi
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 16:58:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ga6Ky-0007ZV-0W
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 16:58:40 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46732)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1ga6Kx-0007Yd-Of
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 16:58:35 -0500
Received: by mail-qt1-f194.google.com with SMTP id y20so3552099qtm.13
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 13:58:35 -0800 (PST)
MIME-Version: 1.0
References: <20181212214850.29953-1-marcandre.lureau@redhat.com>
	<20181212214850.29953-8-marcandre.lureau@redhat.com>
	<20181220200825.GO19442@habkost.net>
In-Reply-To: <20181220200825.GO19442@habkost.net>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 21 Dec 2018 01:58:23 +0400
Message-ID: <CAMxuvaxg0HquoTCoUGNsvA90WR7e+x0CrWRWYmnztuoHJqWa6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 07/28] compat: replace PC_COMPAT_3_0 &
 HW_COMPAT_3_0 macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>

On Fri, Dec 21, 2018 at 12:08 AM Eduardo Habkost <ehabkost@redhat.com> wrot=
e:
>
> On Thu, Dec 13, 2018 at 01:48:29AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Use static arrays instead.
> >
> > Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> In case you need to respin the series: I suggest squashing
> patches 07-19 together.

I don't mind, but it would be quite harder to review if it was
squashed. Up to the maintainer I would say.

thanks
