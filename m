Received: from eggs.gnu.org ([2001:4830:134:3::10]:45538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eC9ma-0003pP-Tz
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 14:43:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eC9mX-0001FN-N1
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 14:43:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46076
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eC9mX-0001F2-H1
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 14:43:33 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA7JfrOQ101738
	for <qemu-devel@nongnu.org>; Tue, 7 Nov 2017 14:43:28 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e3gec80gn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 14:43:27 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 7 Nov 2017 12:43:26 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <151007441527.31225.4851895159440081867@sif>
References: <20171107113716.14244-1-chen_han_xiao@126.com>
	<151007441527.31225.4851895159440081867@sif>
Date: Tue, 07 Nov 2017 13:43:20 -0600
Message-Id: <151008380060.31225.11831036511036878637@sif>
Subject: Re: [Qemu-devel] [Resend][PATCH] qapi-docs: fix a comment typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chen Hanxiao <chen_han_xiao@126.com>, armbru@redhat.com
Cc: qemu-devel@nongnu.org

Quoting Michael Roth (2017-11-07 11:06:55)
> Quoting Chen Hanxiao (2017-11-07 05:37:16)
> > From: Chen Hanxiao <chenhanxiao@gmail.com>
> > =

> >   s/Subection/Subsection
> > =

> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>
> =

> Thanks, applied to qga tree:
>   https://github.com/mdroth/qemu/commits/qga

Actually looks like Markus picked this up yesterday, and I plucked it
into the wrong tree anyway =3D\

> =

> > ---
> >  docs/devel/qapi-code-gen.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > =

> > diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> > index f04c63fe82..06ab699066 100644
> > --- a/docs/devel/qapi-code-gen.txt
> > +++ b/docs/devel/qapi-code-gen.txt
> > @@ -63,7 +63,7 @@ Comment text starting with '=3D' is a section title:
> > =

> >  Double the '=3D' for a subsection title:
> > =

> > -    # =3D=3D Subection title
> > +    # =3D=3D Subsection title
> > =

> >  '|' denotes examples:
> > =

> > -- =

> > 2.13.5
> > =

> =

>=20
