Received: from eggs.gnu.org ([2001:4830:134:3::10]:52586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1f3jLS-0005z0-ND
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 10:25:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1f3jLP-0001LV-IR
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 10:25:02 -0400
Received: from mail-it0-x22f.google.com ([2607:f8b0:4001:c0b::22f]:34916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1f3jLP-0001LE-Bm
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 10:24:59 -0400
Received: by mail-it0-x22f.google.com with SMTP id v194-v6so27809138itb.0
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 07:24:58 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <eeb9a3c8-e7ee-742b-fd6a-41c364d971c4@redhat.com>
Date: Wed, 4 Apr 2018 10:24:48 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <57D8CDA1-C9D1-4CD7-99A1-203B570BF4D3@gmail.com>
References: <mailman.35816.1522678020.27992.qemu-devel@nongnu.org>
	<B4011235-0338-474D-90E4-ABDF3DC8CCB7@gmail.com>
	<eeb9a3c8-e7ee-742b-fd6a-41c364d971c4@redhat.com>
Subject: Re: [Qemu-devel] [qemu-web PATCH] download: Add instructions for
 MacPorts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Rainer M?ller <raimue@macports.org>, QEMU Developers <qemu-devel@nongnu.org>


> On Apr 4, 2018, at 7:15 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 02/04/2018 16:13, Programmingkid wrote:
>>=20
>>> On Apr 2, 2018, at 10:07 AM, qemu-devel-request@nongnu.org wrote:
>>>=20
>>> Message: 2
>>> Date: Mon, 2 Apr 2018 04:22:52 +0200
>>> From: Paolo Bonzini <pbonzini@redhat.com>
>>> To: Rainer M?ller <raimue@macports.org>, qemu-devel@nongnu.org
>>> Subject: Re: [Qemu-devel] [qemu-web PATCH] download: Add =
instructions
>>> 	for MacPorts
>>> Message-ID: <357029f4-71c0-a9f9-7bda-a5a44f609b27@redhat.com>
>>> Content-Type: text/plain; charset=3Dutf-8
>>>=20
>>> On 01/04/2018 18:22, Rainer M?ller wrote:
>>>> Signed-off-by: Rainer M?ller <raimue@macports.org>
>>>> ---
>>>> _download/macos.md | 6 +++++-
>>>> 1 file changed, 5 insertions(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/_download/macos.md b/_download/macos.md
>>>> index dbb312c..06aa811 100644
>>>> --- a/_download/macos.md
>>>> +++ b/_download/macos.md
>>>> @@ -1,6 +1,10 @@
>>>> -QEMU can be installed from Homebrew:
>>>> +QEMU can be installed from <strong>Homebrew</strong>:
>>>>=20
>>>> <pre>brew install qemu</pre>
>>>>=20
>>>> +QEMU can be installed from <strong>MacPorts</strong>:
>>>> +
>>>> +<pre>sudo port install qemu</pre>
>>>> +
>>>> QEMU requires Mac OS X 10.5 or later, but it is recommended
>>>> to use Mac OS X 10.7 or later.
>>>>=20
>>>=20
>>> Thanks for the patch!  I'm travelling but I will apply it as soon as =
I can.
>>>=20
>>> Paolo
>>=20
>> I was wondering if a link to the Mac OS X host wiki page could be =
added to this page.
>> It does have prebuilt binaries ready for use.
>>=20
>> https://wiki.qemu.org/Hosts/Mac
>=20
> Actually I believe we should remove those links.  I don't think =
hosting
> QEMU binaries on mediafire is a good idea.
>=20
> Paolo

Why not?=
