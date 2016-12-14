Received: from eggs.gnu.org ([2001:4830:134:3::10]:43047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHBxb-0004c1-0b
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:59:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHBxY-0005Ul-0k
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:59:15 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:36768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cHBxX-0005UH-PL
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:59:11 -0500
Received: by mail-it0-f66.google.com with SMTP id n68so431456itn.3
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 07:59:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <22da7375-6a66-0340-4208-b4d04b5ce49f@vivier.eu>
References: <20161214144713.11009-1-stefanha@redhat.com>
	<22da7375-6a66-0340-4208-b4d04b5ce49f@vivier.eu>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 14 Dec 2016 15:58:09 +0000
Message-ID: <CAJSP0QW-zPDGrFoyE3XLd-SNKt261+AJPS5k1jxZyr8jNkvxXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.8] po: add missing translations in de, fr, it,
 zh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Pino Toscano <ptoscano@redhat.com>

On Wed, Dec 14, 2016 at 3:41 PM, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 14/12/2016 =C3=A0 15:47, Stefan Hajnoczi a =C3=A9crit :
>> There are missing translations for the new "Copy" menu item.
>>
>> The following people provided them to me on IRC just in time for the
>> QEMU 2.8 release:
>>
>>  * de_DE - Stefan Hajnoczi <stefanha@redhat.com>
>>  * fr_FR - Laurent Vivier <laurent@vivier.eu>
>>  * it    - Pino Toscano <ptoscano@redhat.com>
>>  * zh_CN - Fam Zheng <famz@redhat.com>
>>
>> Reported-by: Kevin Wolf <kwolf@redhat.com>
>> Cc: Fam Zheng <famz@redhat.com>
>> Cc: Pino Toscano <ptoscano@redhat.com>
>> Cc: Laurent Vivier <laurent@vivier.eu>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>
> "Copier" is OK now, but it seems we have some problems with the accents.
> I don't know why.

It could be an email encoding issue.  On disk I see the proper UTF-8 charac=
ters.

You could try my git branch to avoid email issues:
https://github.com/stefanha/qemu/tree/missing-translations-2.8

Stefan
