Received: from eggs.gnu.org ([2001:4830:134:3::10]:59089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHBH8-0007yZ-S3
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:15:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHBH3-0005ob-UD
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:15:22 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:33703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cHBH3-0005oM-PL
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:15:17 -0500
Received: by mail-io0-f176.google.com with SMTP id d9so42678652ioe.0
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 07:15:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161214151010.GA11881@lemon>
References: <20161214144713.11009-1-stefanha@redhat.com>
	<20161214151010.GA11881@lemon>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 14 Dec 2016 15:14:16 +0000
Message-ID: <CAJSP0QVCTTQwCaxG6W8bemOiYBCXpMR8qkJ3aztuwqop6rsUiA@mail.gmail.com>
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
To: Fam Zheng <famz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Pino Toscano <ptoscano@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On Wed, Dec 14, 2016 at 3:10 PM, Fam Zheng <famz@redhat.com> wrote:
> On Wed, 12/14 14:47, Stefan Hajnoczi wrote:
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
>> ---
>>  po/de_DE.po | 2 +-
>>  po/fr_FR.po | 2 +-
>>  po/it.po    | 4 ++--
>>  po/zh_CN.po | 2 +-
>>  4 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/po/de_DE.po b/po/de_DE.po
>> index 7dcd0dc..de27fcf 100644
>> --- a/po/de_DE.po
>> +++ b/po/de_DE.po
>> @@ -46,7 +46,7 @@ msgstr "_Vollbild"
>>
>>  #: ui/gtk.c:2032
>>  msgid "_Copy"
>> -msgstr ""
>> +msgstr "_Kopieren"
>>
>>  #: ui/gtk.c:2048
>>  msgid "Zoom _In"
>> diff --git a/po/fr_FR.po b/po/fr_FR.po
>> index 358532b..94f4a94 100644
>> --- a/po/fr_FR.po
>> +++ b/po/fr_FR.po
>> @@ -47,7 +47,7 @@ msgstr "Mode _plein =C3=A9cran"
>>
>>  #: ui/gtk.c:2032
>>  msgid "_Copy"
>> -msgstr ""
>> +msgstr "_Copier"
>>
>>  #: ui/gtk.c:2048
>>  msgid "Zoom _In"
>> diff --git a/po/it.po b/po/it.po
>> index 8eadf2f..bfae84e 100644
>> --- a/po/it.po
>> +++ b/po/it.po
>> @@ -42,11 +42,11 @@ msgstr "_Esci"
>>
>>  #: ui/gtk.c:2029
>>  msgid "_Fullscreen"
>> -msgstr ""
>> +msgstr "A t_utto schermo"
>>
>>  #: ui/gtk.c:2032
>>  msgid "_Copy"
>> -msgstr ""
>> +msgstr "_Copia"
>>
>>  #: ui/gtk.c:2048
>>  msgid "Zoom _In"
>> diff --git a/po/zh_CN.po b/po/zh_CN.po
>> index 9523cfb..3491bf2 100644
>> --- a/po/zh_CN.po
>> +++ b/po/zh_CN.po
>> @@ -47,7 +47,7 @@ msgstr "=E5=85=A8=E5=B1=8F(_F)"
>>
>>  #: ui/gtk.c:2032
>>  msgid "_Copy"
>> -msgstr ""
>> +msgstr "=E5=A4=8D=E5=88=B6 (_C)"
>
> Other entries don't have the space before the open parenthesis, could you=
 drop
> it when applying?

Yes, I'll fix it, thanks!

Stefan
