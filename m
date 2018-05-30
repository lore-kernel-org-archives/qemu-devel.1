Received: from eggs.gnu.org ([2001:4830:134:3::10]:36660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fO5d2-0004a2-91
	for qemu-devel@nongnu.org; Wed, 30 May 2018 14:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fO5d1-00068N-98
	for qemu-devel@nongnu.org; Wed, 30 May 2018 14:15:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34768 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fO5d1-00067t-48
	for qemu-devel@nongnu.org; Wed, 30 May 2018 14:15:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BFD3E401EF11
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 18:15:18 +0000 (UTC)
References: <1527693912-32378-1-git-send-email-thuth@redhat.com>
	<af34cabc-9980-3f8c-c6c6-bb834c802235@redhat.com>
	<3171722d-aad9-39ad-7b24-6f80decf2747@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3846e12b-d2b3-a802-af9f-8a5d69b9794c@redhat.com>
Date: Wed, 30 May 2018 13:15:17 -0500
MIME-Version: 1.0
In-Reply-To: <3171722d-aad9-39ad-7b24-6f80decf2747@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH v2] Add a blog post about the new
 -nic parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>

On 05/30/2018 12:27 PM, Thomas Huth wrote:
> On 30.05.2018 17:57, Eric Blake wrote:
>> On 05/30/2018 10:25 AM, Thomas Huth wrote:
>>> QEMU v2.12 features a new, useful parameter called "-nic". Let's
>>> throw some light on this new parameter with a new blog post.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>
>>>  =C2=A0screenshots/2018-05-30-qemu-cli-net.png=C2=A0=C2=A0=C2=A0 | Bi=
n 0 -> 24020 bytes
>>>  =C2=A0screenshots/2018-05-30-qemu-cli-netdev.png | Bin 0 -> 13553 by=
tes
>>
>> While binaries are necessary for use from within the blog, do you also
>> have source files that can be opened under gimp or other software for
>> easily tweaking the images?
>=20
> I've created them with LibreOffice for my presentation at FOSDEM 2018
> ... I don't think we really want to check in .odp file into the
> repository, do we? It's also just some text and boxes, you can easily
> re-create that within minutes if it's ever necessary.

True, but even posting the .odp to the list (even if not stored in=20
qemu-web.git) or including a URL to your presentation in the commit=20
message (hoping that the URL is long-lasting), might save a few minutes=20
for someone down the road trying to use the image as a starting point=20
for a slightly different graphic.  (Or maybe I'm just spoiled by the GPL=20
guaranteeing access to preferred-editing forms, whether for executables=20
or for graphics - even if the blog isn't really under GPL)

>=20
> Anyway, thanks for all the other corrections! ... I'll fix it up
> tomorrow and push the article.
>=20
>   Thomas
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
