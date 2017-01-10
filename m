Received: from eggs.gnu.org ([2001:4830:134:3::10]:53750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cQzOO-0004vH-9u
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:35:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cQzON-0006DJ-GQ
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:35:24 -0500
Received: from mail-yw0-x235.google.com ([2607:f8b0:4002:c05::235]:33007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cQzON-0006Cr-CS
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:35:23 -0500
Received: by mail-yw0-x235.google.com with SMTP id l75so39410047ywb.0
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 08:35:23 -0800 (PST)
MIME-Version: 1.0
References: <1459957128-17685-1-git-send-email-marcandre.lureau@redhat.com>
	<CAJ+F1C+wmCmSE5MP-M+a08tX10EWs9p=PbJ5=10y=GZaR4MTKA@mail.gmail.com>
	<CAJ+F1CLTZ_g=5ax2+KwZbKrRJjPCfo1mOo1ReuPnmwOX5hsQsg@mail.gmail.com>
	<CAJ+F1C+PQJJdAL9t3--0C6zdhD3Qy5SKW3Dg1yXoR_GzY4-90A@mail.gmail.com>
In-Reply-To: <CAJ+F1C+PQJJdAL9t3--0C6zdhD3Qy5SKW3Dg1yXoR_GzY4-90A@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 10 Jan 2017 16:35:12 +0000
Message-ID: <CAJ+F1CJGFNSoc1FSsTqpEb7zpofG3dkNYJCDohqR3ijcTWr1jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] vhost-user: release chardev on cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>
Cc: Nikolay Nikolaev <n.nikolaev@virtualopensystems.com>, "Michael S. Tsirkin" <mst@redhat.com>

Hi

On Tue, Sep 27, 2016 at 1:44 PM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@gmail.com> wrote:

> Hi
>
> On Thu, Aug 11, 2016 at 1:16 PM Marc-Andr=C3=A9 Lureau <
> marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Thu, Jun 16, 2016 at 1:05 PM Marc-Andr=C3=A9 Lureau <
> marcandre.lureau@gmail.com> wrote:
>
> ping
>
>
> 2nd ping, probably for-2.8 now
>
>
> 3rd ping, those are 2 one-liners, don't be shy :)
>
>
Michael, could you look and pick those 2 patches?

thanks
--=20
Marc-Andr=C3=A9 Lureau
