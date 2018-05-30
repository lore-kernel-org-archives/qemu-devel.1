Received: from eggs.gnu.org ([2001:4830:134:3::10]:56841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fO3XU-0002lN-Gg
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:01:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fO3XR-0000m0-Fy
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:01:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59036 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fO3XR-0000lj-BN
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:01:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DDDDB818BAFC
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 16:01:24 +0000 (UTC)
References: <1527693912-32378-1-git-send-email-thuth@redhat.com>
	<af34cabc-9980-3f8c-c6c6-bb834c802235@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <742f5060-8707-004e-fa5c-9602c6e2a18e@redhat.com>
Date: Wed, 30 May 2018 18:01:22 +0200
MIME-Version: 1.0
In-Reply-To: <af34cabc-9980-3f8c-c6c6-bb834c802235@redhat.com>
Content-Type: text/plain; charset=utf-8
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
To: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

On 30/05/2018 17:57, Eric Blake wrote:
> On 05/30/2018 10:25 AM, Thomas Huth wrote:
>> QEMU v2.12 features a new, useful parameter called "-nic". Let's
>> throw some light on this new parameter with a new blog post.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>=20
>> =C2=A0screenshots/2018-05-30-qemu-cli-net.png=C2=A0=C2=A0=C2=A0 | Bin =
0 -> 24020 bytes
>> =C2=A0screenshots/2018-05-30-qemu-cli-netdev.png | Bin 0 -> 13553 byte=
s
>=20
> While binaries are necessary for use from within the blog, do you also
> have source files that can be opened under gimp or other software for
> easily tweaking the images?

Indeed.  BTW my edits and Eric's mostly don't overlap, so you should be
good to go.

Paolo
