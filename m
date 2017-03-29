Received: from eggs.gnu.org ([2001:4830:134:3::10]:42327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ctGLv-0008Tf-II
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 12:21:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ctGLr-0003k9-Kb
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 12:21:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ctGLr-0003jC-EQ
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 12:21:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 62EDE80490
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 16:21:38 +0000 (UTC)
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<4a56f716-3528-ddd4-f8c4-f3f6b23c469a@redhat.com>
	<bbc2671a-42dd-aa2a-0f03-6a4a487cb8f5@redhat.com>
	<fddf5055-c458-3893-9a18-5b0701e5431a@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3044459b-65a3-ca78-c009-15de9823704a@redhat.com>
Date: Wed, 29 Mar 2017 18:21:31 +0200
MIME-Version: 1.0
In-Reply-To: <fddf5055-c458-3893-9a18-5b0701e5431a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Deprecating old machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On 27.03.2017 21:04, John Snow wrote:
>=20
> On 03/27/2017 04:06 AM, Thomas Huth wrote:
>> On 24.03.2017 23:10, John Snow wrote:
[...]
>>> I have a list of things I want to axe...
>>
>> I've started a Wiki page with such a list here:
>>
>> http://wiki.qemu-project.org/Features/LegacyRemoval
>>
>> Feel free to amend!
>=20
> Absolutely!

By the way, what about old machine types like "pc-0.10" ? Do we want to
carry them along forever (e.g. since it is not too complicated to
maintain?), or shall we get rid of those one day (e.g. with QEMU 3.0), to=
o?

 Thomas
