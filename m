Received: from eggs.gnu.org ([2001:4830:134:3::10]:40979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dzjKy-0006sy-Mh
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:03:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dzjKs-0001xI-Vm
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:03:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dzjKs-0001wQ-QD
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:03:38 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20171002141341.24616-1-armbru@redhat.com>
	<20171002141341.24616-2-armbru@redhat.com>
	<CAJ+F1CL0Nfy-bjsz0XW1HhfqphUB5BdyyroiRweWfFsXDJVmOA@mail.gmail.com>
Date: Wed, 04 Oct 2017 15:03:35 +0200
In-Reply-To: <CAJ+F1CL0Nfy-bjsz0XW1HhfqphUB5BdyyroiRweWfFsXDJVmOA@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 4 Oct 2017
	12:12:20 +0200")
Message-ID: <877ewbm5eg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/11] qapi-schema: Fix
 query-vm-generation-id's doc comment markup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> On Mon, Oct 2, 2017 at 4:13 PM, Markus Armbruster <armbru@redhat.com> wro=
te:
>> Reported-by: Daniel P. Berrange <berrange@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks!

> (reviweing this patch makes me realize that the last
> expression/command in qapi-schema isn't in the generated doc..)

Oh.  We better fix that.
