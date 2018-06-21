Received: from eggs.gnu.org ([2001:4830:134:3::10]:51470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fW3Dy-0000OG-7M
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:18:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fW3Dx-0004pN-CJ
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:18:22 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fW3Dx-0004oh-4O
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:18:21 -0400
Received: by mail-wm0-x243.google.com with SMTP id v131-v6so7562122wma.1
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 10:18:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87y3f8hyse.fsf@dusky.pond.sub.org>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
	<87y3f8hyse.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 21 Jun 2018 19:18:19 +0200
Message-ID: <CAJ+F1CKp_Q9eH84rB0O9btShLD1VOp2mKDiD0TEm7HHGNxJuug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/49] qapi: add #if pre-processor
 conditions to generated code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Thu, Jun 21, 2018 at 6:47 PM, Markus Armbruster <armbru@redhat.com> wrot=
e:
> I think we can bite off a digestible part of this series:
> target-independent top-level conditionals.  I think that's PATCH
> 01-14,31 and applicable parts of 35-37.  The idea is to merge that part
> quickly, then deal with the (less daunting) remainder.  Marc-Andr=C3=A9, =
if
> you agree with that plan, please respin just that part.  I can continue
> review of the remainder without a rebase.
>

That's ok with me, I'll work on it.
thanks


--=20
Marc-Andr=C3=A9 Lureau
